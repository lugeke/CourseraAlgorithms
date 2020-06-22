//
//  File.swift
//  
//
//  Created by lujiaheng on 2020/6/22.
//

import XCTest
@testable import Algorithms


final class SchduleTests: XCTestCase {
    
    static var jobs: [Job] = []
    
    override class func setUp() {
        let url = URL.testFile(name: "jobs.txt")
        let lines = try! String(contentsOf: url).components(separatedBy: .newlines).lazy.filter({ !$0.isEmpty })
        jobs.reserveCapacity(Int(lines.first!)!)
        
        for line in lines.dropFirst() {
            let  l = line.components(separatedBy: .whitespaces)
            jobs.append(Job(weight: Int(l[0])!, length: Int(l[1])!))
        }
        
    }
    
    /// schedules jobs in decreasing order of the difference (weight - length). if two jobs have equal difference (weight - length), you should schedule the job with higher weight first.
    func testByDifference() {
        let sum = schdule(jobs: Self.jobs) { a, b in
            if a.weight-a.length == b.weight-b.length {
                return a.weight > b.weight
            } else {
                return a.weight-a.length > b.weight-b.length
            }
        }
        print(sum)
    }
    
    ///  schedules jobs (optimally) in decreasing order of the ratio (weight/length)
    func testByRatio() {
        let sum = schdule(jobs: Self.jobs) { a, b in
            a.weight/a.length < b.weight/b.length 
        }
        print(sum)
    }
    
}

