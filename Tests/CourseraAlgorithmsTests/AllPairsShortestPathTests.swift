//
//  File.swift
//  
//
//  Created by lujiaheng on 2020/7/12.
//

import XCTest
import Foundation
@testable import Algorithms




final class AllPairsTests: XCTestCase {
    
    
    func testAllPairs() {
        var g = Graph(3)
        g.addEdge(1, 2, weight: 1)
        g.addEdge(2, 3, weight: 2)
        g.addEdge(1, 3, weight: 6)
        
        
        let allPairs = g.floydMarshallAllPairsShortestPaths()
        XCTAssertNotNil(allPairs)
        
        XCTAssertEqual(allPairs?[1][2], 1)
        
        
        XCTAssertEqual(allPairs?[1][3], 3)
        XCTAssertEqual(allPairs?[2][3], 2)
        
        XCTAssertEqual(allPairs?[2][1], Double.infinity)
        
        XCTAssertEqual(allPairs?[3][1], Double.infinity)
        XCTAssertEqual(allPairs?[3][2], Double.infinity)
        
        XCTAssertEqual(g.shortestOfShortestPaths(), 1)
        
        g.addEdge(3, 2, weight: -3)
        XCTAssertNil(g.floydMarshallAllPairsShortestPaths())
    }
    
    func testBig() {
        // test too slow
//        var g = Graph(fromURL: URL.testFile(name: "g1.txt"))
//        var shortest = g.shortestOfShortestPaths()
//        XCTAssertNil(shortest)
//
//        g = Graph(fromURL: URL.testFile(name: "g2.txt"))
//        shortest = g.shortestOfShortestPaths()
//        XCTAssertNil(shortest)
//
//        g = Graph(fromURL: URL.testFile(name: "g3.txt"))
//        shortest = g.shortestOfShortestPaths()
//        XCTAssertEqual(shortest, -19)
        
    }
}

