//
//  Grid.swift
//  GameOfLife
//
//  Created by Maarten Schumacher on 20/06/15.
//  Copyright (c) 2015 Maarten Schumacher. All rights reserved.
//

import UIKit

class Grid: NSObject {
    let gridSize: GridSize
    
    init(gridSize: GridSize) {
        self.gridSize = gridSize
    }
    
    func nextGrid(livingCells: Tree<GridPoint>) -> [GridPoint] {
        return filterForSize(makeNextGrid(livingCells))
    }
    
    // MARK: - Private
    
    internal func makeNextGrid(livingCells: Tree<GridPoint>) -> [GridPoint] {
        let survivingCells = stayLiving(livingCells)
        let bornCells = becomeAlive(deadCells(livingCells), livingCells)
        
        let survivorSet = Set(survivingCells)
        let bornSet = Set(bornCells)
        
        return Array(survivorSet.union(bornSet))
    }
    
    internal func filterForSize(cells: [GridPoint]) -> [GridPoint] {
        let outOfBounds = cells.filter({
            (cell: GridPoint) -> Bool in
            cell.x > self.gridSize.width || cell.y > self.gridSize.height
        })
        
        return Array(Set(cells).subtract(Set(outOfBounds)))
    }
}

func filterForBounds(cells: [GridPoint], bounds: GridSize) -> [GridPoint] {
    return cells.filter { gridPoint in
        return gridPoint.x <= bounds.width && gridPoint.y <= bounds.height
    }
}

func deadCells(livingCells: Tree<GridPoint>) -> Tree<GridPoint> {
    let cellsArray: [[GridPoint]] = treeMap(livingCells)(getNeighbours)
    let neighboursTree = reduce(cellsArray, emptyTree()) { tree, cells in
        return reduce(cells, tree) { tree, cell in
            return treeInsert(tree)(cell)
        }
    }
    
    return treeSubtract(livingCells, from: neighboursTree)
}

func becomeAlive(deadCells: Tree<GridPoint>, livingCells: Tree<GridPoint>) -> [GridPoint] {
    return treeFilter(judgeNeighbours(livingCells, rule: becomeAliveRule), deadCells)
}

func stayLiving(livingCells: Tree<GridPoint>) -> [GridPoint] {
    return treeFilter(judgeNeighbours(livingCells, rule: stayLivingRule), livingCells)
}

func judgeNeighbours(livingCells: Tree<GridPoint>, rule f: (Int -> Bool))(cell: GridPoint) -> Bool {
    let neighbourTree = treeFromArray(getNeighbours(cell))
    return f(treeIntersect(livingCells, neighbourTree).count)
}

func getNeighbours(cell: GridPoint) -> [GridPoint] {
    return [
        GridPoint(x: cell.x - 1, y: cell.y - 1),
        GridPoint(x: cell.x, y: cell.y - 1),
        GridPoint(x: cell.x + 1, y: cell.y - 1),
        GridPoint(x: cell.x - 1, y: cell.y),
        GridPoint(x: cell.x + 1, y: cell.y),
        GridPoint(x: cell.x - 1, y: cell.y + 1),
        GridPoint(x: cell.x, y: cell.y + 1),
        GridPoint(x: cell.x + 1, y: cell.y + 1)
    ]
}

func stayLivingRule(x: Int) -> Bool {
    return x == 2 || x == 3
}

func becomeAliveRule(x: Int) -> Bool {
    return x == 3
}









