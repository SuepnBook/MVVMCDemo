//
//  ProfileACoordinator.swift
//  MVVMCDemo
//
//  Created by Book on 2022/8/9.
//

import UIKit

class CustomCoordinator: BaseCoordinator {
    
    let id = UUID().uuidString
    
    override func start() {
        let viewController = CustomFlowViewController(id: id)
        startViewController = viewController
        super.start()
        viewController.delegate = self
    }
    
    deinit {
        print("CustomCoordinator \(id) deinit")
    }
}

//MARK: - ProfileViewControllerCoordinator
extension CustomCoordinator: CustomFlowViewControllerCoordinator {
    func customFlowViewControllerPushNewVC(_ vc: CustomFlowViewController) {
        let viewController = CustomFlowViewController(id: id)
        viewController.delegate = self
        push(viewController, animated: true)
    }
    
    func customFlowViewControllerPresentNewVC(_ vc: CustomFlowViewController) {
        let viewController = CustomFlowViewController(id: id)
        viewController.delegate = self
        present(viewController: viewController, animated: true, completion: nil)
    }
    
    func customFlowViewControllerPushNewFlow(_ vc: CustomFlowViewController) {
        let child = CustomCoordinator(with: .push(router: router))
        addChild(child)
        child.start()
    }
    
    func customFlowViewControllerPresentNewFlow(_ vc: CustomFlowViewController) {
        let child = CustomCoordinator(with: .present(router: router))
        addChild(child)
        child.start()
    }
    
    func customFlowViewControllerEndThisFlow(_ vc: CustomFlowViewController) {
        end()
    }
}
