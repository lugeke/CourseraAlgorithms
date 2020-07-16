//
//  File.swift
//  
//
//  Created by lujiaheng on 2020/7/14.
//

import Foundation


struct HuffmanCoding {
    let weights: [Int]
    var heap = Heap<BinaryTree<Int>>(type: .min)
    
    
    // a mapping from weight to coding
    mutating func codings() -> [Int: String] {
        
        
        guard !weights.isEmpty else {
            return [:]
        }
        
        for w in weights {
            heap.insert(.node(left: .null, value: w, right: .null))
        }
        
        for _ in 0..<weights.count-1 {
            let leftNode = heap.extract()!
            let rightNode = heap.extract()!
            guard case let .node(_,leftValue,_) = leftNode,case let .node(_, rightValue,_) = rightNode else {
                fatalError()
            }
            heap.insert(.node(left: leftNode, value: leftValue+rightValue, right: rightNode))
        }
        
        let root = heap.extract()!
        var coding: [Int: String] = [:]
        root.coding(currentCoding: "", &coding)
        
        return coding
    }
}

extension BinaryTree where T == Int {
    func coding(currentCoding: String, _ coding: inout [Int: String]) {
     
        
        switch self {
        case .null:
            return
        case let .node(left: l, value: v, right: r):
            // node is leaf
            if l == nil && r == nil {
                coding[v] = currentCoding
            }
            l.coding(currentCoding: currentCoding+"0", &coding)
            r.coding(currentCoding: currentCoding+"1", &coding)
        }
       
    }
}
