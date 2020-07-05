import XCTest
import UIKit
@testable import hbslib

final class hbslibTests: XCTestCase {
    @available(iOS 9.0, *)
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct
        // results.
        XCTAssertEqual(hbslib().text, "Hello, World!")
        
        let v = UIView()
        let outer = UIView()
        outer.addSubview(v)
        v.applyAutolayoutHugging()
        
        let arr = [1, 1, 2, 3, 5]
        XCTAssertNotEqual(arr, arr.unique())
        
        XCTAssertNotEqual(UIColor.randomColor(), UIColor.randomColor())
    }

    @available(iOS 9.0, *)
    static var allTests = [
        ("testExample", testExample),
    ]
}
