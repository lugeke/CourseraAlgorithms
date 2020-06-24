//
//  File.swift
//  
//
//  Created by lujiaheng on 2020/6/24.
//

import Foundation

extension Array where Element: Comparable {
    
    /// sort array using merge sort
    /// - Parameter pivotPolicy: choose which element becomes pivot
    /// - Returns: the number of comparions used to sort
    mutating func quickSort(pivotPolicy: ((inout Self, Range<Int>) -> ())? = nil) -> Int {
        quickSort(range: 0..<count, pivotPolicy: pivotPolicy)
    }

    
    mutating func quickSort(range: Range<Int>, pivotPolicy: ((inout Self, Range<Int>) -> ())? = nil) -> Int {
        guard range.count > 1 else {
            return 0
        }
        
        
        var i = range.lowerBound + 1
        var j = i
        
        pivotPolicy?(&self, range)
        
        let pivot = self[range.lowerBound]
        while j < range.upperBound {
            if self[j] < pivot {
                swapAt(i, j)
                i += 1
            }
            j += 1
        }
        
        swapAt(range.lowerBound, i-1)
        
        var sum = range.count - 1
        if i - 2 > range.lowerBound {
            sum += quickSort(range: range.prefix(upTo: i-1), pivotPolicy: pivotPolicy)
        }
        if i < range.upperBound {
            sum += quickSort(range: range.suffix(from: i), pivotPolicy: pivotPolicy)
        }
        return sum
    }
}
