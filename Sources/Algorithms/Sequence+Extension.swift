//
//  File.swift
//  
//
//  Created by lujiaheng on 2020/7/19.
//

/// A Sequences for all combinations
struct Combination<S>: Sequence, IteratorProtocol where S: Sequence{
    typealias Element = [S.Element]
    
   
    let ary: [S.Element]
    // the total count of ary
    let n: Int
    // the count of a combination
    let m: Int
    /// m different indices of ary, increase indices from last to first to produce all combinations
    /// - Invariant: indices are in strictly increase order,
    /// indices[i-1] < indices[i] <= n - m + i
    var indices:[Int]
    
    var currentCombination: Element {
        indices.map { ary[$0] }
    }
    
    mutating func next() -> Element? {
        outer: while true{
            
            if indices[m-1] < n {
                defer {
                    indices[m-1] += 1
                }
                return currentCombination
            }
            
            // traverse index from m-2 to 0
            for i in (0..<m-1).reversed() {
                // increase index i
                if indices[i] < n - m + i {
                    indices[i] += 1
                    // maintain invariant
                    for x in i+1..<m {
                        indices[x] = indices[x-1] + 1
                    }
                    
                    continue outer
                }
            }
            
            return nil
        }
    }
    
    init(_ s: S, m: Int) {
        ary = .init(s)
        n = ary.count
        self.m = m
        indices = Array(ary.indices.prefix(m))
        assert((1...n).contains(m))
    }
    
}

extension Sequence where Element: Hashable {
    
    func choose(m: Int) -> AnySequence<[Element]>{
        
        AnySequence(Combination(self, m: m))
        
    }
    
}
