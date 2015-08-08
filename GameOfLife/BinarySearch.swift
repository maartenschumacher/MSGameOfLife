//
//  BinarySearch.swift
//  GameOfLife
//
//  Created by Maarten Schumacher on 08/08/15.
//  Copyright (c) 2015 Maarten Schumacher. All rights reserved.
//

import Foundation

class Box<T> {
    let unbox: T
    init(_ value: T) { self.unbox = value }
}

enum Tree<T> {
    case Leaf
    case Node(Box<Tree<T>>, Box<T>, Box<Tree<T>>)
}

let leaf: Tree<Int> = Tree.Leaf

let five: Tree<Int> = Tree.Node(Box(leaf), Box(5), Box(leaf))


func single<T>(value: T) -> Tree<T> {
    return Tree.Node(Box(Tree.Leaf), Box(value), Box(Tree.Leaf))
}

func count<T>(tree: Tree<T>) -> Int {
    switch tree {
    case let Tree.Leaf:
        return 0
    case let Tree.Node(left, x, right):
        return count(left.unbox) + 1 + count(right.unbox)
    }
}
