//
//  CellularAutomata.swift
//  gomoku
//
//  Created by James Truher on 6/23/20.
//  Copyright © 2020 James Truher. All rights reserved.
//

import Foundation

public enum Border {
    case dead, live, wrap
}

public class CellularAutomata {

    var grid = Grid<Int>(width: 1, height: 1, sentinel: 0)
    private var gridBuffer = Grid<Int>(width: 1, height: 1, sentinel: 0)
    private var gridCounts = Grid<Int>(width: 1, height: 1, sentinel: 0)

    public var rulesBirth = [Int]()
    public var rulesSurvive = [Int]()

    public var borderMode: Border = .live

    public var fillPercent: Float = 0.5

    public var width: Int {
        grid.width
    }
    public var height: Int {
        grid.height
    }
    
    public func loadCaveRules() {
        rulesBirth = [6,7,8]
        rulesSurvive = [3,4,5,6,7,8]
    }
    
    public init(width: Int, height: Int) {
        self.grid = Grid<Int>(width: width, height: height, sentinel: 0)
        self.gridBuffer = Grid<Int>(width: width, height: height, sentinel: 0)
        self.gridCounts = Grid<Int>(width: width, height: height, sentinel: 0)

        self.rulesSurvive = [3, 4, 5, 6, 7, 8]
        self.rulesBirth = [6, 7, 8]
    }

    func indexIsValid(row: Int, column: Int) -> Bool {
        return row >= 0 && row < grid.width && column >= 0 && column < grid.height
    }

    public subscript(row: Int, column: Int) -> Int {
        get {
            assert(indexIsValid(row: row, column: column), "Index out of range")
            return grid[row, column]
        }
        set {
            assert(indexIsValid(row: row, column: column), "Index out of range")
            grid[row, column] = newValue
        }
    }

    private func handleCell(cellX: inout Int, cellY: inout Int, around: inout Int) {
        if cellX < 0 || cellX >= grid.width {
            if borderMode == .wrap {
                cellX = (cellX + grid.width) % grid.width
            } else if borderMode == .live {
                around += 1
                return
            }
        }

        if cellY < 0 || cellY >= grid.height {
            if borderMode == .wrap {
                cellY = (cellY + grid.height) % grid.height
            } else if borderMode == .live {
                around += 1
                return
            }
        }

        if (cellX >= 0 && cellX < grid.width) && (cellY >= 0 && cellY < grid.height) && grid[cellX, cellY] != 0 {
            around += 1
        }
    }

    func cellAt(row: Int, col: Int, offsetX: Int, offsetY: Int) -> Int {
        var cellX = offsetX + row
        var cellY = offsetY + col

        if cellX < 0 || cellX >= grid.width {
            if borderMode == .wrap {
                cellX = (cellX + grid.width) % grid.width
            } else if borderMode == .live {
                return 1
            } else {
                return 0
            }
        }

        if cellY < 0 || cellY >= grid.height {
            if borderMode == .wrap {
                cellY = (cellY + grid.height) % grid.height
            } else if borderMode == .live {
                return 1
            } else {
                return 0
            }
        }
//        if (cellX >= 0 && cellX < grid.width) && (cellY >= 0 && cellY < grid.height) && grid[cellX, cellY] != 0 {
//
//        }
        
        return grid[cellX, cellY]
    }
    
    private func processCell(row: Int, col: Int) {
        var around = 0
        var alive = 0

        for deltaX in -1...1 {
            for deltaY in -1...1 {
                if deltaY == 0 && deltaX == 0 {
                    continue
                }
                
                around += cellAt(row: row, col: col, offsetX: deltaX, offsetY: deltaY)
            }
        }
//        print("adding \(around) to \(row),\(col)")
        gridCounts[row, col] += around
        
        if grid[row, col] == 1 {
            if rulesSurvive.contains(around) {
                alive = 1
            }
//            if rulesSurvive.count > 0 {
//                for idx in 0...rulesSurvive.count - 1 where around == rulesSurvive[idx] {
//                    alive = 1
//                    break
//                }
//            }
        } else {
            if rulesBirth.contains(around) {
                alive = 1
            }
//            if rulesBirth.count > 0 {
//                for idx in 0...rulesBirth.count - 1 where around == rulesBirth[idx] {
//                    alive = 1
//                    break
//                }
//            }
        }

        gridBuffer[row, col] = alive
    }
    
    public func stepCells() {
        gridBuffer *= 0
        gridCounts *= 0
        
        grid.eachCell { (row, col) in
            self.processCell(row: row, col: col)
        }
        
//        print(gridCounts)

        grid.tiles = gridBuffer.tiles
    }
    
    public func eachCell(_ completion: @escaping (_ x: Int, _ y: Int, _ value: Int) -> Void) {
        for row in 0 ..< width {
            for col in 0 ..< height {
                completion(row, col, grid[row, col])
            }
        }
    }

    public func resetRandom() {
        grid.eachCell { (row, col) in
            //            cells[x][y] = ((rand() >> 8) % 100) < fill_percent;
            self.grid[row, col] = Float.random(in: 0...1) < self.fillPercent ? 1 : 0
        }
    }

}

extension CellularAutomata: CustomStringConvertible {
    public var description: String {
        var ret = String.init(repeating: "-", count: grid.height)
        ret += "\n"
        ret += "Survive:\t\(rulesSurvive)\nBirth:\t\t\(rulesBirth)\n"
        ret += "Border: \(borderMode)\n"
        
        for row in 0...grid.width - 1 {
            for col in 0...grid.height - 1 {
                ret += "\(grid[row, col] == 1 ? "X" : " ")"
            }
            ret += "\n"
        }
        
        ret.append(String.init(repeating: "=", count: grid.height))

        return ret
    }
}

//
//
//enum
//{
//    BORDER_DEAD = 0,
//    BORDER_LIVE,
//    BORDER_WRAP
//};
//
//
//static char cells[CELLS_W][CELLS_H];
//static char cells_buff[CELLS_W][CELLS_H];
//
//static int rules_survive[RULES];
//static int rules_birth[RULES];
//static int border_mode = BORDER_LIVE;
//static int fill_percent = 50;
//
//static void process_cell(int x, int y)
//{
//    int dx, dy;
//    int around = 0;
//    int alive = 0;
//    int i;
//
//    for(dy = -1; dy < 2; dy++) {
//        for(dx = -1; dx < 2; dx++) {
//            int cellx = dx + x;
//            int celly = dy + y;
//
//            if(!dx && !dy) {
//                continue;
//            }
//
//            if(cellx < 0 || cellx >= CELLS_W) {
//                if(border_mode == BORDER_WRAP) {
//                    cellx = (cellx + CELLS_W) % CELLS_W;
//                } else if(border_mode == BORDER_LIVE) {
//                    around++;
//                    continue;
//                } else {
//                    continue;
//                }
//            }
//
//            if(celly < 0 || celly >= CELLS_H) {
//                if(border_mode == BORDER_WRAP) {
//                    celly = (celly + CELLS_H) % CELLS_H;
//                } else if(border_mode == BORDER_LIVE) {
//                    around++;
//                    continue;
//                } else {
//                    continue;
//                }
//            }
//
//            if(cells[cellx][celly]) {
//                around++;
//            }
//        }
//    }
//
//    // Living cells
//    if(cells[x][y]) {
//        // Survive
//        for(i = 0; i < RULES; i++) {
//            if(around == rules_survive[i]) {
//                alive = 1;
//                break;
//            }
//        }
//    } else {
//        // Dead cells
//        // Birth
//        for(i = 0; i < RULES; i++) {
//            if(around == rules_birth[i]) {
//                alive = 1;
//                break;
//            }
//        }
//    }
//
//    cells_buff[x][y] = alive;
//}
//
//
//static void step_cells(void)
//{
//    int x, y;
//
//    memset(cells_buff, 0, sizeof(cells_buff));
//
//    for(y = 0; y < CELLS_H; y++) {
//        for(x = 0; x < CELLS_W; x++) {
//            process_cell(x, y);
//        }
//    }
//
//    memcpy(cells, cells_buff, sizeof(cells));
//}
//
//
//static void reset_random(void)
//{
//    int x, y;
//
//    for(y = 0; y < CELLS_H; y++) {
//        for(x = 0; x < CELLS_W; x++) {
//            cells[x][y] = ((rand() >> 8) % 100) < fill_percent;
//        }
//    }
//}
//
//
//
//
//void doStuff()
//{
//    int steps = 0;
//    int ok = 0;
//
//    memset(rules_survive, -1, sizeof(rules_survive));
//    memset(rules_birth, -1, sizeof(rules_birth));
//
//    if(!ok)
//    {
//        // Conway default
//        rules_survive[0] = 3;
//        rules_survive[1] = 4;
//        rules_survive[2] = 5;
//        rules_survive[3] = 6;
//        rules_survive[4] = 7;
//        rules_survive[5] = 8;
//
//        rules_birth[0] = 6;
//        rules_birth[1] = 7;
//        rules_birth[2] = 8;
//
//    }
//
//    srand(time(NULL));
//
//    memset(cells, 0, sizeof(cells));
//
//    reset_random();
//
//    while(steps < 50) {
//        step_cells();
//        steps++;
//    }
//    memset(rules_survive, -1, sizeof(rules_survive));
//    memset(rules_birth, -1, sizeof(rules_birth));
//
//    rules_survive[0] = 5;
//    rules_survive[1] = 6;
//    rules_survive[2] = 7;
//    rules_survive[3] = 8;
//
//    rules_birth[0] = 5;
//    rules_birth[1] = 6;
//    rules_birth[2] = 7;
//    rules_birth[3] = 8;
//
//    while(steps < 50) {
//        step_cells();
//        steps++;
//    }
//
//}
