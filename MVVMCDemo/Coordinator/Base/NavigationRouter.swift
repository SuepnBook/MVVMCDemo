//
//  NavigationRouter.swift
//  MVVMCDemo
//
//  Created by Book on 2022/8/9.
//

import UIKit

public class NavigationRouter: NSObject {
    
    public var navigationController: UINavigationController

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
    
    public func popToViewController(viewController: UIViewController, animated: Bool) {
        navigationController.popToViewController(viewController, animated: animated)
    }
}

extension NavigationRouter: UINavigationControllerDelegate {
    public func navigationController(_ navigationController: UINavigationController, didShow viewController: UIViewController, animated: Bool) {
        guard let dismissedVieController = navigationController.transitionCoordinator?.viewController(forKey: .from),
              !navigationController.viewControllers.contains(dismissedVieController) else {
            return
        }
        
        if let dismissedCoordinator = dismissedVieController.coordinate,
           let startVC = dismissedCoordinator.startViewController,
           startVC == dismissedVieController {
            dismissedCoordinator.removeFromParent()
        }
    }
}

extension UIViewController {
    private enum CoordinatorAssociatedKeys {
        static var ownerKey: UInt = 0
    }
    
    weak var coordinate: Coordinatable? {
        get {
            objc_getAssociatedObject(self, &CoordinatorAssociatedKeys.ownerKey) as? Coordinatable
        }

        set {
            objc_setAssociatedObject(self, &CoordinatorAssociatedKeys.ownerKey, newValue, .OBJC_ASSOCIATION_ASSIGN)
        }
    }
}
