//
//  File.swift
//  
//
//  Created by lujiaheng on 2020/6/19.
//

import XCTest
@testable import Algorithms

final class InversionsTests: XCTestCase {
    
    func testInversions() {
        XCTAssertEqual(inversions([1,2,3]), 0)
        XCTAssertEqual(inversions([3,2,1]), 3)
        XCTAssertEqual(inversions([3]), 0)
        XCTAssertEqual(inversions([1,3,5,2,4,6]), 3)
        
        
        let url = URL.testFile(name: "IntegerArray.txt")
        
        let lines = try! String(contentsOf: url).split(separator: "\r\n")
        
        var ary: [Int] = []
        ary.reserveCapacity(100000)
        for line in lines {
            ary.append(Int(line)!)
        }
        print(inversions(ary))
    }
    

    static var allTests = [
        ("testInversions", testInversions),
    ]
}
