//
//  File.swift
//  
//
//  Created by lujiaheng on 2020/7/8.
//

import XCTest
@testable import Algorithms


final class MedianTests: XCTestCase {
    
    func testHeap() {
        
        var h = Heap()
        h.insert(5)
        h.insert(4)
        h.insert(3)
        h.insert(2)
        
        XCTAssertEqual(h.extract(), 2)
        XCTAssertEqual(h.extract(), 3)
        XCTAssertEqual(h.extract(), 4)
        XCTAssertEqual(h.extract(), 5)
        XCTAssertEqual(h.extract(), nil)
        
    }
    
    func testMedianSmall() {
        var m = Median()
        XCTAssertEqual(m.median, nil)
   
        m.insert(3)
        XCTAssertEqual(m.median, 3)
        m.insert(2)
        XCTAssertEqual(m.median, 2)
        m.insert(4)
        XCTAssertEqual(m.median, 3)
        m.insert(5)
        XCTAssertEqual(m.median, 3)
        m.insert(1)
        XCTAssertEqual(m.median, 3)

    }
    
    func testMedian() {
        let url = URL.testFile(name: "Median.txt")
        let lines = try! String(contentsOf: url).split(separator: "\r\n")
        var m = Median()
        var sum = 0
        for l in lines {
            m.insert(Int(l)!)
            sum = sum + m.median!
        }
        XCTAssertEqual(sum, 46831213)
    }
    
    
}
