import XCTest
@testable import StrangeAttractor

class ComplexTests: XCTestCase {

    func testComplex() throws {
        let z1 = Complex(angle: CGFloat(30).radians)
        let z2 = Complex(angle: CGFloat(60).radians)
        let z3 = z1.mul(z2)
        XCTAssertEqual(z3.re, 0, accuracy: 1e-5)
        XCTAssertEqual(z3.im, 1, accuracy: 1e-5)

        let z4 = z1.pow(3)
        XCTAssertEqual(z4.re, 0, accuracy: 1e-5)
        XCTAssertEqual(z4.im, 1, accuracy: 1e-5)
    }
}
