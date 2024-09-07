//
//  MainTabBarController.swift
//  PodcastApp
//
//  Created by Saleh Asadov 
//

import UIKit

class MainTabBarController: UITabBarController {
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setup()
    }
}

// MARK: - Helpers
extension MainTabBarController {
    private func setup() {
        viewControllers = [
            createViewController(rootViewController: FavoriteViewController(),
                                 title: "Favorites",
                                 imagename: "play.circle.fill"),
            
            createViewController(rootViewController: SearchViewController(),
                                 title: "Search",
                                 imagename: "magnifyingglass.circle.fill"),
            
            createViewController(rootViewController: DownloadsViewController(),
                                 title: "Downloads",
                                 imagename: "arrow.down.circle.fill")
        ]
        tabBar.tintColor = .systemPurple
    }
    
    private func createViewController(rootViewController: UIViewController,
                                      title: String,
                                      imagename: String) -> UINavigationController {
        rootViewController.title = title
        let appearance = UINavigationBarAppearance()
        appearance.configureWithOpaqueBackground()
        
        let controller = UINavigationController(rootViewController: rootViewController)
        controller.navigationBar.prefersLargeTitles = true
        controller.navigationBar.compactAppearance = appearance
        controller.navigationBar.standardAppearance = appearance
        controller.navigationBar.scrollEdgeAppearance = appearance
        controller.navigationBar.compactScrollEdgeAppearance = appearance
        controller.tabBarItem.title = title
        controller.tabBarItem.image = UIImage(systemName: imagename)
        return controller
    }
}
