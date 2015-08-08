//
//  BinarySearch.swift
//  GameOfLife
//
//  Created by Maarten Schumacher on 08/08/15.
//  Copyright (c) 2015 Maarten Schumacher. All rights reserved.
//

import Foundation

/* Taken from "Functional Programming in Swift",
    (Chris Eidhof, Florian Kugler, Wouter Swierstra) */

class Box<T> {
    let unbox: T
    init(_ value: T) { self.unbox = value }
}

enum Tree<T> {
    case Leaf
    case Node(Box<Tree<T>>, Box<T>, Box<Tree<T>>)
}

func emptyTree<T>() -> Tree<T> {
    return Tree.Leaf
}

func single<T>(value: T) -> Tree<T> {
    return Tree.Node(Box(Tree.Leaf), Box(value), Box(Tree.Leaf))
}

func treeContains<T: Comparable>(x: T, tree: Tree<T>) -> Bool {
    switch tree {
    case Tree.Leaf:
        return false
    case let Tree.Node(_, y, _) where x == y.unbox:
        return true
    case let Tree.Node(left, y, _) where x < y.unbox:
        return treeContains(x, left.unbox)
    case let Tree.Node(_, y, right) where x > y.unbox:
        return treeContains(x, right.unbox)
    default:
        fatalError("Impossible")
    }
}

func treeInsert<T: Comparable>(x: T, tree: Tree<T>) -> Tree<T> {
    switch tree {
    case Tree.Leaf:
        return single(x)
    case let Tree.Node(_, y, _) where x == y.unbox:
        return tree
    case let Tree.Node(left, y, right) where x < y.unbox:
        return Tree.Node(Box(treeInsert(x, left.unbox)), y, right)
    case let Tree.Node(left, y, right) where x > y.unbox:
        return Tree.Node(left, y, Box(treeInsert(x, right.unbox)))
    default:
        fatalError("Impossible")
    }
}

func treeFromArray<T: Comparable>(array: [T]) -> Tree<T> {
    if array.isEmpty {
        return emptyTree()
    } else {
        return treeInsert(array.last!, treeFromArray(functionalRemoveLast(array)))
    }
}


func functionalRemoveLast<T>(array: [T]) -> [T] {
    var newArray = array
    newArray.removeLast()
    return newArray
}

















