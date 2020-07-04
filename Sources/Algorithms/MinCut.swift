//
//  File.swift
//  
//
//  Created by lujiaheng on 2020/7/4.
//

import Foundation

struct Edge: Hashable {
    let p: Int
    let q: Int
}

struct MinCut {
    var uf: UnionFind
    
    var edges: [Edge]
    let count: Int
    init(n: Int) {
        uf = .init(n: n)
        edges = .init()
        count = n
    }
    
    mutating func addEdge(_ p: Int, _ q: Int) {
        edges.append(Edge(p: min(p, q), q: max(p, q)))
    }
    
    // random
    mutating func minCount() -> Int {
        for _ in 0..<count-2 {
            let edge = edges.randomElement()!
            let _ = uf.union(edge.p, edge.q)
            edges.removeAll{ edge in
                uf.connected(edge.p, edge.q)
            }
        }
        
        return edges.count
    }
    
}
