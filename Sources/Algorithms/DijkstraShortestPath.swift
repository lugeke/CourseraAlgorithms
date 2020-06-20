//
//  File.swift
//  
//
//  Created by lujiaheng on 2020/6/19.
//

import Foundation

extension Graph {
    
    /// return the shortest paths from source vertex to all other vertices
    func dijkstraPaths(source: Int) -> [Double] {
        var shortestPaths: [Double] = .init(repeating: .infinity, count: adjList.count)
        shortestPaths[source] = 0
        
        var X: Set<Int> = .init()
        var V_X: Set<Int> = .init()
        
        var visited: [Bool] = .init(repeating: false, count: adjList.count)
        dfs(from: source, visited: &visited) { V_X.insert($0) }
        X.reserveCapacity(V_X.count)
        
        X.insert(source)
        V_X.remove(source)
        
        while !V_X.isEmpty {
            
            var smallestGreedyScore = Double.infinity
            var node = 0
            for u in X {
                for v in adjList[u] {
                    if V_X.contains(v) {
                        let score = shortestPaths[u] + distance(u,v)
                        if score < smallestGreedyScore {
                            smallestGreedyScore = score
                            node = v
                        }
                    }
                }
            }
            shortestPaths[node] = smallestGreedyScore
            X.insert(node)
            V_X.remove(node)
        }
        
        
        
        return shortestPaths
    }
    
//    init(num: Int, fromURL url: URL) {
//        adjList = .init(repeating: [], count: num+1)
//        let lines = try! String(contentsOf: url).split(separator: "\n")
//        
//        for line in lines {
//            let vertices = line.split(separator: " ")
//            h.addEdge(Int(vertices[0])!, Int(vertices[1])!)
//        }
//             
//    }
}
