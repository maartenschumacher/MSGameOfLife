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
    
    func nextGrid(livingCells: [GridPoint]) -> [GridPoint] {
        return filterForSize(makeNextGrid(livingCells))
    }
    
    // MARK: - Private
    
    internal func makeNextGrid(livingCells: [GridPoint]) -> [GridPoint] {
        let survivingCells = stayLiving(livingCells)
        let bornCells = becomeAlive(deadCells(livingCells), livingCells: livingCells)
        
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
    
    internal func deadCells(livingCells: [GridPoint]) -> [GridPoint] {
        let withDuplicates = livingCells.flatMap({
            getNeighbours($0)
            }).filter({
                !contains(livingCells, $0)
            })
        
        return Array(Set(withDuplicates))
    }
    
    internal func becomeAlive(cells: [GridPoint], livingCells: [GridPoint]) -> [GridPoint] {
        return cells.filter({
            (cell: GridPoint) -> Bool in
            self.getLivingNeighbours(livingCells, cell: cell) == 3
        })
    }
    
    internal func stayLiving(livingCells: [GridPoint]) -> [GridPoint] {
        return livingCells.filter({
            (cell: GridPoint) -> Bool in
            let livingNeighbours = self.getLivingNeighbours(livingCells, cell: cell)
            return livingNeighbours == 2 || livingNeighbours == 3
        })
    }
    
    internal func getLivingNeighbours(livingCells: [GridPoint], cell: GridPoint) -> Int {
        let rowNeighbours = livingCells.filter({
            (selectedCell: GridPoint) -> Bool in
            selectedCell.x >= (cell.x-1) && selectedCell.x <= (cell.x+1)
        })
        
        var sectionNeighbours = rowNeighbours.filter({
            (selectedCell: GridPoint) -> Bool in
            selectedCell.y >= (cell.y-1) && selectedCell.y <= (cell.y+1)
        })
        
        let selfCell = find(sectionNeighbours, cell)
        if selfCell != nil {
            sectionNeighbours.removeAtIndex(selfCell!)
        }
        
        return sectionNeighbours.count
    }
    
    internal func getNeighbours(cell: GridPoint) -> [GridPoint] {
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

}
