//
//  AppDelegate.swift
//  MVVMCDemo
//
//  Created by Book on 2022/8/9.
//

import UIKit

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
//        window?.rootViewController = appCoordinator.rootViewController
//        window?.makeKeyAndVisible()
        appCoordinator.start()
        return true
    }

}

