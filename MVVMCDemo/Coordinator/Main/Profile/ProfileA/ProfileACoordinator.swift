//
//  ProfileACoordinator.swift
//  MVVMCDemo
//
//  Created by Book on 2022/8/9.
//

import UIKit

class ProfileACoordinator: BaseCoordinator {
    
    lazy var startVC = ProfileAViewController()
    
    override func start() {
        start(viewController: startVC)
        push(startVC, animated: true)
        push(ProfileBViewController(), animated: true)
        push(ProfileCViewController(), animated: true)
    }
    
    deinit {
        print("ProfileACoordinator deinit")
    }

}
