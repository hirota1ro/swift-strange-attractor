import Foundation

struct SgArAlgorithm {

    func draw(n: Int, driver: SgArDriver, plotter: SgArPlotter, progress: SgArProgress) throws {
        let next = driver.next
        var p = driver.start
        var v = CGPoint.zero
        var t = 0
        progress.begin()
        defer { progress.end() }
        for i in 0 ..< n {
            let q = next(p.x, p.y)
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
