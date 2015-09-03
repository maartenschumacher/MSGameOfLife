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
}

func filterForBounds(cells: [GridPoint], bounds: GridSize) -> [GridPoint] {
    return cells.filter { gridPoint in
        let x = gridPoint.x
        let y = gridPoint.y
        
        return x <= bounds.width && x >= 0 && y >= 0 && gridPoint.y <= bounds.height
    }
}

func judgeNeighbours(livingCells: Set<GridPoint>)(cell: GridPoint) -> Bool {
    let neighbours = getNeighbours(cell)
    let aliveNeighbours = neighbours.filter { livingCells.contains($0) }.count
    return aliveNeighbours == 3 || aliveNeighbours == 2 && livingCells.contains(cell)
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

func bornCells(livingCells: [GridPoint]) -> [GridPoint] {
    
    let livingCellsSet = Set(livingCells) // lookups are faster in Sets than in arrays
    
    return Array(livingCellsSet.union(Set(livingCells.flatMap(getNeighbours)))).filter({judgeNeighbours(livingCellsSet)(cell: $0)})
}



