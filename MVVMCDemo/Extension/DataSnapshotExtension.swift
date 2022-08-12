//
//  DataSnapshotExtension.swift
//  MVVMCDemo
//
//  Created by Book on 2022/8/9.
//

import Foundation
import FirebaseDatabase

extension DataSnapshot {
    var valueToJSON: Data {
        guard let dic = value as? [String: Any] else {
            return Data()
        }
        return dic.JSON
    }

    var listToJSON: Data {
        guard let object = children.allObjects as? [DataSnapshot] else { return Data() }

        let dic: [NSDictionary] = object.compactMap { $0.value as? NSDictionary }

        do {
            return try JSONSerialization.data(withJSONObject: dic, options: .prettyPrinted)
        } catch {
            return Data()
        }
    }
}
