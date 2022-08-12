//
//  RealTimeDatabaseDomainObject.swift
//  Shared
//
//  Created by Book on 2022/7/8.
//

import Foundation
import UIKit

struct RealTimeDatabaseDomainObject {

    struct Root: Codable {
        internal init(pasteBoard: [RealTimeDatabaseDomainObject.Root.PasteData]) {
            self.pasteBoard = pasteBoard
        }

        var pasteBoard: [PasteData]

        struct PasteData: Codable {
            var title: String
            var value: String
        }
    }
}
