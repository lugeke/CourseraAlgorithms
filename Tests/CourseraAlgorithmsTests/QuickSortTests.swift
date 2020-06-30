//
//  File.swift
//  
//
//  Created by lujiaheng on 2020/6/24.
//

import XCTest
@testable import Algorithms

final class quickSortTests: XCTestCase {
    
    func testSort() {
        var ary = Array(1...100)
        ary.shuffle()
        
        print(ary)
        
        let _ = ary.quickSort()
        
        XCTAssertEqual(ary, Array(1...100))
    }
    
    func byLastElement(_ array: inout Array<Int>,_ range: Range<Int>) {
        array.swapAt(range.lowerBound, range.upperBound-1)
    }
    
    func byMedianElement(_ array: inout Array<Int>,_ range: Range<Int>) {
        let first = range.lowerBound
        let final = range.upperBound-1
        let middle = first + (final-first)/2
        let median = [first, middle, final].sorted(by: {array[$0] < array[$1]})[1]
        array.swapAt(range.lowerBound, median)
    }
    
    func testCount() {
        var ary = [3, 2, 1, 4]
        
        //use first element as pivot
        XCTAssertEqual(ary.quickSort(), 4)
        XCTAssertEqual(ary, [1, 2 ,3, 4])
        
        //use final element as pivot
        ary = [3, 2, 1, 4]
        var count = ary.quickSort(pivotPolicy: byLastElement(_:_:))
        
        XCTAssertEqual(count, 6)
        XCTAssertEqual(ary, [1, 2 ,3, 4])
        
        //use median element as pivot
        ary = [3, 2, 1, 4]
        count = ary.quickSort(pivotPolicy: byMedianElement(_:_:))
        
        XCTAssertEqual(count, 4)
        XCTAssertEqual(ary, [1, 2 ,3, 4])
    }
    
    func testCountBig() {
        let url = URL.testFile(name: "QuickSort.txt")
//        let l = try! String(contentsOf: url)
        let lines = try! String(contentsOf: url).split(separator: "\r\n")
        let m = 10000
        var ary = [Int].init()
        ary.reserveCapacity(m)
        for i in 0..<m {
            ary.append(Int(lines[i])!)
        }
        
        let original = ary
        
        var count = ary.quickSort()
        XCTAssertEqual(count, 162085)
        XCTAssertEqual(ary, Array(1...m))
        
        ary = original
        count = ary.quickSort(pivotPolicy: byLastElement(_:_:))
        XCTAssertEqual(count, 164123)
        XCTAssertEqual(ary, Array(1...m))
        
        
        ary = original
        count = ary.quickSort(pivotPolicy: byMedianElement(_:_:))
        XCTAssertEqual(count, 138382)
        XCTAssertEqual(ary, Array(1...m))
        
        
    }
    
}
