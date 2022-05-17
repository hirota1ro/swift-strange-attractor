import Foundation

struct SgAr {
}

extension SgAr {

    func draw(n: Int, formula: SgArFormula, plotter: SgArPlotter, progress: SgArProgress) throws {
        var p = formula.start
        var v = CGPoint.zero
        var t = 0
        progress.begin()
        defer { progress.end() }
        for i in 0 ..< n {
            let q = formula.next(x: p.x, y: p.y)
            if q.isInvalid { throw SgArRuntimeError.math }
            let u = q - p
            if 20 < i {
                plotter.plot(point: p, velocity: u, acceleration: u - v)
            }
            if t < i {
                progress.progress(Float(i) / Float(n))
                t += n / 10
            }
            p = q
            v = u
        }
    }
}

protocol SgArPlotter {
    func plot(point: CGPoint, velocity: CGPoint, acceleration: CGPoint)
}

protocol SgArProgress {
    func begin()
    func progress(_ value: Float)
    func end()
}
