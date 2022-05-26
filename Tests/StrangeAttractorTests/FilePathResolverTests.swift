import XCTest
@testable import StrangeAttractor

class FilePathResolverTests: XCTestCase {

    func testFilePathResolver() throws {
        let fpr = FilePathResolver(path: "/var/tmp/a.png")
        let url = fpr.resolve(suffix: "1234")
        XCTAssertEqual(url.path, "/var/tmp/a-1234.png")
    }
}
