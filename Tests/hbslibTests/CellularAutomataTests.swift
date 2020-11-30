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

    static let debugPrinting = true
    
    func debugPrint(_ item: Any) {
        if CellularAutomataTests.debugPrinting == true {
            print(String(describing: item))
        }
    }
    
    func testDefaultAutomata() throws {
        let automata = CellularAutomata(width: 16, height: 16)

        automata.resetRandom()

        for _ in 0...50 {
            automata.stepCells()
        }
    }
    
    func testBasicAutomata() throws {
        let automata = CellularAutomata(width: 4, height: 4)

        automata.rulesSurvive = [3, 4, 5, 6, 7, 8]
        automata.rulesBirth =   [6, 7, 8]

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

//        automata.stepCells()
//        print(automata)
//        print("-----------------")
//
        for _ in 0...50 {
            automata.stepCells()
            print("-----------------")
            print(automata)
        }

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

    func testSimple1Automata() throws {
        let automata = CellularAutomata(width: 8, height: 8)

//        automata[1, 1] = 1
//        automata[2, 1] = 1

        for deltaX in -1...1 {
            for deltaY in -1...1 {
                print("\(deltaX), \(deltaY)")
            }
        }
        
        automata.borderMode = .wrap
        automata.rulesSurvive = [2, 3]
        automata.rulesBirth = [3]
        automata.fillPercent = 0.1
        automata.resetRandom()
        
        print(automata)
        automata.stepCells()
        print(automata)

        for idx in 1...50 {
            automata.stepCells()
            print(automata)
            
            if idx % 10 == 0 {
                automata.resetRandom()
            }
        }
    }

    func testSimple2Automata() throws {
        let automata = CellularAutomata(width: 8, height: 8)

//        automata[1, 1] = 1
        automata[2, 1] = 1
        
        automata.borderMode = .wrap
        automata.rulesSurvive = [2, 3]
        automata.rulesBirth = [3]
        automata.fillPercent = 0.2
        automata.resetRandom()
        
        print(automata)
        automata.stepCells()
        print(automata)

        for idx in 1...50 {
            automata.stepCells()
            print(automata)
            
            if idx % 10 == 0 {
                automata.resetRandom()
            }
        }
    }

    func testCavesAutomata() throws {
        let automata = CellularAutomata(width: 24, height: 64)

//        automata[1, 1] = 1
        automata[2, 1] = 1
        
        automata.borderMode = .live
        automata.loadCaveRules()
        automata.fillPercent = 0.45
        automata.resetRandom()
        
        print(automata)
        automata.stepCells()
        print(automata)

        for _ in 1...50 {
            automata.stepCells()
        }
        print(automata)

    }

    
}
