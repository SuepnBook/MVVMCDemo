//
//  LoginCoordinator.swift
//  MVVMCDemo
//
//  Created by Book on 2022/8/9.
//

import Foundation

protocol LoginCoordinatorDelegate: AnyObject {
    func loginCoordinatorGotoRegister(_ coordinator: LoginCoordinator)
    func loginCoordinatorGotoMain(_ coordinator: LoginCoordinator)
}

class LoginCoordinator: BaseCoordinator {

    weak var delegate: LoginCoordinatorDelegate?

    init() {
        let rootViewController = LoginViewController()
        super.init(with: .root(rootViewController: rootViewController))
        rootViewController.delegate = self
    }

    deinit {
        print("LoginCoordinator deinit")
    }
}

// MARK: - LoginViewControllerCoordinator
extension LoginCoordinator: LoginViewControllerCoordinator {
    func loginViewControllerDidSuccessLogin(_ viewController: LoginViewController) {
        if AuthRepository.shared.isNeedBiometricsCheck() {
            let nextViewController = BiometricsCheckViewController()
            nextViewController.delegate = self
            push(nextViewController, animated: true)
        } else {
            delegate?.loginCoordinatorGotoMain(self)
        }
    }

    func loginViewControllerTapRegister(_ viewController: LoginViewController) {
        delegate?.loginCoordinatorGotoRegister(self)
    }
}

// MARK: - LoginViewControllerCoordinator
extension LoginCoordinator: BiometricsCheckViewControllerCoordinator {
    func BiometricsCheckViewControllerDidSuccess(_ viewController: BiometricsCheckViewController) {
        delegate?.loginCoordinatorGotoMain(self)
    }
}
