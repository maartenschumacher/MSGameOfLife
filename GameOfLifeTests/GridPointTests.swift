//
//  GridPointTests.swift
//  GameOfLife
//
//  Created by Maarten Schumacher on 08/08/15.
//  Copyright (c) 2015 Maarten Schumacher. All rights reserved.
//

import Foundation
import XCTest

class GridPointTests: XCTestCase {
    let small = GridPoint(x: 1, y: 9)
    let medium = GridPoint(x: 3, y: 3)
    let slightlyBigger = GridPoint(x: 3, y: 4)
    let same = GridPoint(x: 3, y: 4)
    let big = GridPoint(x: 9, y: 1)

    func testComparison() {
        let shouldBeTrue = [
            (small != medium),
            (small < medium),
            (small <= medium),
            (slightlyBigger == same),
            (big > small),
            (slightlyBigger <= same),
            (same != big),
            (slightlyBigger > medium),
            (medium < slightlyBigger)
        ]
        
        for test: Bool in shouldBeTrue {
            XCTAssert(test, "ouch")
        }
    }
}
