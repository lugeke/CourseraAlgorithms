//
//  File.swift
//  
//
//  Created by lujiaheng on 2020/7/15.
//

import Foundation

public func knapsack(_ items: [(value: Int, weight: Int)], weight: Int) -> Int {
    
    var A: [Int] = .init(repeating: 0, count: weight+1)
    
    for i in 1..<items.count {
        let previous = A
        for x in  0...weight {
            let case2 = items[i].weight > x ? 0 : previous[x-items[i].weight] + items[i].value
            A[x] = max(previous[x], case2)
        }
    }
    
    return A[weight]
}


public func knapsackRecursive(_ items: [(value: Int, weight: Int)], weight: Int) -> Int {
    
    struct IX: Hashable {
        let i: Int
        let x: Int
    }
    
    var dict: [IX: Int] = [:]
    
    // sort by weight, can speed up the recursive process
    let items = items.sorted(by: { $0.1 < $1.1})
    
    func A(_ i: Int, _ x: Int) -> Int {
        
        if i == 0 || x == 0 {
            return 0
        }
        
        let ix = IX(i: i,x: x)
        if let result = dict[ix] {
            return result
        }
        
        let case2 = items[i].weight > x ? 0 : A(i-1, x-items[i].weight)+items[i].value
        let m = max(A(i-1, x), case2)
        dict[ix] = m
        return m
        
    }
    
    let m =  A(items.count-1, weight)
    print("dict count \(dict.count)")
    return m
}
