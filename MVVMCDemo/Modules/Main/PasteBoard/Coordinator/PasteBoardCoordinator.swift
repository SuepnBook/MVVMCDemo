//
//  TradeCoordinator.swift
//  MVVMCDemo
//
//  Created by Book on 2022/8/9.
//

import UIKit
import SwiftUI

class PasteBoardCoordinator: BaseCoordinator {

    init() {
        let rootViewController = UIHostingController(rootView: PasteBoardListView())
        super.init(with: .root(rootViewController: rootViewController))
    }

    deinit {
        print("PasteBoardCoordinator deinit")
    }
}
