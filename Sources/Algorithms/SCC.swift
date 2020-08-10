//
//  File.swift
//  
//
//  Created by lujiaheng on 2020/7/20.
//

import Foundation

extension Graph {
    
    /// Return vertices in ascend order of finishing time,
    /// the finishing time of a vertex satisfy the property u -> v, f(u) > f(v).
    func dfsFinishingTimes() -> [Int] {
        var result = [Int]()
        result.reserveCapacity(n+1)
        
        var visited: [Bool] = .init(repeating: false, count: n+1)
        
        for i in 1...n {
            if !visited[i] {
                DFS(from: i, visited: &visited) { result.append($0) }
            }
        }
        
        return result
    }
    
    
    /// Returns the strongly connected components, each represent by an array of vertices.
    ///
    /// The SCC are computed using Kosaraju's two-pass algorithm,
    ///  the first pass run DFS search on the reverse graph, returning the finishing times of each vertices
    ///  the second pass  run DFS search in decreasing order of finishing times.
    ///
    /// - Complexity: O(*m*+*n*) where *m* is the number of edges, *n* is the number of vertices.
    public func SCC() -> [[Int]] {
        let g = self.reversed()
        let vertices = g.dfsFinishingTimes()
        var result: [[Int]] = []
        var visited: [Bool] = .init(repeating: false, count: n+1)
        
        for i in vertices.reversed() {
            if !visited[i] {
                var t:[Int] = []
                DFS(from: i, visited: &visited) { t.append($0) }
                result.append(t)
            }
        }
        return result
    }
}
