//
//  LoginCoordinator.swift
//  MVVMCDemo
//
//  Created by Book on 2022/8/9.
//

import Foundation

protocol LoginCoordinatorDelegate: AnyObject {
    func loginCoordinatorGotoRegister(_ coordinator:LoginCoordinator)
    func loginCoordinatorGotoMain(_ coordinator:LoginCoordinator)
}

class LoginCoordinator: BaseCoordinator {
    
    weak var delegate:LoginCoordinatorDelegate?
    
    init() {
        let rootVC = LoginViewController()
        super.init(with: .root(rootViewController: rootVC))
        rootVC.delegate = self
    }

    deinit {
        print("LoginCoordinator deinit")
    }
}

//MARK: - LoginViewControllerCoordinator
extension LoginCoordinator: LoginViewControllerCoordinator {
    func loginViewControllerDidSuccessLogin(_ vc: LoginViewController) {
        if AuthRepository.shared.isNeedBiometricsCheck() {
            let vc = BiometricsCheckViewController()
            vc.delegate = self
            push(vc, animated: true)
        } else {
            delegate?.loginCoordinatorGotoMain(self)
        }
    }
    
    func loginViewControllerTapRegister(_ vc: LoginViewController) {
        delegate?.loginCoordinatorGotoRegister(self)
    }
}

//MARK: - LoginViewControllerCoordinator
extension LoginCoordinator: BiometricsCheckViewControllerCoordinator {
    func BiometricsCheckViewControllerDidSuccess(_ vc: BiometricsCheckViewController) {
        delegate?.loginCoordinatorGotoMain(self)
    }
}
