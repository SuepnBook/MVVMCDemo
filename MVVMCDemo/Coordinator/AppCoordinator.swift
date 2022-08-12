//
//  AppCoordinator.swift
//  MVVMCDemo
//
//  Created by Book on 2022/8/9.
//

import UIKit

enum DeepLinkOption {
    case aLink
    case hardLogout
}

enum NotificationOption {
    case aNoti
    case bNoti
}

final class AppCoordinator {
    
    private weak var window: UIWindow?
    
    private var loginCoordinator:LoginCoordinator?
    private var registerCoordinator:RegisterCoordinator?
    private var mainCoordinator:MainTabBarController?
    
    init(window: UIWindow?) {
        self.window = window
    }
    
    func start() {
        switch AuthRepository.shared.getAuthStatus() {
        case .login:
            showMainFlow()
        case .logout:
            showRegisterFlow()
        case .sessionExpire:
            showLoginFlow()
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
        clearAllCoordinator()
        self.loginCoordinator = LoginCoordinator()
        loginCoordinator?.delegate = self
        setRootModule(loginCoordinator?.navigator)
    }
    
    private func showRegisterFlow() {
        clearAllCoordinator()
        self.registerCoordinator = RegisterCoordinator()
        registerCoordinator?.delegate = self
        setRootModule(registerCoordinator?.navigator)
    }
    
    private func showMainFlow() {
        clearAllCoordinator()
        self.mainCoordinator = MainTabBarController()
        mainCoordinator?.coordinate = self
        setRootModule(mainCoordinator)
    }
    
    private func setRootModule(_ controller: UIViewController?) {
        guard let window = window else { return }
        window.rootViewController = controller
        UIView.transition(with: window, duration: 0.5, options: .transitionCrossDissolve, animations: nil, completion: nil)
    }
    
    private func clearAllCoordinator() {
        self.loginCoordinator = nil
        self.registerCoordinator = nil
        self.mainCoordinator = nil
    }
}

//MARK: - LoginCoordinatorDelegate
extension AppCoordinator: LoginCoordinatorDelegate {
    func loginCoordinatorGotoRegister(_ coordinator: LoginCoordinator) {
        showRegisterFlow()
    }
    
    func loginCoordinatorGotoMain(_ coordinator: LoginCoordinator) {
        showMainFlow()
    }
}

//MARK: - RegisterCoordinatorDelegate
extension AppCoordinator: RegisterCoordinatorDelegate {
    func RegisterCoordinatorGotoMain(_ coordinator: RegisterCoordinator) {
        showMainFlow()
    }
    
    func RegisterCoordinatorGotoLogin(_ coordinator: RegisterCoordinator) {
        showLoginFlow()
    }
    
}

//MARK: - MainTabBarControllerDelegate
extension AppCoordinator: MainTabBarControllerDelegate {
    func mainTabBarControllerLogout(_ mainTabBar: MainTabBarController) {
        showLoginFlow()
    }
}
