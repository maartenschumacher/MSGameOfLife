//
//  GridViewController.swift
//  GameOfLife
//
//  Created by Maarten Schumacher on 19/06/15.
//  Copyright (c) 2015 Maarten Schumacher. All rights reserved.
//

import UIKit
import Foundation

let reuseIdentifier = "LifeCell"

struct GridSize {
    let width: Int
    let height: Int
}

//implement equatable for GridPoint
func ==(lhs: GridPoint, rhs: GridPoint) -> Bool {
    return lhs.hashValue == rhs.hashValue
}

struct GridPoint: Hashable {
    let x: Int
    let y: Int
    
    var hashValue: Int {
        get {
            return "\(self.x),\(self.y)".hashValue
        }
    }
}

class GridViewController: UICollectionViewController {
    let gridSize = GridSize(width: 30, height: 30)

    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        self.collectionView?.allowsMultipleSelection = true

        // Register cell classes
        self.collectionView!.registerClass(UICollectionViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
    // MARK: UICollectionViewDataSource

    override func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return gridSize.height
    }

    override func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return gridSize.width
    }

    override func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(reuseIdentifier, forIndexPath: indexPath) as! UICollectionViewCell
    
        // Configure the cell
        cell.backgroundColor = UIColor.whiteColor()
        cell.layer.borderWidth = 1.0
        
        let selectedView = UIView(frame: cell.frame)
        selectedView.backgroundColor = UIColor.purpleColor()
        
        cell.selectedBackgroundView = selectedView
    
        return cell
    }
    
    // MARK: Logic

    func nextStep() {
        let selectedCells = self.collectionView?.indexPathsForSelectedItems() as! [NSIndexPath]
        let oldGrid = selectedCells.map(indexPathToGridPoint)
        
        let grid = Grid(gridSize: self.gridSize)
        let newGrid = grid.nextGrid(oldGrid)
        
        let died = Array(Set(oldGrid).subtract(Set(newGrid))).map(gridPointToIndexPath)
        let born = Array(Set(newGrid).subtract(Set(oldGrid))).map(gridPointToIndexPath)
        
        for indexPath in born {
            self.collectionView?.selectItemAtIndexPath(indexPath, animated: false, scrollPosition: nil)
        }
        
        for indexPath in died {
            self.collectionView?.deselectItemAtIndexPath(indexPath, animated: false)
        }
    }
    
    func clear() {
        for indexPath in self.collectionView?.indexPathsForSelectedItems() as! [NSIndexPath] {
            self.collectionView?.deselectItemAtIndexPath(indexPath, animated: true)
        }
    }
    
    internal func indexPathToGridPoint(indexPath: NSIndexPath) -> GridPoint {
        return GridPoint(x: indexPath.row, y: indexPath.section)
    }
    
    internal func gridPointToIndexPath(gridPoint: GridPoint) -> NSIndexPath {
        return NSIndexPath(forRow: gridPoint.x, inSection: gridPoint.y)
    }

}