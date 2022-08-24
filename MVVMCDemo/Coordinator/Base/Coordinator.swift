//
//  BaseCoordinator.swift
//  MVVMCDemo
//
//  Created by Book on 2022/8/9.
//

import Foundation
import UIKit

public protocol Coordinatable: AnyObject {
    var parent: Coordinatable? { get }
    var child: Coordinatable? { get }

    var startViewController: UIViewController? { get }
    var lastViewController: UIViewController? { get }

    func start()
    func end()

    func setParent(_ parent: Coordinatable?)

    func setChild(_ child: Coordinatable?)
    func removeFromParent()

    func setLastViewController(_ viewController: UIViewController)
}

public extension Coordinatable {
    func removeFromParent() {
        parent?.setChild(nil)
    }
}

public class BaseCoordinator: Coordinatable {

    public weak var parent: Coordinatable?
    public var child: Coordinatable?

    public var router: NavigationRouter
    public var navigator: UINavigationController {
        router.navigationController
    }

    public weak var startViewController: UIViewController?
    public weak var lastViewController: UIViewController?

    private var initType: InitType

    init(with initType: InitType) {
        self.initType = initType
        switch initType {
        case .root(let rootViewController):
            let navigationController = UINavigationController(rootViewController: rootViewController)
            self.router = .init(navigationController: navigationController)
            startViewController = rootViewController
            lastViewController = rootViewController
        case .push(let router):
            self.router = router
        case .present(let router):
            self.router = router
        }
    }

    public func start() {
        guard let startViewController = startViewController else {
            return
        }

        switch initType {
        case .root:
            break
        case .push:
            push(startViewController, animated: true)
        case .present:
            let navi = UINavigationController(rootViewController: startViewController)
            lastViewController = startViewController
            navigator.present(navi, animated: true) {
                self.router = .init(navigationController: navi)
            }
        }

    }

    public func end() {
        switch initType {
        case .root:
            navigator.popToRootViewController(animated: true)
        case .push:
            if let parent = parent,
               let lastViewController = parent.lastViewController {
                navigator.presentedViewController?.dismiss(animated: true)
                router.popToViewController(viewController: lastViewController,
                                           animated: true)
            }
        case .present:
            navigator.presentedViewController?.dismiss(animated: true)
            navigator.dismiss(animated: true)
            removeFromParent()
        }
    }

    public func setParent(_ parent: Coordinatable?) {
        self.parent = parent
    }

    public func setChild(_ child: Coordinatable?) {
        child?.setParent(self)
        self.child = child
//        self.child?.setParent(self)
    }

    public func setLastViewController(_ viewController: UIViewController) {
        lastViewController = viewController
    }
}

// MARK: - Navigation
extension BaseCoordinator {
    public func push(_ viewController: UIViewController, animated: Bool) {
        lastViewController = viewController
        viewController.baseCoordinator = self
        router.push(viewController, animated: animated)
    }

    public func pop(animated: Bool) {
        router.pop(animated: animated)
    }

    public func present(viewController: UIViewController,
                        animated: Bool = true,
                        completion: (() -> Void)? = nil) {
        viewController.baseCoordinator = self
        navigator.present(viewController, animated: animated, completion: completion)
    }
}

// MARK: - Enum
extension BaseCoordinator {
    enum InitType {
        case root(rootViewController: UIViewController)
        case push(router: NavigationRouter)
        case present(router: NavigationRouter)
    }
}
