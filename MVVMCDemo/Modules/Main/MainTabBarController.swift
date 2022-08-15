//
//  ViewController.swift
//  MVVMCDemo
//
//  Created by Book on 2022/8/9.
//

import UIKit

protocol MainTabBarControllerDelegate: AnyObject {
    func mainTabBarControllerLogout(_ mainTabBar: MainTabBarController)
}

class MainTabBarController: UITabBarController {

    weak var coordinator: MainTabBarControllerDelegate?

    private let dashboardCoordinator: DashboardCoordinator = .init()
    private let pasteBoardCoordinator: PasteBoardCoordinator = .init()
    private lazy var profileCoordinator: ProfileCoordinator = {
        let coordinator = ProfileCoordinator()
        coordinator.coordinator = self
        return coordinator
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        setupViewControllers()
        setupAppearance()
        setTabBarItems()
    }

    deinit {
        print("MainTabBarController deinit")
    }
}

// MARK: - Private Function
extension MainTabBarController {
    private func setupViewControllers() {
        viewControllers = [
            dashboardCoordinator.navigator,
            pasteBoardCoordinator.navigator,
            profileCoordinator.navigator
        ]
    }

    private func setupAppearance() {
        if #available(iOS 15.0, *) {
            let appearance = UITabBarAppearance()
            appearance.configureWithOpaqueBackground()
            appearance.backgroundColor = .white
            appearance.selectionIndicatorTintColor = .black
            tabBar.standardAppearance = appearance
            tabBar.scrollEdgeAppearance = tabBar.standardAppearance
        }

        tabBar.isTranslucent = false
    }

    private func setTabBarItems() {
        let items: [UITabBarItem] = [
            .init(title: "Dashboard",
                  image: UIImage(systemName: "list.dash.header.rectangle"),
                  selectedImage: UIImage(systemName: "list.dash.header.rectangle")),
            .init(title: "Trade",
                  image: UIImage(systemName: "tray.full"),
                  selectedImage: UIImage(systemName: "tray.full")),
            .init(title: "Profile",
                  image: UIImage(systemName: "person.crop.circle.fill"),
                  selectedImage: UIImage(systemName: "person.crop.circle.fill"))
        ]

        for (index, item) in items.enumerated() {
            tabBar.items?[index].title = item.title
            tabBar.items?[index].image = item.image
            tabBar.items?[index].selectedImage = item.selectedImage
        }

        tabBar.barTintColor = .black
        tabBar.unselectedItemTintColor = .systemGray2
        tabBar.tintColor = .black
    }
}

// MARK: - ProfileCoordinatorDelegate
extension MainTabBarController: ProfileCoordinatorDelegate {
    func ProfileCoordinatorTapLogout(_ coordinator: ProfileCoordinator) {
        self.coordinator?.mainTabBarControllerLogout(self)
    }
}
