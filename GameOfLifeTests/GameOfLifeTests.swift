//
//  GameOfLifeTests.swift
//  GameOfLifeTests
//
//  Created by Maarten Schumacher on 19/06/15.
//  Copyright (c) 2015 Maarten Schumacher. All rights reserved.
//

import UIKit
import XCTest

class GameOfLifeTests: XCTestCase {
    let blockGrid = [
        GridPoint(x:5, y:5),
        GridPoint(x:6, y:5),
        GridPoint(x:5, y:6),
        GridPoint(x:6, y:6)
    ]
    
    let stickGrid = [
        GridPoint(x: 5, y: 5),
        GridPoint(x: 5, y: 6),
        GridPoint(x: 5, y: 7)
    ]
    
    let chaosGrid = [
        GridPoint(x: 15, y: 15),
        GridPoint(x: 16, y: 15),
        GridPoint(x: 15, y: 16),
        GridPoint(x: 14, y: 16),
        GridPoint(x: 15, y: 17)
    ]
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testExample() {
        // This is an example of a functional test case.
        XCTAssert(true, "Pass")
    }
    
//    func testPerformanceExample() {
//        // This is an example of a performance test case.
//        // last measure: 0.172
//        self.measureBlock() {
//            // Put the code you want to measure the time of here.
//            var index = 0
//            var grid = self.chaosGrid
//            while index < 30 {
//                grid = self.gridInstance.nextGrid(grid)
//                index++
//            }
//        }
//    }
    
    func testStayLivingWithBlock() {
        let survivors = stayLiving(treeFromArray(blockGrid))
        
        XCTAssertEqual(blockGrid.count, survivors.count, "Fail")
    }
    
    func testGetLivingNeighboursWithBlock() {
        let neighbourTree = treeFromArray(getNeighbours(GridPoint(x: 4, y: 5)))
        let deadCell = treeIntersect(treeFromArray(blockGrid), neighbourTree).count
        
        let otherNeighbourTree = treeFromArray(getNeighbours(GridPoint(x: 5, y: 5)))
        let liveCell = treeIntersect(treeFromArray(blockGrid), otherNeighbourTree).count
        
        XCTAssert(deadCell == 2, "Fail")
        XCTAssert(liveCell == 3, "Fail")
    }
    
    func testBecomeAliveWithBlock() {
        let bornCells = becomeAlive(deadCells(treeFromArray(blockGrid)), treeFromArray(blockGrid))
        
        XCTAssert(bornCells.count == 0, "no cells should have been born. born: \(bornCells.count)")
    }
    
    func testStayLivingWithStick() {
        let survivors = stayLiving(treeFromArray(stickGrid))
        
        XCTAssertEqual(1, survivors.count, "Fail")
    }
    
    func testGetLivingNeighboursWithStick() {
        let neighbourTree = treeFromArray(getNeighbours(GridPoint(x: 4, y: 6)))
        let deadCell = treeIntersect(treeFromArray(stickGrid), neighbourTree).count
        
        let otherNeighbourTree = treeFromArray(getNeighbours(GridPoint(x: 5, y: 5)))
        let liveCell = treeIntersect(treeFromArray(stickGrid), otherNeighbourTree).count

        
        XCTAssert(deadCell == 3, "Fail")
        XCTAssert(liveCell == 1, "Fail")
    }
    
    func testBecomeAliveWithStick() {
        let bornCells = becomeAlive(deadCells(treeFromArray(stickGrid)), treeFromArray(stickGrid))
        
        XCTAssert(bornCells.count == 2, "two cells should have been born. born: \(bornCells.count)")
    }
    
    func testDeadCellsWithStick() {
        let diedCells = treeElements(deadCells(treeFromArray(stickGrid)))
        
        XCTAssert(diedCells.count == 12, "should be 12, was: \(diedCells.count)")
    }
    
}
