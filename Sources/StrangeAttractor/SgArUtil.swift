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

enum SgArRuntimeError: Error {
    case math
    case noPNGData
    case noUTF8Data
}
