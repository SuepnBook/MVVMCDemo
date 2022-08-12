//
//  ProfileCoordinator.swift
//  MVVMCDemo
//
//  Created by Book on 2022/8/9.
//

import Foundation
import UIKit

protocol ProfileCoordinatorDelegate: AnyObject {
    func ProfileCoordinatorTapLogout(_ coordinator: ProfileCoordinator)
}

class ProfileCoordinator: BaseCoordinator {

    weak var delegate: ProfileCoordinatorDelegate?

    init() {
        let rootViewController = ProfileViewController()
        super.init(with: .root(rootViewController: rootViewController))
        rootViewController.delegate = self
    }

    deinit {
        print("ProfileCoordinator deinit")
    }
}

// MARK: - ProfileViewControllerCoordinator
extension ProfileCoordinator: ProfileViewControllerCoordinator {
    func profileViewControllerTapCustomFlow(_ viewController: ProfileViewController) {
        let child = CustomFlowCoordinator(with: .push(router: router))
        addChild(child)
        child.start()
    }

    func profileViewControllerTapLogout(_ viewController: ProfileViewController) {
        delegate?.ProfileCoordinatorTapLogout(self)
    }
}
