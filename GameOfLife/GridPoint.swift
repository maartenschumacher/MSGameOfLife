//
//  GridPoint.swift
//  GameOfLife
//
//  Created by Maarten Schumacher on 08/08/15.
//  Copyright (c) 2015 Maarten Schumacher. All rights reserved.
//

import Foundation

struct GridPoint: Hashable {
    let x: Int
    let y: Int
    
    var hashValue: Int {
        get {
            return "\(self.x),\(self.y)".hashValue
        }
    }
}


extension GridPoint: Equatable {}
func ==(lhs: GridPoint, rhs: GridPoint) -> Bool {
    return (lhs.x == rhs.x) && (lhs.y == rhs.y)
}

func !=(lhs: GridPoint, rhs: GridPoint) -> Bool {
    if lhs.x != lhs.x {
        return true
    } else {
        return !(lhs == rhs)
    }
}


extension GridPoint: Comparable, _Comparable {}
func <=(lhs: GridPoint, rhs: GridPoint) -> Bool {
    if let bigger = failsIfEqual(lhs.x, rhs.x) {
        return !bigger
    } else {
        return lhs.y <= rhs.y
    }
}

func <(lhs: GridPoint, rhs: GridPoint) -> Bool {
    if let bigger = failsIfEqual(lhs.x, rhs.x) {
        return !bigger
    } else {
        return lhs.y < rhs.y
    }
}

func >(lhs: GridPoint, rhs: GridPoint) -> Bool {
    if let bigger = failsIfEqual(lhs.x, rhs.x) {
        return bigger
    } else {
        return lhs.y > rhs.y
    }
}

func >=(lhs: GridPoint, rhs: GridPoint) -> Bool {
    if let bigger = failsIfEqual(lhs.x, rhs.x) {
        return bigger
    } else {
        return lhs.y >= rhs.y
    }
}

func failsIfEqual<T: Comparable>(lhs: T, rhs: T) -> Bool? {
    if lhs == rhs {
        return nil
    } else {
        return lhs > rhs
    }
}