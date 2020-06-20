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
    
    struct Vertex: Hashable {
        let source: Int
        let destination: Int
    }
    
    var _distances: [Vertex: Double] = [:]

    func distance(_ source: Int, _ destination: Int) -> Double {
        return _distances[Vertex(source: source, destination: destination), default: .infinity]
    }
    
    /// add edge connected from `from` to `to`
    mutating func addEdge(_ from: Int, _ to: Int, weight: Double? = nil) {
        adjList[from].append(to)
        if let weight = weight { _distances[Vertex(source: from, destination: to)] = weight }
    }
    
}

extension Graph: CustomStringConvertible {
    var description: String {
        var result = [String]()
        for i in 1...adjList.count-1 {
            for j in adjList[i] {
                let dis = distance(i, j)
                if dis == .infinity {
                    result.append("\(i) -> \(j)")
                } else {
                    result.append("\(i) -> \(j) =\(dis)")
                }
                
            }
        }
        

        return result.joined(separator: "\n")
    }
}


extension Graph {
    
    /// implement dfs search iteratively
    /// -Params:
    
    func dfs(from source: Int, visited: inout [Bool], afterVisit: ((Int) -> ())? = nil ) {
        
        var stack: [Int] = []
        stack.append(source)
        visited[source] = true
        
        while !stack.isEmpty {
            let start = stack.last!
            if let end = adjList[start].first(where: { !visited[$0] }) {
                stack.append(end)
                visited[end] = true
            } else {
                let last = stack.popLast()!
                afterVisit?(last)
            }
        }
        
    }
    
    /// the finish time of each vertex by dfs search
    /// - Returns: the finish time of vertex in ascend order
    func dfsFinishTime() -> [Int] {
        var result = [Int]()
        result.reserveCapacity(adjList.count)
        
        var visited: [Bool] = .init(repeating: false, count: adjList.count)
        
        for i in 1...adjList.count-1 {
            if !visited[i] {
                dfs(from: i, visited: &visited) { result.append($0) }
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

        for i in vertices.reversed() {
            if !visited[i] {
                count = 0
                dfs(from: i, visited: &visited) { _ in count += 1 }
                result.append(count)
            }
        }
        
        return result
    }
}

