import XCTest
@testable import StrangeAttractor

class SgArRandomTests: XCTestCase {

    func testSgArRandom() throws {
        let factory = SgArRandom.Bedhead()
        let bedhead = factory.randomCreate() as! SgAr.Bedhead
        XCTAssertEqual(bedhead.a, 0, accuracy: 1)
        XCTAssertEqual(bedhead.b, 0, accuracy: 1)
        let mutation = bedhead.mutated(factor: 0.1) as! SgAr.Bedhead
        XCTAssertEqual(bedhead.a, mutation.a, accuracy: 0.1)
        XCTAssertEqual(bedhead.b, mutation.b, accuracy: 0.1)
    }
}
