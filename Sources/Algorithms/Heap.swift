//
//  File.swift
//  
//
//  Created by lujiaheng on 2020/7/8.
//

import Foundation

struct Heap {
    
    enum HeapType {
        case min
        case max
    }
    
    var tree: [Int] = []
    
    let type: HeapType
    
    var count: Int {
        tree.count
    }
    
    var order: (Int, Int) -> Bool {
        switch type {
        case .min:
            return (<)
        case .max:
            return (>)
        }
    }
    
    init(type: HeapType = .min) {
        self.type = type
    }
    
    mutating func insert(_ n: Int) {
        tree.append(n)
        bubbleUp(count-1)
    }
    
    mutating func bubbleUp(_ i: Int) {
        var i = i
        // when node i has parent  and need bubble up
        while case let parent = (i-1) / 2, parent >= 0, order(tree[i], tree[parent]) {
            tree.swapAt(i, parent)
            i = parent
        }
    }
    
    func peek() -> Int? {
        tree.first
    }
    
    mutating func extract() -> Int? {
        guard !tree.isEmpty else {
            return nil
        }
        tree.swapAt(0, count-1)
        let x = tree.removeLast()
        bubbleDown(0)
        return x
    }
    
    mutating func bubbleDown(_ i: Int) {
        var i = i
        //node i has at least a left child
        while case let left = 2*i+1, left < count {
            
            // the smallest/largest in the parents node
            var x = left
            
            // also has right child
            if case let right = left + 1, right < count, order(tree[right], tree[left]) { x = right }
            
            if order(tree[x], tree[i]) {
                tree.swapAt(i, x)
                i = x
            } else { return }
        }
    }
    
    
}
