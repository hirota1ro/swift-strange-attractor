import Foundation

class SgArVisual {
    var x = Span(min: .greatestFiniteMagnitude, max: -.greatestFiniteMagnitude)
    var y = Span(min: .greatestFiniteMagnitude, max: -.greatestFiniteMagnitude)
    var v = Span(min: .greatestFiniteMagnitude, max: 0)
    var a = Span(min: .greatestFiniteMagnitude, max: 0)
}

extension SgArVisual: SgArPlotter {
    func plot(point: CGPoint, velocity: CGPoint, acceleration: CGPoint) {
        x.update(point.x)
        y.update(point.y)
        v.update(velocity.norm)
        a.update(acceleration.norm)
    }
}

extension SgArVisual {
    var divergent: Bool { return x.divergent || y.divergent || v.divergent || a.divergent }
    var size: CGSize { return CGSize(width: x.value, height: y.value) }
    var center: CGPoint { return CGPoint(x: x.center, y: y.center) }
    var translation: CGPoint { return -center }
    func scaleToFit(size to: CGSize) -> CGFloat {
        let scale = to / self.size
        return Swift.min(scale.width, scale.height)
    }
    var csv: [String] {
        let scale = scaleToFit(size: CGSize(width: 2, height: 2))
        let t = translation
        return ["\(scale)", "\(t.x)", "\(t.y)"] + v.csv + a.csv
    }
    static var head: [String] { return ["Scale", "Tx", "Ty", "Vmin","Vmax","Amin","Amax"] }
}

extension SgArVisual: CustomStringConvertible {
    var description: String {
        return "x=\(x), y=\(y), v=\(v), a=\(a)"
    }
}
