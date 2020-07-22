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


public func tspNearestNeighbor(_ points: [(x: Double, y: Double)]) -> Double {
    
    var currentCity = 1
    var distances: [Double] = []
    let n = points.count - 1
    distances.reserveCapacity(n)
    var visited = [Bool](repeating: false, count: n+1)
    visited[0] = true
    visited[currentCity] = true
    while distances.count < n - 1 {
        
        var minDist = Double.infinity, index = currentCity
        
        // because points are sorted by x,
        // u can compute min distance from both directions, currentCity+1..<n+1 and 1..<currentCity
        // break as soon as horizontal distance bigger than current min distance
        for i in currentCity+1..<n+1 {
            if visited[i] { continue }
            let x = (points[currentCity].x - points[i].x)*(points[currentCity].x - points[i].x)
            if x > minDist { break }
            let dis =  x + (points[currentCity].y - points[i].y)*(points[currentCity].y - points[i].y)
            if dis < minDist {
                minDist = dis
                index = i
            }
            
        }
        
        for i in (1..<currentCity).reversed() {
            if visited[i] { continue }
            let x = (points[currentCity].x - points[i].x)*(points[currentCity].x - points[i].x)
            if x > minDist { break }
            let dis =  x + (points[currentCity].y - points[i].y)*(points[currentCity].y - points[i].y)
            if dis <= minDist {
                minDist = dis
                index = i
            }
        }
        let nextCity = index
        distances.append(minDist)
        visited[nextCity] = true
        currentCity = nextCity
    }
    
    let lastDistance = (points[currentCity].x - points[1].x)*(points[currentCity].x - points[1].x)
        + (points[currentCity].y - points[1].y)*(points[currentCity].y - points[1].y)
 
    distances.append(lastDistance)
    
    return distances.reduce(0.0) { $0 + sqrt($1) }
    
}
