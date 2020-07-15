//
//  File.swift
//  
//
//  Created by lujiaheng on 2020/7/15.
//

import Foundation

public func knapsack(_ items: [(value: Int, weight: Int)], weight: Int) -> Int {
    
    var A: [Int] = .init(repeating: 0, count: weight+1)
    
    for x in 0...weight {
        A[x] = 0
    }
    
    for i in 1..<items.count {
        let previous = A
        for x in  0...weight {
            let case2 = items[i].weight > x ? 0 : previous[x-items[i].weight] + items[i].value
            A[x] = max(previous[x], case2)
        }
    }
    
    return A[weight]
}
