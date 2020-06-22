//
//  File.swift
//  
//
//  Created by lujiaheng on 2020/6/22.
//

import XCTest
@testable import Algorithms

extension Graph {
    init(fromURL url: URL) {
        
        let lines = try! String(contentsOf: url).components(separatedBy: .newlines)
        let line = lines[0].components(separatedBy: .whitespaces)
        let nodes = Int(line[0])!, edges = Int(line[1])!
        
        self = .init(adjList: .init(repeating: [], count: nodes+1))
        
        for i in 1...edges {
            let line = lines[i].components(separatedBy: .whitespaces)
            
            addEdge(Int(line[0])!, Int(line[1])!, weight: Double(line[2])!)
            addEdge(Int(line[1])!, Int(line[0])!, weight: Double(line[2])!)
        }
        
    }
}

final class MSTTests: XCTestCase {
    
    func testSmallGraph() {
        let url = URL.testFile(name: "edgesSmall.txt")
        let g = Graph(fromURL: url)
        let sum = g.MST()!
        XCTAssertEqual(sum, 7)
    }
}
