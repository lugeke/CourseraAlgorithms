//
//  File.swift
//  
//
//  Created by lujiaheng on 2020/7/14.
//

import Foundation

func maximumWeightIndependentSet(weights: [Int]) -> Set<Int> {
    var maxs = [Int].init(repeating: 0, count: weights.count+1)
    maxs[1] = weights[0]
    
    for i in 2..<maxs.count {
        maxs[i] = max(maxs[i-1], maxs[i-2] + weights[i-1])
    }
    
    var result: Set<Int> = []
    
    var i = maxs.count - 1
    while i >= 1 {
        // not including i
        if i >= 2 && maxs[i-1] >= maxs[i-2] + weights[i-1] {
            i -= 1
        } else {
            result.insert(i)
            i -= 2
        }
    }
    
    return result
}
