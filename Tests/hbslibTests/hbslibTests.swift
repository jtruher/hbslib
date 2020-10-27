import XCTest
import UIKit
@testable import hbslib

final class HBSLibTests: XCTestCase {
    @available(iOS 9.0, *)
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct
        // results.
        XCTAssertEqual(HBSLib().text, "Hello, World!")

        let view = UIView()
        let outer = UIView()
        outer.addSubview(view)
        view.applyAutolayoutHugging()

        let arr = [1, 1, 2, 3, 5]
        XCTAssertNotEqual(arr, arr.unique())

        XCTAssertNotEqual(UIColor.randomColor(), UIColor.randomColor())
    }

    func testGrid() {
        let testGrid = Grid<Int>(width: 9, height: 9, sentinel: 0)
        testGrid[0, 0] = 15
        testGrid[8, 8] = 1

        XCTAssert(testGrid[0, 0] == 15)
        XCTAssert(testGrid[8, 8] == 1)

        XCTAssert(testGrid[1, 1] == 0)
        XCTAssert(testGrid[7, 8] == 0)

        print(testGrid)

        XCTAssert(testGrid == testGrid)
    }

    func testGridAxis() {
        let grid = Grid<Int>(width: 9, height: 9, sentinel: 0)
        for col in 0 ..< 8 {
            grid[col, 0] = 1
        }
        print(grid)
    }

    func testGridAdd() {
        let grid = Grid<Int>(width: 9, height: 9, sentinel: 0)
        grid[0, 0] = 15
        grid[8, 8] = 1

        let combined = grid + grid

        XCTAssert(combined[0, 0] == 30)
        XCTAssert(combined[8, 8] == 2)

        print(combined)
    }

    func testGridSubtract() {
        let grid = Grid<Int>(width: 9, height: 9, sentinel: 0)
        grid[0, 0] = 5
        grid[8, 8] = 1

        let empty = Grid<Int>(width: 9, height: 9, sentinel: 0)

        XCTAssert(grid - grid == empty)
    }

    func testGridMultiply() {
        let grid1 = Grid<Int>(width: 9, height: 9, sentinel: 0)
        grid1[0, 0] = 5
        grid1[8, 8] = 1

        let mult = grid1 * 5

        XCTAssert(mult[0, 0] == 25)
        XCTAssert(mult[8, 8] == 5)

        let grid2 = Grid<Int>(width: 9, height: 9, sentinel: 0)
        grid2[0, 0] = 0
        grid2[8, 8] = 1
        let mult2 = grid1 * grid2

        XCTAssert(mult2[0, 0] == 0)
        XCTAssert(mult2[8, 8] == 1)

        var mult3 = mult2
        mult3 *= 3
        XCTAssert(mult3[0, 0] == 0)
        XCTAssert(mult3[8, 8] == 3)
    }

    @available(iOS 9.0, *)
    static var allTests = [
        ("testExample", testExample)
    ]
}
