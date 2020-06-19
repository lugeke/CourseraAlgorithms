//
//  File.swift
//  
//
//  Created by lujiaheng on 2020/6/17.
//

import Foundation


func inversions(_ ary: [Int]) -> Int {
    
    /// merge the two sorted sub-array while compute the inversion count that split two sub-array
    func countSplit(_ ary: inout [Int], start: Int, middle: Int, end: Int) -> Int {
        var sorted: [Int] = .init(repeating: 0, count: end-start+1)
        var i = start, j = middle+1, k = 0
        var result = 0
        while i<=middle && j <= end {
            if ary[i] <= ary[j] {
                sorted[k] = ary[i]
                k += 1
                i += 1
            } else {
                sorted[k] = ary[j]
                k += 1
                j += 1
                result += middle - i + 1
            }
        }
        
        
        while k < end-start+1 {
            if i > middle {
                sorted[k] = ary[j]
                k += 1
                j += 1
            } else {
                sorted[k] = ary[i]
                k += 1
                i += 1
            }
        }
        
        ary.replaceSubrange(start...end, with: sorted)
        
        
        return result
    }
    
    func sortAndCount(_ ary: inout [Int], start: Int, end: Int) -> Int {
        if start >= end {
            return 0
        }
        
        let middle = start + (end - start) / 2
        let left = sortAndCount(&ary, start: start, end: middle)
        let right = sortAndCount(&ary, start: middle+1, end: end)
        let split = countSplit(&ary, start: start, middle: middle, end: end)
        return left + right + split
        
    }
    
    var ary = ary
    return sortAndCount(&ary, start: 0, end: ary.count-1)
    
}
