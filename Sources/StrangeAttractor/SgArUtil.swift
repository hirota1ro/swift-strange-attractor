import Foundation
import Cocoa

struct VelAccResolver {
    let v: Span
    let a: Span
    let b: SgArBrightnessResolver
}
extension VelAccResolver: SgArColorResolver {
    func resolve(point: CGPoint, velocity: CGPoint, acceleration: CGPoint) -> NSColor {
        let vel = velocity.norm
        let acc = acceleration.norm
        let hue = v.normalized(vel)
        let sat = easeOutQuad(a.normalized(acc))
        let bri = b.resolve(hue: hue, saturation: sat)
        return NSColor(hue: hue, saturation: sat, brightness: bri, alpha: 1)
    }

    func easeOutQuad(_ x: CGFloat) -> CGFloat {
	return 1 - (1 - x) * (1 - x)
    }
}

protocol SgArBrightnessResolver {
    func resolve(hue: CGFloat, saturation sat: CGFloat) -> CGFloat
}
struct WhiteBackBrightnessResolver: SgArBrightnessResolver {
    func resolve(hue: CGFloat, saturation sat: CGFloat) -> CGFloat { return sat }
}
struct BlackBackBrightnessResolver: SgArBrightnessResolver {
    func resolve(hue: CGFloat, saturation sat: CGFloat) -> CGFloat { return 1 }
}

protocol SgArSearchSource {
    func create() -> SgArDriver
}

struct SgArSearchUtil {
    let count: Int
    let iterations: Int
    let threshold: Float
    let concession: Int
}

extension SgArSearchUtil {

    func search(source: SgArSearchSource) -> [SgArDriver] {
        let progress = MeasurementProgress(DeterminableProgress())
        progress.begin()
        defer { progress.end() }
        let algorithm = SgAr()
        var threshold = self.threshold
        var failed: Int = 0
        var found: [SgArDriver] = []
        while found.count < count {
            let driver = source.create()
            do {
                let vis = SgArVisual()
                try algorithm.draw(n: iterations, driver: driver, plotter: vis, progress: EmptyProgress())
                if vis.divergent {
                    print("skip: divergent")
                    failed += 1
                } else {
                    let paint = SgArPaintRatio(size: CGSize(width: 128, height: 128), vis: vis)
                    try algorithm.draw(n: iterations, driver: driver, plotter: paint, progress: EmptyProgress())
                    let ratio = paint.ratio
                    if ratio > threshold {
                        found.append(driver)
                        progress.progress(Float(found.count) / Float(count))
                        print("good: \(ratio) > \(threshold)")
                        failed = 0
                    } else {
                        print("bad:  \(ratio) < \(threshold)")
                        failed += 1
                    }
                }
            } catch {
                print("skip: error=\(error)")
                failed += 1
            }
            if failed > concession {
                failed = 0
                threshold *= 0.5
                print("conceded => threshold=\(threshold)")
            }
        }
        return found
    }
}

enum SgArRuntimeError: Error {
    case math
    case noPNGData
    case noUTF8Data
}
