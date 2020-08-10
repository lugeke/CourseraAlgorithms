//
//  File.swift
//  
//
//  Created by lujiaheng on 2020/6/22.
//

import Foundation

extension Graph {
    
    /// compute the overall cost of a minimum spanning tree
    func MST() -> Double? {
        
        var visited: [Bool] = .init(repeating: false, count: n+1)
        DFS(from: 1, visited: &visited)
        
        // the graph is connected
        guard visited.dropFirst().allSatisfy({ $0}) else { return nil }
        
        
        var X: Set<Int> = .init()
        X.reserveCapacity(n+1)
        X.insert(1)
        
        var V_X: Set<Int> = .init(2..<n+1)
        
        var sum = 0.0
        while !V_X.isEmpty {
            
            var smallestEdge = Double.infinity
            var node = 0
            for u in X {
                for v in allHeads(tail: u) {
                    if V_X.contains(v) {
                        if distance(u,v) < smallestEdge {
                            smallestEdge = distance(u,v)
                            node = v
                        }
                    }
                }
            }
            
            sum += smallestEdge
            X.insert(V_X.remove(node)!)
            
        }
        
        return sum
    }
}
