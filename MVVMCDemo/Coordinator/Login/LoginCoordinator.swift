//
//  LoginCoordinator.swift
//  MVVMCDemo
//
//  Created by Book on 2022/8/9.
//

import Foundation

class LoginCoordinator: BaseCoordinator {
    
    override func start() {
        let rootVC = LoginViewController()
        push(rootVC, animated: true)
    }
}
