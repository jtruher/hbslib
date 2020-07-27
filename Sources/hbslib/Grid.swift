//
//  Grid.swift
//  gomoku
//
//  Created by James Truher on 3/23/20.
//  Copyright © 2020 James Truher. All rights reserved.
//

import Foundation


public class Grid <Element> : Equatable where Element: Numeric, Element: Comparable, Element: Hashable {
    
    var tiles = [Element]()
    
    var width : Int = 0
    var height : Int = 0
    var sentinel : Element
    
    init(width: Int, height: Int, sentinel : Element) {
        self.width = width
        self.height = height
        self.sentinel = sentinel

        self.tiles = Array.init(repeating: sentinel, count: width * height)
    }
    
    func indexIsValid(row: Int, column: Int) -> Bool {
        return row >= 0 && row < width && column >= 0 && column < height
    }
    
    subscript(row: Int, column: Int) -> Element {
        get {
            assert(indexIsValid(row: row, column: column), "Index out of range")
            return tiles[(row * height) + column]
        }
        set {
            assert(indexIsValid(row: row, column: column), "Index out of range")
            tiles[(row * height) + column] = newValue
        }
    }
    
    public func getLargestValue() -> Element? {
        return tiles.max()
    }
    
    public func getLargestWithRange(_ extra: Int) -> (x: Int, y: Int) {
        let reduced : Set<Element> = Set(tiles.makeIterator())
        let sorted = Array(reduced.sorted().reversed())
        
        print(sorted)

        var targetIndex = extra
        if extra > sorted.count {
            targetIndex = sorted.count - 1
        }
        
        let target = sorted[targetIndex]
        
        var hits = [(Int, Int)]()
        for (index, value) in tiles.enumerated() {
            if target <= value {
                hits.append((index / width, index % width))
            }
        }

        print("HITS FOUND:", hits)
        
        if let final = hits.randomElement() {
            return final
        }
        
        return (0, 0)

    }
    
    public func getLargest() -> (x: Int, y: Int) {
        
        if let max = tiles.max() {
            var hits = [(Int, Int)]()
            for (index, value) in tiles.enumerated() {
                if max == value {
                    hits.append((index / width, index % width))
                }
            }
//
//            print("HITS FOUND:", hits)
            
            if let final = hits.randomElement() {
                return final
            }
        }
        return (0, 0)
    }
    
    public func eachCell(_ completion: @escaping (_ x: Int, _ y: Int) -> ()) {
        for x in 0 ..< width {
            for y in 0 ..< height {
                completion(x, y)
            }
        }

    }
    
    public static func +(lhs: Grid, rhs: Grid) -> Grid {
        let g = Grid(width: lhs.width, height: lhs.height, sentinel: lhs.sentinel)
        
        if lhs.width != rhs.width || lhs.height != rhs.height {
            return g
        }
                
        for (idx, _) in g.tiles.enumerated() {
            g.tiles[idx] = lhs.tiles[idx] + rhs.tiles[idx]
        }
        
        return g
    }
    
    public static func -(lhs: Grid, rhs: Grid) -> Grid {
        let g = Grid(width: lhs.width, height: lhs.height, sentinel: lhs.sentinel)
        
        if lhs.width != rhs.width || lhs.height != rhs.height {
            return g
        }
                
        for (idx, _) in g.tiles.enumerated() {
            g.tiles[idx] = lhs.tiles[idx] - rhs.tiles[idx]
        }
        
        return g
    }
    
    public static func *(lhs: Grid, rhs: Grid) -> Grid {
        let g = Grid(width: lhs.width, height: lhs.height, sentinel: lhs.sentinel)
        
        if lhs.width != rhs.width || lhs.height != rhs.height {
            return g
        }
                
        for (idx, _) in g.tiles.enumerated() {
            g.tiles[idx] = lhs.tiles[idx] * rhs.tiles[idx]
        }
        
        return g
    }
    
    public static func *(lhs: Grid, rhs: Element) -> Grid {
        let g = Grid(width: lhs.width, height: lhs.height, sentinel: lhs.sentinel)
                        
        for (idx, _) in g.tiles.enumerated() {
            g.tiles[idx] = lhs.tiles[idx] * rhs
        }
        
        return g
    }

    
    public static func == (lhs: Grid<Element>, rhs: Grid<Element>) -> Bool {
        return lhs.tiles == rhs.tiles
    }

}

extension Grid : CustomStringConvertible {
    public var description: String {
        var b = ""
        for x in 0 ..< width {
            for y in 0 ..< height {
                b += "\(self[x, y])".padding(toLength: 5, withPad: " ", startingAt: 0)
            }
            b += "\n\n"
        }

        return b
    }
}
