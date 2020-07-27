//
//  File.swift
//  
//
//  Created by lujiaheng on 2020/7/26.
//


import XCTest
import Foundation
@testable import Algorithms

final class TwoSATTests: XCTestCase {
    
    
    func testFile(_ i: Int) -> Bool{
        let url = URL.testFile(name: "2sat\(i).txt")
        
        let lines = try! String(contentsOf: url).components(separatedBy: .newlines)
        
        let n = Int(lines[0])!
        
        var g = Graph(n*2)
        for l in lines[1...] where l != "" {
            let line = l.components(separatedBy: .whitespaces)
            let v0 = Int(line[0])!, v1 = Int(line[1])!
            if v0 > 0 && v1 > 0 {
                // i*2-1 i true
                // i*2 i false
                g.addEdge(v0*2, v1*2-1)
                g.addEdge(v1*2, v0*2-1)
            } else if v0 > 0 && v1 < 0 {
                g.addEdge(v0*2, abs(v1)*2)
                g.addEdge(abs(v1)*2-1, v0*2-1)
            } else if v0 < 0 && v1 > 0 {
                g.addEdge(abs(v0)*2-1, v1*2-1)
                g.addEdge(v1*2, abs(v0)*2)
            } else if v0 < 0 && v1 < 0 {
                g.addEdge(abs(v0)*2-1, abs(v1)*2)
                g.addEdge(abs(v1)*2-1, abs(v0)*2)
            }
        }
        
        return g.TwoSATSatisfiable()
    }
    
    func test2SAT() {
       
        let x = (1...6)
            .map(testFile(_:))
            .map( {$0 ? "1" : "0"} )
            .joined()
        XCTAssertEqual(x, "101100")
    }
    
}
