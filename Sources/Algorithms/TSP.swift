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


public func tspNearestNeighbor(_ graph: [[Double]]) -> Double {
    
    var currentCity = 1
    var currentTour: [Int] = []
    let n = graph.count - 1
    currentTour.reserveCapacity(n)
    currentTour.append(currentCity)
    var visited = [Bool](repeating: false, count: n+1)
    visited[0] = true
    visited[1] = true
    while currentTour.count < n-1 {
        
        let nextCity = graph[currentCity].enumerated()
            .filter({!visited[$0.offset]}).min(by: {$0.element < $1.element} )!.offset
        currentTour.append(nextCity)
        visited[nextCity] = true
        currentCity = nextCity
    }
    currentTour.append(visited.firstIndex(of: false)!)
    currentTour.append(1)
    
    var tour = 0.0
    for i in 0..<currentTour.count-1 {
        tour += sqrt(graph[currentTour[i]][currentTour[i+1]])
    }
    
    return tour
}
