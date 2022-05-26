import XCTest
@testable import StrangeAttractor

class SgArPaintRatioTests: XCTestCase {

    func testSgArPaintRatio() throws {
        let vis = SgArVisual()
        vis.plot(point: CGPoint(x:1,y:1), velocity: .zero, acceleration: .zero)
        vis.plot(point: CGPoint(x:-1,y:-1), velocity: .zero, acceleration: .zero)
        let pr = SgArPaintRatio(size: CGSize(width: 10, height: 10), vis: vis)
        pr.plot(point: CGPoint(x:0.5,y:0.5), velocity: .zero, acceleration: .zero)
        pr.plot(point: CGPoint(x:-0.5,y:0.5), velocity: .zero, acceleration: .zero)
        pr.plot(point: CGPoint(x:0.5,y:-0.5), velocity: .zero, acceleration: .zero)
        pr.plot(point: CGPoint(x:-0.5,y:-0.5), velocity: .zero, acceleration: .zero)
        XCTAssertEqual(pr.ratio, 0.04, accuracy: 1e-5)
    }
}
