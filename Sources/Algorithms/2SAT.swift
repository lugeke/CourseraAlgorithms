//
//  File.swift
//  
//
//  Created by lujiaheng on 2020/7/26.
//

import Foundation

extension Graph {
    // variable i = true represent by node i*2-1
    // variable i = false represent by node i*2
    // the 2SAT problem reduce to if there is a SCC contain both variable i and not i
    public func TwoSATSatisfiable() -> Bool {
        let scc = SCC().filter { $0.count > 1 }
        for s in scc {
            let s = s.sorted()
            for (current, previous) in zip(s.dropFirst(), s) {
                if previous + 1 == current && current.isMultiple(of: 2) {
                    return false
                }
            }
            
        }
        return true
    }
}
