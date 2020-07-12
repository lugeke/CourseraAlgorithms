//
//  File.swift
//  
//
//  Created by lujiaheng on 2020/7/12.
//

import Foundation


extension Graph {
    func floydMarshallAllPairsShortestPaths() -> [[Double]]? {
        
        var A: [[Double]] = .init(repeating: .init(repeating: .infinity, count: adjList.count),
                                                     count: adjList.count)
        
        for i in 1..<adjList.count {
            for j in 1..<adjList.count {
                A[i][j] = distance(i, j)
            }
        }
        
        for k in 1..<adjList.count {
            let previous = A
            for i in 1..<adjList.count {
                for j in 1..<adjList.count {
                    A[i][j] = min(previous[i][j], previous[i][k] + previous[k][j])
                }
            }
        }
        
        for i in 1..<adjList.count {
            if A[i][i] < 0 { return nil }
        }
        
        return A
        
    }
    
    public func shortestOfShortestPaths() -> Double? {
        
        guard let pairs = floydMarshallAllPairsShortestPaths() else {
            
            return nil
        }
        
        var shortest = Double.infinity
        
        
        for i in 1..<adjList.count {
            for j in 1..<adjList.count where i != j {
                shortest = min(shortest, pairs[i][j])
            }
            
        }
        
        return shortest
    }
}
