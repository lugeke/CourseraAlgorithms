//
//  File.swift
//  
//
//  Created by lujiaheng on 2020/6/20.
//

import XCTest
import Foundation
@testable import Algorithms

extension Graph {
    init(num: Int, fromURL url: URL) {
        self = .init(adjList: .init(repeating: [], count: num+1))
        let lines = try! String(contentsOf: url).components(separatedBy: .newlines)
        
        for line in lines {
            let vertices = line.components(separatedBy: .whitespaces)
            let from = vertices[0]
            for pair in vertices.dropFirst() {
                guard !pair.isEmpty else { continue }
                let toAndWeight = pair.split(separator: ",")
                addEdge(Int(from)!, Int(toAndWeight[0])!, weight: Double(toAndWeight[1])!)
            }
        }
        
    }
}


final class DijkstraShortestPathTests: XCTestCase {
    
    
    func testSmallGraph() {
        
        let url = URL.testFile(name: "dijkstraDataSmall.txt")
        
        let g = Graph(num: 6, fromURL: url)
//        print(g)
        let paths = g.dijkstraPaths(source: 1).dropFirst()
        XCTAssertEqual(paths, [0, 2, 3, 7, .infinity, .infinity])

    }
    
    func testBigGraph() {
        let url = URL.testFile(name: "dijkstraData.txt")
        
        let g = Graph(num: 200, fromURL: url)
//        print(g)
        let paths = g.dijkstraPaths(source: 1)
        let destinations = [7,37,59,82,99,115,133,165,188,197].map { paths[$0]}
        print(destinations)
    }
}
