//
//  File.swift
//  
//
//  Created by lujiaheng on 2020/6/20.
//

import XCTest
@testable import Algorithms

extension Graph {
    init(num: Int, fromURL url: URL) {
        self = .init(adjList: .init(repeating: [], count: num+1))
        let lines = try! String(contentsOf: url).split(separator: "\r\n")
        
        for line in lines {
            let vertices = line.split(separator: " ")
            let from = vertices[0]
            for pair in vertices.dropFirst() {
                let toAndWeight = pair.split(separator: ",")
                addEdge(Int(from)!, Int(toAndWeight[0])!, weight: Double(toAndWeight[1])!)
            }
        }
        
    }
}

final class DijkstraShortestPathTests: XCTestCase {
    
    
    func testSmallGraph() {
        
        let url = URL(fileURLWithPath: #file)
        .deletingLastPathComponent()
        .appendingPathComponent("dijkstraDataSmall.txt")
        
        let g = Graph(num: 6, fromURL: url)
//        print(g)
        let paths = g.dijkstraPaths(source: 1).dropFirst()
        XCTAssertEqual(paths, [0, 2, 3, 7, .infinity, .infinity])

    }
}
