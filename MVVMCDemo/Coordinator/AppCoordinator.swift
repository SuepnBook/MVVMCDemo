//
//  AppCoordinator.swift
//  MVVMCDemo
//
//  Created by Book on 2022/8/9.
//

import UIKit

enum DeepLinkOption {
    case aLink
    case bLink
}

enum NotificationOption {
    case aNoti
    case bNoti
}

final class AppCoordinator {
    
    private weak var window: UIWindow?
    
    private var loginCoordinator:LoginCoordinator?
    private var registerCoordinator:RegisterCoordinator?
    
    init(window: UIWindow?) {
        self.window = window
    }
    
    func start() {
        switch AuthRepository.shared.getAuthStatus() {
        case .login:
            showLoginFlow()
        case .logout:
            showRegisterFlow()
        case .sessionExpire:
            showRegisterFlow()
        }
        self.window?.makeKeyAndVisible()
    }
    
    func start(with deeplink: DeepLinkOption) {
        
    }
    
    func start(with notification: NotificationOption) {
    
    }
}

//MARK: - Private Function
extension AppCoordinator {
    
    private func showLoginFlow() {
        self.loginCoordinator = LoginCoordinator()
        loginCoordinator?.delegate = self
        loginCoordinator?.start()
        setRootModule(loginCoordinator?.navigater)
    }
    
    private func showRegisterFlow() {
        self.registerCoordinator = RegisterCoordinator()
        setRootModule(registerCoordinator?.navigater)
        registerCoordinator?.start()
    }
    
    private func showMainFlow() {
        
//        setRootModule(registerCoordinator?.navigater)
    }
    
    private func setRootModule(_ controller: UIViewController?) {
        guard let window = window else { return }
        window.rootViewController = controller
        UIView.transition(with: window, duration: 0.5, options: .transitionCrossDissolve, animations: nil, completion: nil)
    }
    
    private func clearAllCoordinator() {
        self.loginCoordinator = nil
        self.registerCoordinator = nil
    }
}

//MARK: - LoginCoordinatorDelegate
extension AppCoordinator: LoginCoordinatorDelegate {
    func loginCoordinatorGotoRegister(_ coordinator: LoginCoordinator) {
        showMainFlow()
    }
    
    func LoginCoordinatorGotoMain(_ coordinator: LoginCoordinator) {
        
    }
}
