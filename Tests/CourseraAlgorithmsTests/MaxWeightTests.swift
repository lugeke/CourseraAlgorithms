//
//  File.swift
//  
//
//  Created by lujiaheng on 2020/7/14.
//

import Foundation

import XCTest
@testable import Algorithms


final class MaxWeightTests: XCTestCase {
    
    func testMax() {
        let weights = [1,4,5,4]
        
        let set = maximumWeightIndependentSet(weights: weights)
        XCTAssertEqual(set, [2,4])
    }
    
    func testMaxBig() {
        let url = URL.testFile(name: "mwis.txt")
        let lines = try! String(contentsOf: url).components(separatedBy: .newlines)
        let count = Int(lines[0])!
        var weights: [Int] = []
        weights.reserveCapacity(count)
        for i in 1...count{
            weights.append(Int(lines[i])!)
        }
        
        let set = maximumWeightIndependentSet(weights: weights)
        
        let result = [1, 2, 3, 4, 17, 117, 517, 997].map {
            set.contains($0) ? "1" : "0"
        }.joined()
        
        XCTAssertEqual(result, "10100110")
    }
    
}
