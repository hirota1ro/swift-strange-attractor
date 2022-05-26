import XCTest
@testable import StrangeAttractor

class SgArTests: XCTestCase {

    func testSgAr() throws {
        let algorithm = SgAr()

        let vis = SgArVisual()
        vis.plot(point: CGPoint(x:1,y:1), velocity: .zero, acceleration: .zero)
        vis.plot(point: CGPoint(x:-1,y:-1), velocity: .zero, acceleration: .zero)
        let paint = SgArPaintRatio(size: CGSize(width: 10, height: 10), vis: vis)

        let formula = SgAr.Clifford(a: -1.7, b: 1.3, c: -0.1, d: -1.21)
        try algorithm.draw(n: 10, formula: formula, plotter: paint, progress: EmptyProgress())
    }
}
