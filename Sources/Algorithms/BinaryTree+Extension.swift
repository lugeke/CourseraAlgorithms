//
//  File.swift
//  
//
//  Created by lujiaheng on 2020/7/16.
//

import Foundation

extension BinaryTree: Keyable where T: Comparable {
    func key() -> T {
        switch self {
        case let .node(left: _, value: v, right: _):
            return v
        default:
            fatalError()
        }
    }
}
