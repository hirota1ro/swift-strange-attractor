import XCTest
@testable import StrangeAttractor

class SgArFileTests: XCTestCase {

    func testSgArFile() throws {
        let dict:[String: Any] = ["name": "Bedhead",  "a": 1, "b": 2]
        let formula = try SgArFile.read(fromDict: dict)
        let p0 = formula.start
        let p1 = formula.next(x: p0.x, y: p0.y)
        XCTAssertEqual(p1.x, 1.479425538604203, accuracy: 1e-5)
        XCTAssertEqual(p1.y, 1.4207354924039484, accuracy: 1e-5)
    }

    func testSgArFactory() throws {
        let factory = SgArFactories.obtain(name: "Bedhead")!
        let param = SgArParam(dict: ["a": 1, "b": 2])
        let formula = try factory.create(param: param)
        let p0 = formula.start
        let p1 = formula.next(x: p0.x, y: p0.y)
        XCTAssertEqual(p1.x, 1.479425538604203, accuracy: 1e-5)
        XCTAssertEqual(p1.y, 1.4207354924039484, accuracy: 1e-5)
    }
}
