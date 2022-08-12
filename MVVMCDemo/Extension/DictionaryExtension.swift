//
//  DictionaryExtension.swift
//  MVVMCDemo
//
//  Created by Book on 2022/8/9.
//

import Foundation

extension Dictionary {
    var JSON: Data {
        do {
            return try JSONSerialization.data(withJSONObject: self, options: .prettyPrinted)
        } catch {
            return Data()
        }
    }
}
