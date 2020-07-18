//
//  File.swift
//  
//
//  Created by lujiaheng on 2020/7/14.
//

import Foundation



public enum BinaryTree<T> {
    case null
    indirect case node(left: BinaryTree,value: T, right: BinaryTree)
    
    func isLeaf() -> Bool {
        switch self {
        case .node(left: .null, value: _, right: .null):
            return true
        default:
            return false
        }
    }
}


extension BinaryTree: ExpressibleByNilLiteral {
    
    public init(nilLiteral: ()) {
        self = .null
    }
    
}

extension BinaryTree: Equatable where T: Equatable {}


