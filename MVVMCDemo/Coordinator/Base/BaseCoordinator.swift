//
//  BaseCoordinator.swift
//  MVVMCDemo
//
//  Created by Book on 2022/8/9.
//

import Foundation
import UIKit

public protocol Coordinator: AnyObject {
    var parent: Coordinator? { get set }
    var startViewController:UIViewController? { get set }
    var children: [Coordinator] { get set }
    var router: NavigationRouter { get set }

    func start()
    func start(viewController:UIViewController)
    func addChild(_ coordinator: Coordinator)
    func removeChild(child: Coordinator)
}

public extension Coordinator {
    /// Use the coordinator default start function if you don't need extra properties.
    func start() {}

    func removeChild(child: Coordinator) {
        child.children.forEach { $0.children.removeAll() }
        for (index, potentialCoordinator) in children.enumerated() {
            if potentialCoordinator === child {
                children.remove(at: index)
            }
        }
    }
}

public class BaseCoordinator: Coordinator {
    
    public var parent: Coordinator?
    public var startViewController: UIViewController?
    public var children: [Coordinator] = []
    public var router: NavigationRouter
    public var navigater: UINavigationController {
        return router.navigationController
    }

    public init(router: NavigationRouter = .init()) {
        self.router = router
    }
    
    public func start() {
        
    }

    public func start(viewController:UIViewController) {
        startViewController = viewController
    }

    public func addChild(_ coordinator: Coordinator) {
        coordinator.parent = self
        children.append(coordinator)
    }

    public func push(_ viewController: UIViewController, animated: Bool) {
        router.push(viewController, animated: animated)
        viewController.coordinate = self
    }

    public func pop(animated: Bool) {
        router.pop(animated: animated)
    }

    public func present(viewController: UIViewController, animated: Bool, completion: (() -> Void)?) {
        viewController.coordinate = self
        navigater.present(viewController, animated: animated, completion: completion)
    }
}

