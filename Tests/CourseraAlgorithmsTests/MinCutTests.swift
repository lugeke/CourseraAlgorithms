//
//  File.swift
//
//
//  Created by lujiaheng on 2020/7/4.
//

import XCTest
@testable import Algorithms


final class MinCutTests: XCTestCase {
    
    func testSmallGraph() {
        var m = MinCut(n: 4)
        
        m.addEdge(1, 2)
        m.addEdge(1, 3)
        m.addEdge(3, 2)
        m.addEdge(3, 4)
        m.addEdge(2, 4)
        
        let results: [Int] = (0..<16).map { _ in
            var n = m
            return n.minCount()
        }
        print(results)
        XCTAssertEqual(results.min(), 2)
    }
    
    func testBigGraph() {
        let url = URL.testFile(name: "kargerMinCut.txt")
        var graph = MinCut(n: 200)
        let lines = try! String(contentsOf: url)
            .split(separator: "\r\n")
    
        var edges: Set<Edge> = []
        for line in lines {
            let vertices = line.components(separatedBy: .whitespaces)
            let v0 = Int(vertices[0])!
            for p in vertices.dropFirst() {
                if p == "" { continue }
                let p = Int(p)!
                edges.insert(.init(p: min(v0, p), q: max(v0, p)))
            }
        }
        for e in edges {
            graph.addEdge(e.p, e.q)
        }
        
        let results: [Int] = (0..<200).map { _ in
            var g = graph
            return g.minCount()
        }
        print(results)
        XCTAssertEqual(results.min(), 17)
    }
}
