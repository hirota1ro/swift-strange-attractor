import XCTest
@testable import StrangeAttractor

class SpanTests: XCTestCase {

    func testSpan() throws {
        let s01 = Span(min: 10, max: 20)
        XCTAssertEqual(s01.normalized(15), 0.5, accuracy: 1e-5)

        var vs = Span(min: 1e+10, max: -1e+10)
        vs.update(0.5)
        vs.update(0.1)
        vs.update(0.9)
        XCTAssertEqual(vs.min, 0.1, accuracy: 1e-5)
        XCTAssertEqual(vs.max, 0.9, accuracy: 1e-5)
    }
}
