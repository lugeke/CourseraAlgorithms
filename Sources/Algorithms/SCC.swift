//
//  File.swift
//  
//
//  Created by lujiaheng on 2020/7/20.
//

import Foundation

extension Graph {
    
    /// the finish time of each vertex satisfy u -> v, f(u) > f(v)
    /// - Returns: vertices order by finish time (ascend order)
    func dfsFinishTime() -> [Int] {
        var result = [Int]()
        result.reserveCapacity(n+1)
        
        var visited: [Bool] = .init(repeating: false, count: n+1)
        
        for i in 1...n {
            if !visited[i] {
                dfs(from: i, visited: &visited) { result.append($0) }
            }
        }
        
        return result
    }
    
    
    /// compute the strongly connected components
    /// - Returns: an array of strongly connected components
    /// each component represent by an array of vertices
    public func SCC() -> [[Int]] {
        let g = self.reversed()
        let vertices = g.dfsFinishTime()
        var result: [[Int]] = []
        var visited: [Bool] = .init(repeating: false, count: n+1)
        
        for i in vertices.reversed() {
            if !visited[i] {
                var t:[Int] = []
                dfs(from: i, visited: &visited) { t.append($0) }
                result.append(t)
            }
        }
        return result
    }
}
