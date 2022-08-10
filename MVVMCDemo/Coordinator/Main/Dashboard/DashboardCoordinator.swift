//
//  DashboardCoordinator.swift
//  MVVMCDemo
//
//  Created by Book on 2022/8/9.
//

import UIKit

class DashboardCoordinator: BaseCoordinator {
    
    init() {
        let rootVC = DashboardViewController()
        super.init(with: .root(rootViewController: rootVC))
//        rootVC.delegate = self
    }
    
    deinit {
        print("DashboardCoordinator deinit")
    }

}
