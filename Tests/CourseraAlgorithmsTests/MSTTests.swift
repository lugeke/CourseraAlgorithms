//
//  File.swift
//  
//
//  Created by lujiaheng on 2020/6/22.
//

import XCTest
@testable import Algorithms



final class MSTTests: XCTestCase {
    
    func testSmallGraph() {
        let url = URL.testFile(name: "edgesSmall.txt")
        let g = Graph(fromURL: url)
        let sum = g.MST()!
        XCTAssertEqual(sum, 7)
    }
    
    func testBigGraph() {
        let url = URL.testFile(name: "edges.txt")
        let g = Graph(fromURL: url)
        let sum = g.MST()!
        XCTAssertEqual(sum, -3612829)
    }
}
