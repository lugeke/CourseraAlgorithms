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
        var parent = (i-1) / 2
        // when node i has parent  and need bubble up
        while parent >= 0 && order(tree[i], tree[parent]) {
            tree.swapAt(i, parent)
            i = parent
            parent = (i-1) / 2
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
        var left = 2*i+1
        while left < count {
            var ary = [i, left]
            
            // also has right child
            let right = 2*i+2
            if right < count { ary.append(right)}
            
            ary.sort { order(tree[$0], tree[$1]) }
            
            let x = ary[0]
            if x != i {
                tree.swapAt(i, x)
                i = x
                left = 2*i+1
            } else {
                return
            }
        }
    }
    
    
}
