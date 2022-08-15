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

    weak var coordinator: LoginCoordinatorDelegate?

    init() {
        let rootViewController = LoginViewController()
        super.init(with: .root(rootViewController: rootViewController))
        rootViewController.coordinator = self
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
            nextViewController.coordinator = self
            push(nextViewController, animated: true)
        } else {
            coordinator?.loginCoordinatorGotoMain(self)
        }
    }

    func loginViewControllerTapRegister(_ viewController: LoginViewController) {
        coordinator?.loginCoordinatorGotoRegister(self)
    }
}

// MARK: - LoginViewControllerCoordinator
extension LoginCoordinator: BiometricsCheckViewControllerCoordinator {
    func BiometricsCheckViewControllerDidSuccess(_ viewController: BiometricsCheckViewController) {
        coordinator?.loginCoordinatorGotoMain(self)
    }
}
