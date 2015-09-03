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
        let selectedCells = self.collectionView?.indexPathsForSelectedItems() as! [NSIndexPath] // get selected cells
        
        let grid = filterForBounds(bornCells(selectedCells.map(indexPathToGridPoint)), gridSize).map(gridPointToIndexPath)
        
        clear()
        
        for indexPath in grid {
            self.collectionView?.selectItemAtIndexPath(indexPath, animated: false, scrollPosition: .None)
        }
        
    }
    
    func clear() {
        self.collectionView?.selectItemAtIndexPath(nil, animated: false, scrollPosition: .None)
    }
    
    internal func indexPathToGridPoint(indexPath: NSIndexPath) -> GridPoint {
        return GridPoint(x: indexPath.row, y: indexPath.section)
    }
    
    internal func gridPointToIndexPath(gridPoint: GridPoint) -> NSIndexPath {
        return NSIndexPath(forRow: gridPoint.x, inSection: gridPoint.y)
    }

}
