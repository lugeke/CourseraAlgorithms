//
//  Graph.swift
//  SCC
//
//  Created by lujiaheng on 2020/6/15.
//  Copyright © 2020 lujiaheng. All rights reserved.
//

import Foundation

/// a directed graph, with vertex represent by int
struct Graph {
    /// `i`th element  represents  all the vertices from i
    var adjList: [[Int]]
    
    /// return the graph with all the edges reversed
    mutating func reversed() -> Graph {
        var reverse = [[Int]].init(repeating: [], count: adjList.count)
        for start in 1...adjList.count-1 {
            for end in adjList[start] {
                reverse[end].append(start)
            }
        }
        return Graph(adjList: reverse)
    }
    
    
    /// add edge connected from `from` to `to`
    mutating func addEdge(_ from: Int, _ to: Int) {
        adjList[from].append(to)
    }
    
}

extension Graph: CustomStringConvertible {
    var description: String {
        var result = [String]()
        for i in 1...adjList.count-1 {
            for j in adjList[i] {
                result.append("\(i) -> \(j)")
            }
        }
        

        return result.joined(separator: "\n")
    }
}


extension Graph {
    
    /// the finish time of each vertex by dfs search
    /// - Returns: the finish time of vertex in ascend order
    func dfsFinishTime() -> [Int] {
        var result = [Int]()
        result.reserveCapacity(adjList.count)
        
        
        var visited: [Bool] = .init(repeating: false, count: adjList.count)
        // depth first search, the vertex is not visited
        
        // the value and index of vertex in adjList
        var stack: [Int] = []
        for i in 1...adjList.count-1 {
            if !visited[i] {
                stack.append(i)
                visited[i] = true
                
                while !stack.isEmpty {
                    
                    let start = stack.last!
                    
                    if let end = adjList[start].first(where: { !visited[$0] }) {
                        stack.append(end)
                        visited[end] = true
                    } else {
                        result.append(stack.popLast()!)
                    }
                }
            }
        }
        
        return result
        
    }
    
    /// compute the strongly connected component
    /// - Returns: an array of strongly connected component's count
    func SCC() -> [Int] {
        var g = self
        let vertices = g.reversed().dfsFinishTime()
        
        
        var count = 0
        var result: [Int] = []
        
        var visited: [Bool] = .init(repeating: false, count: adjList.count)
        // depth first search, the vertex is not visited
        
// the recursive approach has performance issue, resulting stack overflow
//        func dfs(from vertex: Int) {
//
//            visited[vertex] = true
//            for next in adjList[vertex] {
//                if !visited[next] {
//                    dfs(from: next)
//                }
//            }
//            count += 1
//        }
//
//        for i in vertices.reversed() {
//            if !visited[i] {
//                count = 0
//                dfs(from: i)
//                result.append(count)
//            }
//        }
        
        
        var stack: [Int] = []
        for i in vertices.reversed() {
            if !visited[i] {
                stack.append(i)
                visited[i] = true
                
                count = 0
                while !stack.isEmpty {
                    
                    let start = stack.last!
                    if let end = adjList[start].first(where: { !visited[$0] }) {
                        stack.append(end)
                        visited[end] = true
                    } else {
                        
                        count += 1
                        _ = stack.popLast()!
                    }
                }
                result.append(count)
            }
        }
        
        return result
    }
}

