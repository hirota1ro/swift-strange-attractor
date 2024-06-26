import XCTest
@testable import StrangeAttractor

class AYSystemTests: XCTestCase {

    func testAYSystem() throws {
        XCTAssertEqual(AYSystem.decodeChar("A"), -1.2, accuracy: 1e-5)
        XCTAssertEqual(AYSystem.decodeChar("B"), -1.1, accuracy: 1e-5)
        XCTAssertEqual(AYSystem.decodeChar("C"), -1.0, accuracy: 1e-5)
        XCTAssertEqual(AYSystem.decodeChar("D"), -0.9, accuracy: 1e-5)
        XCTAssertEqual(AYSystem.decodeChar("E"), -0.8, accuracy: 1e-5)
        XCTAssertEqual(AYSystem.decodeChar("F"), -0.7, accuracy: 1e-5)
        XCTAssertEqual(AYSystem.decodeChar("G"), -0.6, accuracy: 1e-5)
        XCTAssertEqual(AYSystem.decodeChar("H"), -0.5, accuracy: 1e-5)
        XCTAssertEqual(AYSystem.decodeChar("I"), -0.4, accuracy: 1e-5)
        XCTAssertEqual(AYSystem.decodeChar("J"), -0.3, accuracy: 1e-5)
        XCTAssertEqual(AYSystem.decodeChar("K"), -0.2, accuracy: 1e-5)
        XCTAssertEqual(AYSystem.decodeChar("L"), -0.1, accuracy: 1e-5)
        XCTAssertEqual(AYSystem.decodeChar("M"), 0.0, accuracy: 1e-5)
        XCTAssertEqual(AYSystem.decodeChar("N"), 0.1, accuracy: 1e-5)
        XCTAssertEqual(AYSystem.decodeChar("O"), 0.2, accuracy: 1e-5)
        XCTAssertEqual(AYSystem.decodeChar("P"), 0.3, accuracy: 1e-5)
        XCTAssertEqual(AYSystem.decodeChar("Q"), 0.4, accuracy: 1e-5)
        XCTAssertEqual(AYSystem.decodeChar("R"), 0.5, accuracy: 1e-5)
        XCTAssertEqual(AYSystem.decodeChar("S"), 0.6, accuracy: 1e-5)
        XCTAssertEqual(AYSystem.decodeChar("T"), 0.7, accuracy: 1e-5)
        XCTAssertEqual(AYSystem.decodeChar("U"), 0.8, accuracy: 1e-5)
        XCTAssertEqual(AYSystem.decodeChar("V"), 0.9, accuracy: 1e-5)
        XCTAssertEqual(AYSystem.decodeChar("W"), 1.0, accuracy: 1e-5)
        XCTAssertEqual(AYSystem.decodeChar("X"), 1.1, accuracy: 1e-5)
        XCTAssertEqual(AYSystem.decodeChar("Y"), 1.2, accuracy: 1e-5)

        XCTAssertEqual(AYSystem.encodeChar(-1.2), "A")
        XCTAssertEqual(AYSystem.encodeChar(-1.1), "B")
        XCTAssertEqual(AYSystem.encodeChar(-1.0), "C")
        XCTAssertEqual(AYSystem.encodeChar(-0.9), "D")
        XCTAssertEqual(AYSystem.encodeChar(-0.8), "E")
        XCTAssertEqual(AYSystem.encodeChar(-0.7), "F")
        XCTAssertEqual(AYSystem.encodeChar(-0.6), "G")
        XCTAssertEqual(AYSystem.encodeChar(-0.5), "H")
        XCTAssertEqual(AYSystem.encodeChar(-0.4), "I")
        XCTAssertEqual(AYSystem.encodeChar(-0.3), "J")
        XCTAssertEqual(AYSystem.encodeChar(-0.2), "K")
        XCTAssertEqual(AYSystem.encodeChar(-0.1), "L")
        XCTAssertEqual(AYSystem.encodeChar(0.0), "M")
        XCTAssertEqual(AYSystem.encodeChar(0.1), "N")
        XCTAssertEqual(AYSystem.encodeChar(0.2), "O")
        XCTAssertEqual(AYSystem.encodeChar(0.3), "P")
        XCTAssertEqual(AYSystem.encodeChar(0.4), "Q")
        XCTAssertEqual(AYSystem.encodeChar(0.5), "R")
        XCTAssertEqual(AYSystem.encodeChar(0.6), "S")
        XCTAssertEqual(AYSystem.encodeChar(0.7), "T")
        XCTAssertEqual(AYSystem.encodeChar(0.8), "U")
        XCTAssertEqual(AYSystem.encodeChar(0.9), "V")
        XCTAssertEqual(AYSystem.encodeChar(1.0), "W")
        XCTAssertEqual(AYSystem.encodeChar(1.1), "X")
        XCTAssertEqual(AYSystem.encodeChar(1.2), "Y")
    }

    func testCVQKGHQTPHTE() throws {
        let a: [CGFloat] = AYSystem.decode("CVQKGHQTPHTE")
        let b: [CGFloat] = [-1.0, 0.9, 0.4, -0.2, -0.6, -0.5, 0.4, 0.7, 0.3, -0.5, 0.7, -0.8]
        zip(a, b).forEach { (l, r) in
            XCTAssertEqual(l, r, accuracy: 1e-5)
        }
    }
}
