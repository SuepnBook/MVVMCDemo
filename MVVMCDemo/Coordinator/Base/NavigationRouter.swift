//
//  NavigationRouter.swift
//  MVVMCDemo
//
//  Created by Book on 2022/8/9.
//

import UIKit

public class NavigationRouter: NSObject {
    
    public let navigationController: UINavigationController

    public init(navigationController: UINavigationController = UINavigationController()) {
        self.navigationController = navigationController
        super.init()
        self.navigationController.delegate = self
    }

    public func push(_ viewController: UIViewController, animated: Bool) {
        DispatchQueue.main.async { [weak self] in
            self?.navigationController.pushViewController(viewController, animated: animated)
        }
    }

    public func pop(animated: Bool) {
        navigationController.popViewController(animated: animated)
    }
}

extension NavigationRouter: UINavigationControllerDelegate {
    public func navigationController(_ navigationController: UINavigationController, didShow viewController: UIViewController, animated: Bool) {
        guard let dismissedVieController = navigationController.transitionCoordinator?.viewController(forKey: .from),
              !navigationController.viewControllers.contains(dismissedVieController),
              let dismissedCoordinator = dismissedVieController.coordinate else {
            return
        }

        viewController.coordinate?.removeChild(child: dismissedCoordinator)
    }
}

extension UIViewController {
    private enum CoordinatorAssociatedKeys {
        static var ownerKey: UInt = 0
    }

    weak var coordinate: Coordinator? {
        get {
            objc_getAssociatedObject(self, &CoordinatorAssociatedKeys.ownerKey) as? Coordinator
        }

        set {
            objc_setAssociatedObject(self, &CoordinatorAssociatedKeys.ownerKey, newValue, .OBJC_ASSOCIATION_ASSIGN)
        }
    }
}
