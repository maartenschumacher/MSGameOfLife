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

func isEmptyTree<T>(tree: Tree<T>) -> Bool {
    switch tree {
    case let Tree.Leaf:
        return true
    case let Tree.Node(_, _, _):
        return false
    }
}

func single<T>(value: T) -> Tree<T> {
    return Tree.Node(Box(Tree.Leaf), Box(value), Box(Tree.Leaf))
}

func treeCount<T>(tree: Tree<T>) -> Int {
    switch tree {
    case let Tree.Leaf:
        return 0
    case let Tree.Node(left, _, right):
        return treeCount(left.unbox) + 1 + treeCount(right.unbox)
    }
}

func treeElements<T>(tree: Tree<T>) -> [T] {
    switch tree {
    case let Tree.Leaf:
        return []
    case let Tree.Node(left, x, right):
        return treeElements(left.unbox) + [x.unbox] + treeElements(right.unbox)
    }
}

func treeContains<T: Comparable>(tree: Tree<T>)(_ x: T) -> Bool {
    switch tree {
    case Tree.Leaf:
        return false
    case let Tree.Node(_, y, _) where x == y.unbox:
        return true
    case let Tree.Node(left, y, _) where x < y.unbox:
        return treeContains(left.unbox)(x)
    case let Tree.Node(_, y, right) where x > y.unbox:
        return treeContains(right.unbox)(x)
    default:
        fatalError("Impossible")
    }
}

func treeInsert<T: Comparable>(tree: Tree<T>)(_ x: T) -> Tree<T> {
    switch tree {
    case Tree.Leaf:
        return single(x)
    case let Tree.Node(_, y, _) where x == y.unbox:
        return tree
    case let Tree.Node(left, y, right) where x < y.unbox:
        return Tree.Node(Box(treeInsert(left.unbox)(x)), y, right)
    case let Tree.Node(left, y, right) where x > y.unbox:
        return Tree.Node(left, y, Box(treeInsert(right.unbox)(x)))
    default:
        fatalError("Impossible")
    }
}

// My own additions:

func treeRemove<T: Comparable>(tree: Tree<T>)(_ x: T) -> Tree<T> {
    switch tree {
    case Tree.Leaf:
        return tree
    case let Tree.Node(left, y, right) where x == y.unbox:
        if let minVal = treeMinimumValue(right.unbox) {
            return Tree.Node(left, Box(minVal), Box(treeRemove(right.unbox)(minVal)))
        } else { return left.unbox }
    case let Tree.Node(left, y, right) where x < y.unbox:
        return Tree.Node(Box(treeRemove(left.unbox)(x)), y, right)
    case let Tree.Node(left, y, right) where x > y.unbox:
        return Tree.Node(left, y, Box(treeRemove(right.unbox)(x)))
    default:
        fatalError("Impossible")
    }
}

func treeMinimumValue<T: Comparable>(tree: Tree<T>) -> T? {
    switch tree {
    case let Tree.Leaf:
        return nil
    case let Tree.Node(left, x, _) where isEmptyTree(left.unbox):
        return x.unbox
    case let Tree.Node(left, x, _):
        return treeMinimumValue(left.unbox)
    default:
        fatalError("Shouldn't happen")
    }
}

func treeFromArray<T: Comparable>(array: [T]) -> Tree<T> {
    if array.isEmpty {
        return emptyTree()
    } else {
        return treeInsert(treeFromArray(functionalRemoveLast(array)))(array.last!)
    }
}

func treeIntersect<T: Comparable>(x: Tree<T>, y: Tree<T>) -> [T] {
    return treeFilter(treeContains(y), x)
}

func treeUnion<T: Comparable>(x: Tree<T>, y: Tree<T>) -> Tree<T> {
    return reduce(treeElements(x), y) { tree, element in
        return treeInsert(tree)(element)
    }
}

func treeSubtract<T: Comparable>(x: Tree<T>, from y: Tree<T>) -> Tree<T> {
    return treeSubtractWithArray(treeElements(x), from: y)
}

func treeSubtractWithArray<T: Comparable>(x: [T], from y: Tree<T>) -> Tree<T> {
    return reduce(x, y) { tree, element in
        return treeRemove(tree)(element)
    }
}

func treeFilter<T>(p: (T -> Bool), tree: Tree<T>) -> [T] {
    return treeElements(tree).filter(p)
}

func treeMap<A, B>(tree: Tree<A>)(_ f: (A -> B)) -> [B] {
    return treeElements(tree).map(f)
}

func functionalRemoveLast<T>(array: [T]) -> [T] {
    var newArray = array
    newArray.removeLast()
    return newArray
}

















