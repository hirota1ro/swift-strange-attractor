import Foundation
import Cocoa

struct VelAccResolver: SgArColorResolver {
    let v: Span
    let a: Span

    func resolve(point: CGPoint, velocity: CGPoint, acceleration: CGPoint) -> NSColor {
        let vel = velocity.norm
        let acc = acceleration.norm
        let hue = v.normalized(vel)
        let sat = easing(a.normalized(acc))
        return NSColor(hue: hue, saturation: sat, brightness: 1, alpha: 1)
    }

    func easing(_ x: CGFloat) -> CGFloat {
        return x * (2 - x) // ease out quad
    }
}

protocol SgArSearchSource {
    func create() -> SgArFormula
}

struct SgArSearchUtil {
    let count: Int
    let iterations: Int
    let threshold: Float
    let concession: Int
}

extension SgArSearchUtil {

    func search(source: SgArSearchSource) -> [SgArFormula] {
        let progress = MeasurementProgress(DeterminableProgress())
        progress.begin()
        defer { progress.end() }
        let algorithm = SgAr()
        var threshold = self.threshold
        var failed: Int = 0
        var found: [SgArFormula] = []
        while found.count < count {
            let formula = source.create()
            do {
                let vis = SgArVisual()
                try algorithm.draw(n: iterations, formula: formula, plotter: vis, progress: EmptyProgress())
                if vis.divergent {
                    print("skip: divergent")
                    failed += 1
                } else {
                    let paint = SgArPaintRatio(size: CGSize(width: 128, height: 128), vis: vis)
                    try algorithm.draw(n: iterations, formula: formula, plotter: paint, progress: EmptyProgress())
                    let ratio = paint.ratio
                    if ratio > threshold {
                        found.append(formula)
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
