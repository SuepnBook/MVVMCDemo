//
//  RegisterCoordinator.swift
//  MVVMCDemo
//
//  Created by Book on 2022/8/9.
//

import UIKit

protocol RegisterCoordinatorDelegate: AnyObject {
    func RegisterCoordinatorGotoMain(_ coordinator:RegisterCoordinator)
    func RegisterCoordinatorGotoLogin(_ coordinator:RegisterCoordinator)
}

class RegisterCoordinator: BaseCoordinator {
    
    weak var delegate:RegisterCoordinatorDelegate?
    
    override func start() {
        let rootVC = RegisterViewController()
        rootVC.delegate = self
        push(rootVC, animated: true)
    }
    
    deinit {
        print("RegisterCoordinator deinit")
    }

}

//MARK: - RegisterViewControllerCoordinator
extension RegisterCoordinator:RegisterViewControllerCoordinator {
    func registerViewControllerReigsterSuccess(_ vc: RegisterViewController) {
        delegate?.RegisterCoordinatorGotoMain(self)
    }
    
    func registerViewControllerTapLogin(_ vc: RegisterViewController) {
        delegate?.RegisterCoordinatorGotoLogin(self)
    }
}
