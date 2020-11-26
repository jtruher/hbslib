//
//  CellularAutomataTests.swift
//  hbslibTests
//
//  Created by James Truher on 10/26/20.
//

import XCTest
@testable import hbslib

class CellularAutomataTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testBasicAutomata() throws {
        let automata = CellularAutomata(width: 4, height: 4)

        automata.rulesSurvive = [3, 4, 5, 6, 7, 8, 0, 0, 0]
        automata.rulesBirth =   [6, 7, 8, 0, 0, 0, 0, 0, 0]

        print(automata)
        print("-----------------")

        automata.resetRandom()

        print(automata)
        automata.stepCells()
        print(automata)
//        print("-----------------")

        for _ in 0...50 {
            automata.stepCells()
//            print("-----------------")
        }

    }

    func testDeadAutomata() throws {
        let automata = CellularAutomata(width: 4, height: 4)
        automata.borderMode = .dead
        automata.rulesSurvive = [3, 4, 5, 6, 7, 8, 0, 0, 0]
        automata.rulesBirth =   [6, 7, 8, 0, 0, 0, 0, 0, 0]

//        print(automata)
//        print("-----------------")

        automata.resetRandom()

        print(automata)
        print("-----------------")

        automata.stepCells()
        print(automata)
        print("-----------------")

//        for _ in 0...50 {
//            automata.stepCells()
//            print("-----------------")
//            print(automata)
//        }

    }
    func testWrapAutomata() throws {
        let automata = CellularAutomata(width: 8, height: 8)
        automata.borderMode = .wrap
        automata.rulesSurvive = [3, 4, 5, 6, 7, 8, 0, 0, 0]
        automata.rulesBirth =   [6, 7, 8, 0, 0, 0, 0, 0, 0]

        print(automata)
        print("-----------------")

        automata.resetRandom()

        print(automata)
        automata.stepCells()
        print(automata)
        print("-----------------")
        for _ in 0...50 {
            automata.stepCells()
//            print("-----------------")
        }

    }

    
}
