//
//  File.swift
//  
//
//  Created by lujiaheng on 2020/7/14.
//

import XCTest
@testable import Algorithms


final class HuffmanCodingTests: XCTestCase {
    
    func testCoding() {
        let weights = [1,2,3,4,5]
        var huffman = HuffmanCoding(weights: weights)
        let coding = huffman.codings()
        
        
        XCTAssertEqual(coding[1]?.count, 3)
        XCTAssertEqual(coding[2]?.count, 3)
        XCTAssertEqual(coding[3]?.count, 2)
        XCTAssertEqual(coding[4]?.count, 2)
        XCTAssertEqual(coding[5]?.count, 2)
    }
    
    func testCoding1() {
        let weights = [1,2,3,6,12]
        var huffman = HuffmanCoding(weights: weights)
        let coding = huffman.codings()
        
        print(coding)
        
        
        XCTAssertEqual(coding[1]?.count, 4)
        XCTAssertEqual(coding[2]?.count, 4)
        XCTAssertEqual(coding[3]?.count, 3)
        XCTAssertEqual(coding[6]?.count, 2)
        XCTAssertEqual(coding[12]?.count, 1)
    }
    
    func testCodingBig() {
        let url = URL.testFile(name: "huffman.txt")
        let lines = try! String(contentsOf: url).components(separatedBy: .newlines)
        let count = Int(lines[0])!
        var weights: [Int] = []
        weights.reserveCapacity(count)
        for i in 1...count{
            weights.append(Int(lines[i])!)
        }
        var huffman = HuffmanCoding(weights: weights)
        let heights = huffman.codings().values.map(\.count)
        print(heights)
        XCTAssertEqual(heights.min(), 9)
        XCTAssertEqual(heights.max(), 19)
    }
    
    
}
