//
//  File.swift
//  
//
//  Created by lujiaheng on 2020/6/20.
//

import Foundation

extension URL {
    static func testFile(name: String) -> URL {
        URL(fileURLWithPath: #file)
        .deletingLastPathComponent()
        .appendingPathComponent("Resources")
        .appendingPathComponent(name)
    }
}
