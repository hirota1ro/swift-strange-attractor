import XCTest
@testable import StrangeAttractor

class SgArFormulaTests: XCTestCase {

    func testSgArFormula() throws {
        let clifford = SgAr.Clifford(a: -1.7, b: 1.3, c: -0.1, d: -1.21)
        let p0 = clifford.start
        let p1 = clifford.next(x: p0.x, y: p0.y)
        XCTAssertEqual(p1.x, -0.2677408257579521, accuracy: 1e-5)
        XCTAssertEqual(p1.y, -1.0701557487751985, accuracy: 1e-5)
    }
}
