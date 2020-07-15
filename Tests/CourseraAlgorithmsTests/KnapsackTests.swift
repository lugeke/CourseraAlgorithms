//
//  File.swift
//  
//
//  Created by lujiaheng on 2020/7/15.
//

import XCTest
@testable import Algorithms


final class KnapsackTests: XCTestCase {
    
    func testKnapsack() {
        let items = [(0, 0), (3,4), (2,3), (4,2), (4, 3)]
        XCTAssertEqual(knapsack(items, weight: 6), 8)
        XCTAssertEqual(knapsackRecursive(items, weight: 6), 8)
    }
    
    
    func testKnapsack1() {
        let url = URL.testFile(name: "knapsack1.txt")
        let lines = try! String(contentsOf: url).components(separatedBy: .newlines)
        let line0 = lines[0].components(separatedBy: .whitespaces)
        let size = Int(line0[0])!
        let n = Int(line0[1])!
        var items: [(Int,Int)] = [(0,0)]
        items.reserveCapacity(n+1)
        for i in 1...n{
            let line = lines[i].components(separatedBy: .whitespaces)
            
            items.append((Int(line[0])!, Int(line[1])!))
        }
        
        XCTAssertEqual(knapsack(items, weight: size), 2493893)
        XCTAssertEqual(knapsackRecursive(items, weight: size), 2493893)
    }
    
    func testKnapsackBig() {
        let url = URL.testFile(name: "knapsack_big.txt")
        let lines = try! String(contentsOf: url).components(separatedBy: .newlines)
        let line0 = lines[0].components(separatedBy: .whitespaces)
        let size = Int(line0[0])!
        let n = Int(line0[1])!
        var items: [(Int,Int)] = [(0,0)]
        items.reserveCapacity(n+1)
        for i in 1...n{
            let line = lines[i].components(separatedBy: .whitespaces)
            
            items.append((Int(line[0])!, Int(line[1])!))
        }
        
        XCTAssertEqual(knapsackRecursive(items, weight: size), 4243395)
    }
    
}
