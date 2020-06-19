//
//  File.swift
//  
//
//  Created by lujiaheng on 2020/6/19.
//

import XCTest
@testable import Algorithms


final class GraphTests: XCTestCase {

    func testSmallGraph() {
        
         var g = Graph(adjList: .init(repeating: [], count: 10))
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

           

           print(g.dfsFinishTime())
        
           XCTAssertEqual(g.SCC(), [3, 3, 3])

    }
    
    func testBigGraph() {
        
        let sccURL = URL(fileURLWithPath: #file)
            .deletingLastPathComponent()
            .appendingPathComponent("SCC.txt")
        
        // the graph contains 875714 vertices
        var h = Graph(adjList: .init(repeating: [], count: 875715))
        let lines = try! String(contentsOf: sccURL).split(separator: "\n")
        
        
        
        for line in lines {
            let vertices = line.split(separator: " ")
            //    print(vertices)
            h.addEdge(Int(vertices[0])!, Int(vertices[1])!)
        }
        
        
        measure {
            let big5 = h.SCC().sorted(by: >).prefix(5)
            XCTAssertEqual(big5, [434821, 968, 459, 313, 211])
        }
        
        
            
            
    }
    

    static var allTests = [
        ("testSmallGraph", testSmallGraph),
        ("testBigGraph", testBigGraph)
    ]
}
