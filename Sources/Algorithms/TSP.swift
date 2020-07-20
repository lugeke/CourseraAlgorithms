//
//  File.swift
//  
//
//  Created by lujiaheng on 2020/7/19.
//

import Foundation

extension Graph {
    
    public func tsp() -> Double {
        
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
            for  x in (2...n).choose(m: m-1) {
                
                let s = Set(x + CollectionOfOne(1))
                
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


