//
//  TradeCoordinator.swift
//  MVVMCDemo
//
//  Created by Book on 2022/8/9.
//

import UIKit

class TradeCoordinator: BaseCoordinator {
    
    init() {
        let rootVC = TradeViewController()
        super.init(with: .root(rootViewController: rootVC))
//        rootVC.delegate = self
    }
    
    deinit {
        print("TradeCoordinator deinit")
    }
}
