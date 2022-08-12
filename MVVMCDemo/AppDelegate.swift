//
//  AppDelegate.swift
//  MVVMCDemo
//
//  Created by Book on 2022/8/9.
//

import UIKit
import FirebaseCore

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    private(set) lazy var appCoordinator: AppCoordinator = {
        let coordinator = AppCoordinator(window: window)
        return coordinator
    }()

    var rootController: UINavigationController {
        return self.window!.rootViewController as! UINavigationController
    }

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {

        window = UIWindow(frame: UIScreen.main.bounds)
        setupSDK()

        appCoordinator.start()
        return true
    }

    private func setupSDK() {

        FirebaseApp.configure()
        RealtimeDatabase.shared.setupObserve()
    }
}
