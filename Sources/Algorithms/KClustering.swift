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
                _ = uf.union(edge.p, edge.q)
                
            }
            
            
        }
        fatalError()
    }
}


func largestKClustering(_ nodes: Set<[Bool]>) -> Int {
    
    // return all the strings with hamming distance to str equal to 1 or 2
    func distanceBy2(_ str: [Bool]) -> [[Bool]] {
        var result: [[Bool]] = []
        let bits = str.count
        let change1bit: [[Bool]] = (0..<bits).map {
            var s = str
            s[$0].toggle()
            return s
        }
        
        result += change1bit
        
        for i in 0..<bits {
            for j in i+1..<bits {
                var str = str
                str[i].toggle()
                str[j].toggle()
                result.append(str)
            }
        }
        
        return result
    }
    
    let dict: [[Bool]: Int] = .init(uniqueKeysWithValues: zip(nodes, 1...nodes.count))
    var uf = UnionFind(n: nodes.count)
    for (nodeP, p) in dict {
        for q in distanceBy2(nodeP) {
            if let q = dict[q] {
                _ = uf.union(p, q)
            }
        }
    }
    
    return uf.count
}

