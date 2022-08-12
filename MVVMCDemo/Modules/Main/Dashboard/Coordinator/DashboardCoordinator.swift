//
//  DashboardCoordinator.swift
//  MVVMCDemo
//
//  Created by Book on 2022/8/9.
//

import UIKit

class DashboardCoordinator: BaseCoordinator {

    init() {
        let rootViewController = DashboardViewController()
        super.init(with: .root(rootViewController: rootViewController))
    }

    deinit {
        print("DashboardCoordinator deinit")
    }

}
