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
    
    let failMessage = "fail"

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
    
    func testTree() {
        let singleTree = single(5);
        XCTAssert(treeContains(singleTree)(5), failMessage)
        
        let moreTree = treeInsert(singleTree)(6)
        XCTAssert(treeContains(moreTree)(6), failMessage)
        XCTAssertFalse(treeContains(moreTree)(7), failMessage)
        
        let arrayTree = treeFromArray([1,2,3])
        XCTAssert(treeContains(arrayTree)(3), failMessage)
        XCTAssertFalse(treeContains(arrayTree)(4), failMessage)
    }
}
