//
//  LoginCoordinator.swift
//  MVVMCDemo
//
//  Created by Book on 2022/8/9.
//

import Foundation

protocol LoginCoordinatorDelegate: AnyObject {
    func loginCoordinatorGotoRegister(_ coordinator:LoginCoordinator)
    func LoginCoordinatorGotoMain(_ coordinator:LoginCoordinator)
}

class LoginCoordinator: BaseCoordinator {
    
    weak var delegate:LoginCoordinatorDelegate?
    
    override func start() {
        let rootVC = LoginViewController()
        rootVC.delegate = self
        push(rootVC, animated: true)
    }
}

//MARK: - LoginViewControllerCoordinator
extension LoginCoordinator: LoginViewControllerCoordinator {
    func loginViewControllerDidSuccessLogin(_ vc: LoginViewController) {
        if AuthRepository.shared.isNeedBiometricsCheck() {
            let vc = BiometricsCheckViewController()
            vc.delegate = self
            push(vc, animated: true)
        }
    }
    
    func loginViewControllerTapRegister(_ vc: LoginViewController) {
        delegate?.loginCoordinatorGotoRegister(self)
    }
}

//MARK: - LoginViewControllerCoordinator
extension LoginCoordinator: BiometricsCheckViewControllerCoordinator {
    func BiometricsCheckViewControllerDidSuccess(_ vc: BiometricsCheckViewController) {
        delegate?.LoginCoordinatorGotoMain(self)
    }
}
