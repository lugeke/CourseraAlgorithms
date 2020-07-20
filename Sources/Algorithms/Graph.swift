//
//  Graph.swift
//  SCC
//
//  Created by lujiaheng on 2020/6/15.
//  Copyright © 2020 lujiaheng. All rights reserved.
//

import Foundation

/// a directed graph, with vertex represent by int, start from 1
public struct Graph {
    /// `i`th element  represents  all the vertices whose tail is i
    private var adjList: [[Int]]
    
    // the max number of vertex
    var n: Int {
        adjList.count-1
    }
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
    
    struct Edge: Hashable {
        let source: Int
        let destination: Int
    }
    
    // for the directed weighted graph
    var weights: [Edge: Double] = [:]

    public func distance(_ source: Int, _ destination: Int) -> Double {
        if source == destination { return 0 }
        return weights[Edge(source: source, destination: destination), default: .infinity]
    }
    
    /// add edge connected from `from` to `to`
    public mutating func addEdge(_ from: Int, _ to: Int, weight: Double? = nil) {
        adjList[from].append(to)
        if let weight = weight { weights[Edge(source: from, destination: to)] = weight }
    }
    
    func allHeads(tail: Int) -> [Int] {
        adjList[tail]
    }
    
}

extension Graph: CustomStringConvertible {
    public var description: String {
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
    public init(fromURL url: URL, directed: Bool = false) {
        
        let lines = try! String(contentsOf: url).components(separatedBy: .newlines)
        let line = lines[0].components(separatedBy: .whitespaces)
        let nodes = Int(line[0])!, edges = Int(line[1])!
        
        self = .init(adjList: .init(repeating: [], count: nodes+1))
        
        for i in 1...edges {
            let line = lines[i].components(separatedBy: .whitespaces)
            
            addEdge(Int(line[0])!, Int(line[1])!, weight: Double(line[2])!)
            if !directed {
                addEdge(Int(line[1])!, Int(line[0])!, weight: Double(line[2])!)
            }
            
        }
        
    }
    
    public init(_ n: Int) {
        self = .init(adjList: .init(repeating: [], count: n+1))
    }
}


extension Graph {
    /// implement dfs search iteratively
    /// - Parameters:
    ///   - source: the source vertex
    ///   - visited: keep track of which vertex were visited
    ///   - afterVisit: a closure accepct vertex number, run when the vertex pops from stack
    func dfs(from source: Int, visited: inout [Bool], afterVisit: ((Int) -> ())? = nil ) {
        
        var stack: [Int] = []
        stack.append(source)
        visited[source] = true
        // a map from vertex to the first index of the adjList not visited
        var dict: [Int: Int] = [:]
        
        while !stack.isEmpty {
            let tail = stack.last!
            // heads[0..<k] has been visited
            let k = dict[tail, default: 0]
            let heads = allHeads(tail: tail)
            
            if let i = heads.dropFirst(k).firstIndex(where: { !visited[$0] }) {
                let head = heads[i]
                stack.append(head)
                dict[tail] = i + 1
                visited[head] = true
            } else {
                let last = stack.popLast()!
                afterVisit?(last)
            }
        }
        
    }
}
