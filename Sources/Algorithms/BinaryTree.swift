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
    
}

extension BinaryTree {
    var isLeaf: Bool {
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

extension BinaryTree {
    public init() {
        self = .null
    }
    
    public init(_ value: T) {
        self = .node(left: .null, value: value, right: .null)
    }
}


extension BinaryTree {
    public func inorder(_ f: (T) -> ()){
        switch self {
        case .null:
            return
        case let .node(left: l, value: v, right: r):
            l.inorder(f)
            f(v)
            r.inorder(f)
        }
    }
    
    public func preorder(_ f: (T) -> ()){
        switch self {
        case .null:
            return
        case let .node(left: l, value: v, right: r):
            f(v)
            l.inorder(f)
            r.inorder(f)
        }
    }
    
    public func postorder(_ f: (T) -> ()){
        switch self {
        case .null:
            return
        case let .node(left: l, value: v, right: r):
            l.inorder(f)
            r.inorder(f)
            f(v)
        }
    }
}


extension BinaryTree {
    
    
    func _isBalanced(height: inout Int) -> Bool {
                switch self {
                case .null:
                    height = 0
                    return true
                case let .node(left: l, value: _, right: r):
                    var lHeight = 0, rHeight = 0
                    let balanced = l._isBalanced(height: &lHeight) && r._isBalanced(height: &rHeight)
                    height = max(lHeight, rHeight) + 1
                    return balanced && abs(lHeight - rHeight) <= 1
                }
            }

    public var isBalanced: Bool {
        var height = 0
        return _isBalanced(height: &height)
    }
}

extension BinaryTree: Equatable where T: Equatable {}


