//
//  ProfileCoordinator.swift
//  MVVMCDemo
//
//  Created by Book on 2022/8/9.
//

import Foundation
import UIKit

protocol ProfileCoordinatorDelegate:AnyObject {
    func ProfileCoordinatorTapLogout(_ coordinator:ProfileCoordinator)
}

class ProfileCoordinator: BaseCoordinator {
    
    weak var delegate:ProfileCoordinatorDelegate?
    
    override init(router: NavigationRouter = .init()) {
        let rootVC = ProfileViewController()
        let navigationController = UINavigationController(rootViewController: rootVC)
        super.init(router: .init(navigationController: navigationController))
        rootVC.delegate = self
    }
    
    deinit {
        print("ProfileCoordinator deinit")
    }

}

//MARK: - ProfileViewControllerCoordinator
extension ProfileCoordinator: ProfileViewControllerCoordinator {
    func profileViewControllerTapLogout(_ vc: ProfileViewController) {
        delegate?.ProfileCoordinatorTapLogout(self)
    }
    
    func profileViewControllerStartAFlow(_ vc: ProfileViewController) {
        let child = ProfileACoordinator(router: router)
        addChild(child)
        child.start()
    }
}
