//
//  BaseCoordinator.swift
//  MVVMCDemo
//
//  Created by Book on 2022/8/9.
//

import Foundation
import UIKit

public protocol Coordinatable: AnyObject {
    var parent: Coordinatable? { get set }
    var children: [Coordinatable] { get set }
    
    var router: NavigationRouter { get set }
    
    var startViewController: UIViewController? { get set }
    var lastViewController: UIViewController? { get set }
    
    func start()
    func end()
    
    func addChild(_ coordinator: Coordinatable)
    func removeChild(child: Coordinatable)
    func removeFromParent()
}

public extension Coordinatable {

    func addChild(_ coordinator: Coordinatable) {
       coordinator.parent = self
       children.append(coordinator)
    }

    func removeChild(child: Coordinatable) {
        child.parent = nil
        child.children.forEach { $0.children.removeAll() }
        for (index, potentialCoordinator) in children.enumerated() {
            if potentialCoordinator === child {
                children.remove(at: index)
            }
        }
    }
    
    func removeFromParent() {
        parent?.removeChild(child: self)
    }
}

public class BaseCoordinator: Coordinatable {
    
    public weak var parent: Coordinatable?
    public var children: [Coordinatable] = []
    
    public var router: NavigationRouter
    
    public weak var startViewController: UIViewController?
    public weak var lastViewController: UIViewController?

    public var navigater: UINavigationController {
        router.navigationController
    }
    
    private var initType:InitType
    
    enum InitType {
        case root(rootViewController: UIViewController)
        case push(router: NavigationRouter)
        case present(router: NavigationRouter)
    }
    
    init(with initType:InitType) {
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
            navigater.present(navi, animated: true) {
                self.router = .init(navigationController: navi)
            }
        }
    }
    
    public func end() {
        switch initType {
        case .root:
            navigater.popToRootViewController(animated: true)
        case .push:
            if let parent = parent,
               let lastViewController = parent.lastViewController {
                navigater.presentingViewController?.dismiss(animated: true)
                router.popToViewController(viewController: lastViewController,
                                           animated: true)
//                removeFromParent()
            }
        case .present:
            navigater.presentingViewController?.dismiss(animated: true)
            navigater.dismiss(animated: true)
            removeFromParent()
        }
    }

    public func push(_ viewController: UIViewController, animated: Bool) {
        lastViewController = viewController
        viewController.coordinate = self
        router.push(viewController, animated: animated)
    }
    
    public func pop(animated: Bool) {
        router.pop(animated: animated)
    }

    public func present(viewController: UIViewController,
                        animated: Bool = true,
                        completion: (() -> Void)? = nil) {
        viewController.coordinate = self
        navigater.present(viewController, animated: animated, completion: completion)
    }
}

