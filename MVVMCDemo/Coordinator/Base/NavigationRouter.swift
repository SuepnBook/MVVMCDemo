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
        guard let transitionCoordinator = navigationController.transitionCoordinator,
              let dismissFromViewController = transitionCoordinator.viewController(forKey: .from),
              let dismissToViewController = transitionCoordinator.viewController(forKey: .to),
              !navigationController.viewControllers.contains(dismissFromViewController) else {
            return
        }

//      以下代表此次 didshow 是 pop 行為造成
//      Navigation : [ dismissToViewController <- dismissFromViewController ]

        guard let dismissedCoordinator = dismissFromViewController.baseCoordinator else {
            return
        }

//      TASK 1 : 因應 pop 的發生，需要修正 dismissedCoordinator - lastViewController
        dismissedCoordinator.setLastViewController(dismissToViewController)

//      TASK 2 : 如果 pop 的 VC 已經是當前 Coordinator 最後一個管理的 VC , 則釋放 pop vc coordinator
        if let startViewController = dismissedCoordinator.startViewController,
           startViewController == dismissFromViewController {
            dismissedCoordinator.removeFromParent()
        }
    }
}

extension UIViewController {
    private enum CoordinatorAssociatedKeys {
        static var ownerKey: UInt = 0
    }

    weak var baseCoordinator: Coordinatable? {
        get {
            objc_getAssociatedObject(self, &CoordinatorAssociatedKeys.ownerKey) as? Coordinatable
        }

        set {
            objc_setAssociatedObject(self, &CoordinatorAssociatedKeys.ownerKey, newValue, .OBJC_ASSOCIATION_ASSIGN)
        }
    }
}
