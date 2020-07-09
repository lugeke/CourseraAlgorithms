//
//  File.swift
//
//
//  Created by lujiaheng on 2020/6/20.
//

import XCTest
import Foundation
@testable import Algorithms




final class TwoSumTests: XCTestCase {
    
    
    func testSmall() {
        let ary = [1,2,3,4,5]
        
        XCTAssertEqual(twoSum(ary, range: 5...6), 2)
        XCTAssertEqual(twoSum(ary, range: 3...9), 7)
        XCTAssertEqual(twoSum(ary, range: 10...11), 0)
    }
    
    func testBig() {
        let url = URL.testFile(name: "2sum.txt")
        let lines = try! String(contentsOf: url).split(separator: "\n")
        var ary = [Int]()
        ary.reserveCapacity(1000000)
        for l in lines {
            ary.append(Int(l)!)
        }
        
        XCTAssertEqual(twoSum(ary, range: -10000...10000), 427)
    }
}
