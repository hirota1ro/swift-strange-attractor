import XCTest
@testable import StrangeAttractor

class SgArVisualTests: XCTestCase {

    func testSgArVisual() throws {
        let visual = SgArVisual()
        visual.plot(point: CGPoint(x: 1, y: 1), velocity: CGPoint(x: 1, y: 0), acceleration: CGPoint(x: 0, y: 1))
        visual.plot(point: CGPoint(x: -1, y: -1), velocity: CGPoint(x: 0, y: 0), acceleration: CGPoint(x: 0, y: 0))
        XCTAssertFalse(visual.divergent)
        XCTAssertEqual(visual.size, CGSize(width: 2, height: 2))
        XCTAssertEqual(visual.center, CGPoint.zero)
        XCTAssertEqual(visual.v.min, 0, accuracy: 1e-5)
        XCTAssertEqual(visual.v.max, 1, accuracy: 1e-5)
        XCTAssertEqual(visual.a.min, 0, accuracy: 1e-5)
        XCTAssertEqual(visual.a.max, 1, accuracy: 1e-5)
    }
}
