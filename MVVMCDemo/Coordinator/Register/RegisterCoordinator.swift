//
//  RegisterCoordinator.swift
//  MVVMCDemo
//
//  Created by Book on 2022/8/9.
//

import UIKit

class RegisterCoordinator: BaseCoordinator {
    
    override func start() {
        let rootVC = RegisterViewController()
        push(rootVC, animated: true)
    }
    
}
