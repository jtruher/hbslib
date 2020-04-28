import XCTest
@testable import hbslib

final class hbslibTests: XCTestCase {
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct
        // results.
        XCTAssertEqual(hbslib().text, "Hello, World!")
    }

    static var allTests = [
        ("testExample", testExample),
    ]
}
