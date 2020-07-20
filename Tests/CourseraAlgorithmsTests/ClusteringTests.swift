//
//  File.swift
//  
//
//  Created by lujiaheng on 2020/7/10.
//

import XCTest
import Foundation
@testable import Algorithms

extension KClustering {
    
    init(url: URL, k: Int) {
        let lines = try! String(contentsOf: url).split(separator: "\n")
        let n = Int(lines[0])!
        self = .init(nodes: n, k: k)
        
        for line in lines.dropFirst() {
            let data = line.split(separator: " ")
            addEdge(Int(data[0])!, q: Int(data[1])!, weight: Int(data[2])!)
        }
    }
}


final class ClusteringTests: XCTestCase {
    
    func testSmall() {
        var clustering = KClustering(url: URL.testFile(name: "clustering0.txt"), k: 2)
        XCTAssertEqual(clustering.maxSpacing(), 8)
    }
    
    func testBig() {
        var clustering = KClustering(url: URL.testFile(name: "clustering1.txt"), k: 4)
        XCTAssertEqual(clustering.maxSpacing(), 106)
    }
    
    func testBigger() {
        
        let url = URL.testFile(name: "clustering_big.txt")
        let lines = try! String(contentsOf: url).split(separator: "\n")
        
        let bits = Int(lines[0].split(separator: " ")[1])!
        let set = Set(lines.dropFirst()
                        .map{
                            Int($0.replacingOccurrences(of: " ", with: ""), radix: 2)!
                        })
        
        print("\(Date())")
        let count = largestKClustering(set, bits: bits)
        print("\(Date())")
        
        XCTAssertEqual(count, 6118)
        
        
    }
}
