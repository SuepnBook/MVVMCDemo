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
    
    init() {
        let rootVC = ProfileViewController()
        super.init(with: .root(rootViewController: rootVC))
        rootVC.delegate = self
    }
    
    deinit {
        print("ProfileCoordinator deinit")
    }
}

//MARK: - ProfileViewControllerCoordinator
extension ProfileCoordinator: ProfileViewControllerCoordinator {
    func profileViewControllerTapCustomFlow(_ vc: ProfileViewController) {
        let child = CustomCoordinator(with: .push(router: router))
        addChild(child)
        child.start()
    }
    
    func profileViewControllerTapLogout(_ vc: ProfileViewController) {
        delegate?.ProfileCoordinatorTapLogout(self)
    }
}
