//
//  File.swift
//  
//
//  Created by lujiaheng on 2020/7/19.
//

import Foundation

extension Graph {
    
    public func tsp() -> Double {
        
        let n = adjList.count-1
        
        struct A {
            struct Sj: Hashable {
                let S: Set<Int>
                let j: Int
            }
            static var dict: [Sj: Double] = [:]
            static subscript(_ S: Set<Int>, _ j: Int) -> Double {
                get {
                    if j == 1 {
                        if S == [1] {
                            return 0
                        } else {
                            return .infinity
                        }
                    }
                    let sj = Sj(S: S, j: j)
                    return  dict[sj]!
                }
                
                set {
                    dict[Sj(S: S, j: j)] = newValue
                }
            }
        }

        
        for m in 2...n {
            for var s in (2...n).choose(n: m-1) {
                s.insert(1)
                
                for j in s where j != 1 {
                    var minium = Double.infinity
                    for k in s where k != j {
            
                        minium = min(minium, A[s.subtracting([j]), k] + distance(k, j))
                    }
                    A[s, j] = minium
                }
            }
        }
        
        let mins = (2...n).map {
            A[Set(1...n), $0] + distance($0, 1)
        }
        
        return mins.min()!
    }
}

extension Collection where Element: Hashable {
    
    func choose(n: Int) -> [Set<Element>] {
        let count = self.count
        guard (1...count).contains(n)  else {
            return []
        }
        
        var indices: [Index] = .init(repeating: startIndex, count: n)
        
        // 1 <= i <= n
        // offset from endIndex
        var i = n
        
        var result: [Set<Element>] = []
        
        while i <= n {
            
            var t = indices[n-i]
            // 1 <= i <= n
            while i - 1 >= 1 {
                formIndex(after: &t)
                i -= 1
                indices[n-i] = t
            }
            
            while indices[n-1] <= self.index(endIndex, offsetBy: -1) {
                let s = Set(indices.map{ self[$0]})
                result.append(s)
                formIndex(after: &indices[n-i])
            }
            
            while i <= n {
                if indices[n-i] < self.index(endIndex, offsetBy: -i) {
                    formIndex(after: &indices[n-i])
                    break
                }
                i += 1
            }
            
            
        }
        
        
        
        
        return result
    }
}
