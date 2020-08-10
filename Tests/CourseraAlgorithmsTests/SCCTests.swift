//
//  File.swift
//  
//
//  Created by lujiaheng on 2020/6/19.
//

import XCTest
@testable import Algorithms


final class GraphTests: XCTestCase {
    
    func testDFS() {
        var g = Graph(vertices: 4)
        g.addEdge(1, 2)
        g.addEdge(2, 3)
        g.addEdge(3, 1)
        g.addEdge(4, 3)
        
        var visited: [Bool] = .init(repeating: false, count: 5)
        var sequences: [Int] = []
        g.DFS(from: 1, visited: &visited) { sequences.append($0) }
        
        XCTAssertEqual(sequences, [3, 2, 1])
        XCTAssertEqual(visited.dropFirst(), [true, true, true, false])
        
        visited = .init(repeating: false, count: 5)
        sequences = []
        g.DFS(from: 4, visited: &visited) { sequences.append($0) }
        
        XCTAssertEqual(sequences, [2, 1, 3, 4])
        XCTAssertEqual(visited.dropFirst(), [true, true, true, true])
        
    }

    func testSmallGraph() {
        
        var g = Graph(vertices: 9)
        g.addEdge(4, 2)
        g.addEdge(2, 3)
        g.addEdge(3, 4)
        g.addEdge(4,5)
        g.addEdge(5,6)
        g.addEdge(6,1)
        g.addEdge(1,5)
        g.addEdge(6,9)
        g.addEdge(9,7)
        g.addEdge(7,8)
        g.addEdge(8,9)
        
        print(g.dfsFinishingTimes())
        
        let scc = g.SCC().map(\.count)
        XCTAssertEqual(scc, [3, 3, 3])
        
    }
    
    func testBigGraph() {
        
        let sccURL = URL.testFile(name: "SCC.txt")
        
        // the graph contains 875714 vertices
        var h = Graph(vertices: 875714)
        let lines = try! String(contentsOf: sccURL).components(separatedBy: .newlines)
        
        for line in lines {
            let vertices = line.components(separatedBy: .whitespaces)
            h.addEdge(Int(vertices[0])!, Int(vertices[1])!)
        }
        
//        measure(metrics: [XCTCPUMetric(), XCTMemoryMetric()]) {
        let big5 = h.SCC().map(\.count).sorted(by: >).prefix(5)
        XCTAssertEqual(big5, [434821, 968, 459, 313, 211])
//        }
        
    }
    

    static var allTests = [
        ("testSmallGraph", testSmallGraph),
        ("testBigGraph", testBigGraph)
    ]
}
