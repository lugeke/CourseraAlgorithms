//
//  File.swift
//  
//
//  Created by lujiaheng on 2020/7/9.
//

import Foundation



public func twoSum(_ ary: [Int], range: ClosedRange<Int>) -> Int {
    
    var sortAry = Array(Set(ary))
    sortAry.sort()
    
    // use binary search to find the index of n
    func find(_ n: Int) -> Int {
        var low = 0, high = sortAry.count-1
        var mid = 0
        while low <= high {
            mid = low + (high - low) / 2
            if sortAry[mid] == n { return mid}
            else if n < sortAry[mid] { high = mid-1}
            else { low = mid+1}
        }
        
        if low == mid {
            return max(high, 0)
        } else {
            return min(low, sortAry.count-1)
        }
    }
    
    
    
//    print("\(Date())")
    var counter: Set<Int> = []
    
    // for every element in the array, find the boundary between range.lowerBound - i...range.upperBound - i
    // and count the element in the range
    for i in sortAry {
        let low = find(range.lowerBound - i)
        let high = find(range.upperBound - i)
        
        for index in low...high {
            guard sortAry[index] != i else {
                continue
            }
            let sum = i + sortAry[index]
            if range.contains(sum) {
                counter.insert(sum )
            }
            
        }
    }
//    print("\(Date())")
    return counter.count

}
