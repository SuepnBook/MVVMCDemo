//
//  Coordinator.swift
//  MVVMCDemo
//
//  Created by Book on 2022/8/9.
//

import Foundation

public protocol Coordinator: AnyObject {
    var children: [Coordinator] { get set }
    var router: NavigationRouter { get set }

    func start()
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
