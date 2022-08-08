//
//  BaseCoordinator.swift
//  MVVMCDemo
//
//  Created by Book on 2022/8/9.
//

import Foundation
import UIKit

public class BaseCoordinator: Coordinator {
    public var children: [Coordinator] = []
    public var router: NavigationRouter
    public var navigater: UINavigationController {
        return router.navigationController
    }

    public init(router: NavigationRouter = .init()) {
        self.router = router
    }

    public func start() {}

    public func addChild(_ coordinator: Coordinator) {
        children.append(coordinator)
    }

    public func push(_ viewController: UIViewController, animated: Bool) {
        router.push(viewController, animated: animated)
        viewController.coordinator = self
    }

    public func pop(animated: Bool) {
        router.pop(animated: animated)
    }

    public func present(viewController: UIViewController, animated: Bool, completion: (() -> Void)?) {
        viewController.coordinator = self
        navigater.present(viewController, animated: animated, completion: completion)
    }
}

