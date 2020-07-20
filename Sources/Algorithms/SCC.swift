//
//  File.swift
//  
//
//  Created by lujiaheng on 2020/7/20.
//

import Foundation

extension Graph {
    
    /// the finish time of each vertex by dfs search
    /// - Returns: the finish time of vertices in ascend order
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
    
    
    /// compute the strongly connected component
    /// - Returns: an array of vertices of strongly connected component
    func SCC() -> [[Int]] {
        var g = self
        let vertices = g.reversed().dfsFinishTime()
        
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
