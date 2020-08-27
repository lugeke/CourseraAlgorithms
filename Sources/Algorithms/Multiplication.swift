//
//  Multiplication.swift
//  CourseraAlgorithms
//
//  Created by lujiaheng on 2020/6/15.
//  Copyright © 2020 lujiaheng. All rights reserved.
//

import Foundation

func add(_ x: [UInt8], _ y: [UInt8]) -> [UInt8] {
    var carry: UInt8 = 0
    var xIterator = x.drop(while: {$0 == 0}).reversed().makeIterator()
    var yIterator = y.drop(while: {$0 == 0}).reversed().makeIterator()
    var result: [UInt8] = []
    
    outer: while true {
        switch (xIterator.next(), yIterator.next()) {
        case (nil, nil):
            break outer
        case let (i, j):
            let i = i ?? 0
            let j = j ?? 0
            let remainder: UInt8
            (carry, remainder) = (i + j + carry).quotientAndRemainder(dividingBy: 10)
            result.append(remainder)
        }
    }
    
    if carry != 0 { result.append(carry) }
    return result.reversed()
}

public func multiplication(_ x: String, _ y: String) -> String {
    
    /// split the `x` and `y` in half, 
    func multip(_ x: ArraySlice<UInt8>, _ y: ArraySlice<UInt8>) -> [UInt8] {
        
        if x.count == 1  {
            let sum = x.first! * y.first!
            let (carry, least) = sum.quotientAndRemainder(dividingBy: 10)
            if carry > 0 { return [carry, least]}
            else { return [least] }
        }
        
        let n = x.count / 2
        let a = x.prefix(n), b = x.suffix(n)
        let c = y.prefix(n), d = y.suffix(n)
        var ac = multip(a, c)
        let bd = multip(b, d)
        var adAddbc = add(multip(a, d), multip(b, c))
        ac.append(contentsOf: repeatElement(0, count: x.count))
        adAddbc.append(contentsOf: repeatElement(0, count: n))
        return add(add(ac, adAddbc), bd)
    }
    
    var x = x.map { UInt8($0.wholeNumberValue!) }
    var y = y.map { UInt8($0.wholeNumberValue!) }
    
    // add leading zeros
    var paddings = max(x.count, y.count)
    paddings += paddings.isMultiple(of: 2) ? 0 : 1
    
    x.insert(contentsOf: repeatElement(0, count: paddings - x.count), at: 0)
    y.insert(contentsOf: repeatElement(0, count: paddings - y.count), at: 0)
    
    return multip(x[...], y[...]).lazy.map{ String($0) }.joined()
}

