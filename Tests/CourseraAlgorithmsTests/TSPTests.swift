//
//  File.swift
//  
//
//  Created by lujiaheng on 2020/7/19.
//

import Foundation
import XCTest
@testable import Algorithms


final class TSPTests: XCTestCase {

    func testChoose() {
        let x = [1,2,3,4,5]
        
        print(x.choose(n: 1))
        print(x.choose(n: 2))
        print(x.choose(n: 3))
        print(x.choose(n: 4))
        print(x.choose(n: 5))
    }
    
    func testTSP() {
        var g = Graph(4)
        g.addEdge(1, 2, weight: 2)
        g.addEdge(1, 3, weight: 1)
        g.addEdge(1, 4, weight: 4)
        g.addEdge(2, 3, weight: 3)
        g.addEdge(2, 4, weight: 5)
        g.addEdge(3, 4, weight: 6)
        
        g.addEdge(2, 1, weight: 2)
        g.addEdge(3, 1, weight: 1)
        g.addEdge(4, 1, weight: 4)
        g.addEdge(3, 2, weight: 3)
        g.addEdge(4, 2, weight: 5)
        g.addEdge(4, 3, weight: 6)
        
        XCTAssertEqual(g.tsp(), 13) 
    }
    
    func testTSPBig() {
        let url = URL.testFile(name: "tsp.txt")
        let lines = try! String(contentsOf: url).components(separatedBy: .newlines)
        let n = Int(lines[0])!

        var points: [(Double, Double)] = [(0,0)]
        for i in 1...n {
            let line = lines[i].components(separatedBy: .whitespaces)
            points.append((Double(line[0])!, Double(line[1])!))
        }

        var g1 = Graph(13)

        for i in 1...13 {
            for j in i+1..<14 {
                let dis = sqrt(
                    (points[i].0 - points[j].0)*(points[i].0 - points[j].0)
                    + (points[i].1 - points[j].1)*(points[i].1 - points[j].1)
                )
                g1.addEdge(i, j, weight: dis)
                g1.addEdge(j, i, weight: dis)
            }
        }

        let x1 = g1.tsp()
         


        var g2 = Graph(14)

        for i in 12...25 {
            for j in i+1..<26 {
                let dis = sqrt(
                    (points[i].0 - points[j].0)*(points[i].0 - points[j].0)
                    + (points[i].1 - points[j].1)*(points[i].1 - points[j].1)
                )
                g2.addEdge(i-11, j-11, weight: dis)
                g2.addEdge(j-11, i-11, weight: dis)
            }
        }

        let x2 = g2.tsp()

        let x = x1 + x2 - g1.distance(12, 13)*2

        XCTAssertEqual(Int(x), 26442)
    }
}
