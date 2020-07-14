//
//  File.swift
//  
//
//  Created by lujiaheng on 2020/7/14.
//

protocol Keyable {
    associatedtype Key where Key: Comparable
    func key() -> Key
}

extension Keyable where Self: Comparable {
    func key() -> Self {
        self
    }
}

extension Int: Keyable {}
