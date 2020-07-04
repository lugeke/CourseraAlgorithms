//
//  File.swift
//  
//
//  Created by lujiaheng on 2020/7/4.
//

import Foundation


struct UnionFind {
    var id: [Int]
    var size: [Int]
    var count: Int
    
    init(n: Int) {
        count = n
        id = .init(repeating: 1, count: n+1)
        
        for i in 1...n {
            id[i] = i
        }
        size = .init(repeating: 1, count: n+1)
    }
    
    func connected(_ p: Int, _ q: Int) -> Bool {
        find(p) == find(q)
    }
    
    func find(_ p: Int) -> Int {
        var p = p
        while p != id[p]  {
            p = id[p]
        }
        return p
    }
    
    mutating func union(_ p: Int, _ q: Int) -> Int {
        let i = find(p)
        let j = find(q)
        guard i != j else {
            return i
        }
        
        if size[i] < size[j] {
            id[i] = j
            size[j] += size[i]
            count -= 1
            return j
        } else {
            id[j] = i
            size[i] += size[j]
            count -= 1
            return i
        }
    }
}
