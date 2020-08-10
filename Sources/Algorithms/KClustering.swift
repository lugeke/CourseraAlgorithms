//
//  File.swift
//  
//
//  Created by lujiaheng on 2020/7/10.
//

import Foundation

struct WeightedEdge: Hashable, Comparable {
    
    let p: Int
    let q: Int
    let cost: Int
    
    static func < (lhs: WeightedEdge, rhs: WeightedEdge) -> Bool {
        lhs.cost < rhs.cost
    }
}

struct KClustering {
    let k: Int
    var uf: UnionFind
    var edges: [WeightedEdge]
    
    init(nodes: Int, k: Int) {
        assert(0 <= k && k <= nodes)
        self.k = k
        uf = .init(n: nodes)
        edges = .init()
        edges.reserveCapacity(nodes*(nodes-1)/2)
    }
    
    mutating func addEdge(_ p: Int, q: Int, weight: Int) {
        edges.append(.init(p: p, q: q, cost: weight))
    }
    
    mutating func maxSpacing() -> Int {
        edges.sort()
        
        for edge in edges {
            
            if uf.count == k {
                if !uf.connected(edge.p, edge.q) {
                    return edge.cost
                }
                
            } else {
                uf.union(edge.p, edge.q)
                
            }
            
            
        }
        fatalError()
    }
}


func largestKClustering(_ nodes: Set<Int>, bits: Int) -> Int {
    
    // return all the bitmasks with 1 or 2 bit set to 1
    func bitmasks() -> [Int] {
        var result: [Int] = []
        let change1bit: [Int] = (0..<bits).map {
            1 << $0
        }
        
        result += change1bit
        
        for i in 0..<bits {
            for j in i+1..<bits {
                result.append( (1 << i) ^ (1 << j) )
            }
        }
        
        return result
    }
    
    let dict: [Int: Int] = .init(uniqueKeysWithValues: zip(nodes, 1...nodes.count))
    var uf = UnionFind(n: nodes.count)
    let masks = bitmasks()
    for (nodeP, p) in dict {
        // use xor operator to compute all the nodes with hamming distance equal 1 or 2
        for mask in masks {
            let nodeQ = mask ^ nodeP
            if let q = dict[nodeQ] {
                uf.union(p, q)
            }
        }
    }
    
    return uf.count
}


