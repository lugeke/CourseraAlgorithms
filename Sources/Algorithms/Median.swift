//
//  File.swift
//  
//
//  Created by lujiaheng on 2020/7/8.
//

import Foundation

struct Median {
    var lowHalf = Heap(type: .max)
    var highHalf = Heap(type: .min)
    
    mutating func insert(_ n: Int) {
        if count == 0 { lowHalf.insert(n) }
        else {
            let lowHalfMax = lowHalf.peek()!
            if  n <= lowHalfMax {
                lowHalf.insert(n)
            } else {
                highHalf.insert(n)
            }
            
            // balance two heap
            // invariant  0 <= lowHalf.count - highHalf.count <= 1
            if highHalf.count > lowHalf.count {
                let x = highHalf.extract()!
                lowHalf.insert(x)
            }else if lowHalf.count - highHalf.count == 2 {
                let x = lowHalf.extract()!
                highHalf.insert(x)
            }
            
            
        }
        
        
    }
    
    var count: Int {
        lowHalf.count + highHalf.count
    }
    
    var median: Int?{
        lowHalf.peek()
    }
    
    
        
}
