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
    let xIterator = x.reversed().makeIterator()
    let yIterator = y.reversed().makeIterator()

    let s: UnfoldSequence<(UInt8, UInt8), (ReversedCollection<[UInt8]>.Iterator, ReversedCollection<[UInt8]>.Iterator)> = sequence(state: (xIterator, yIterator)) {
        switch ($0.0.next(), $0.1.next()) {
        case let (x?, y?): return (x, y)
        case (nil , let y?): return (0, y)
        case (let x?,  nil): return (x, 0)
        case (nil, nil): return nil
        }
    }

    var result: [UInt8] = s.map { i, j in
        let sum = i + j + carry
        carry = sum / 10
        return sum % 10
    }

    if carry != 0 {
        result.append(carry)
    }
    return Array(result.reversed().drop(while: {$0 == 0}))
}



public func multiplication(_ x: String, _ y: String) -> String {
    
    
    /// split the `x` and `y` in half, 
    func multip(_ x: ArraySlice<UInt8>, _ y: ArraySlice<UInt8>) -> [UInt8] {
        
        if x.count == 1  {
            let sum = x.first! * y.first!
            let least = sum % 10
            let carry = sum / 10
            if carry > 0 { return [carry, least]}
            else { return [least] }
        }
        
        let n = x.count / 2
        let a = x.prefix(n), b = x.suffix(n)
        let c = y.prefix(n), d = y.suffix(n)
        var ac = multip(a, c)
        let bd = multip(b, d)
        var adAddbc = add(multip(a, d), multip(b, c))
        ac.append(contentsOf: Array.init(repeating: 0, count: x.count))
        adAddbc.append(contentsOf: Array.init(repeating: 0, count: n))
        return add(add(ac, adAddbc), bd)
    }
    
    var x = x.map { UInt8($0.wholeNumberValue!) }
    var y = y.map { UInt8($0.wholeNumberValue!) }
    
    var max = Swift.max(x.count, y.count)
    max = max.isMultiple(of: 2) ? max : max + 1
    
    x.insert(contentsOf: Array.init(repeating: 0, count: max - x.count), at: 0)
    y.insert(contentsOf: Array.init(repeating: 0, count: max - y.count), at: 0)
    
    
    return multip(x[...], y[...]).lazy.map{ String($0)}.joined()
}

