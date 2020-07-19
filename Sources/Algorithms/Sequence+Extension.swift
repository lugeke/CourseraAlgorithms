//
//  File.swift
//  
//
//  Created by lujiaheng on 2020/7/19.
//

extension Sequence where Element: Hashable {
    
    func choose(m: Int) -> [[Element]] {
        
        let ary = Array(self)
        let n = ary.count
        
        guard (1...n).contains(m)  else {
            return []
        }
        
        /// m different indices of ary, change indices to produce all combinations
        /// - Invariant: elements in strictly increase order
        /// indices[i-1] < indices[i] <= n - m + i
        var indices:[Int] = Array(ary.indices.prefix(m))
        
        var result: [[Element]] = []
        
        outer: while true{
            
            // map to ary element
            let part = indices.dropLast().map { ary[$0] }
            // increase last element up to n
            result += (indices[m-1]..<n).map { part + [ary[$0]] }
            
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
            
            break
        }
        
        return result
    }
}
