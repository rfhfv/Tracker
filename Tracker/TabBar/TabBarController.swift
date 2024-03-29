//
//  TabBarController.swift
//  Tracker
//
//  Created by admin on 12.12.2023.
//

import UIKit

// MARK: - UITabBarController

final class TabBarController: UITabBarController {
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        generateTabBar()
        tabBarAppearance()
        tabBarSetup()
    }
    
    // MARK: - Private methods
    
    private func generateTabBar() {
        viewControllers = [
            generateVC(
                viewController: TrackersViewController(),
                title: "Трекеры",
                image: UIImage(named: "recordIcon")
            ),
            generateVC(
                viewController: StatisticsViewController(),
                title: "Статистика",
                image: UIImage(named: "statisticsIcon")
            )
        ]
    }
    
    private func tabBarSetup() {
        tabBar.layer.borderWidth = 0.3
        tabBar.layer.borderColor = UIColor(red: 0.0/255.0, green: 0.0/255.0, blue: 0.0/255.0, alpha: 0.2).cgColor
        tabBar.clipsToBounds = true
    }
    
    private func generateVC(viewController: UIViewController, title: String, image: UIImage?) ->
    UIViewController {
        viewController.tabBarItem.title = title
        viewController.tabBarItem.image = image
        return viewController
    }
    
    private func tabBarAppearance() {
        let tabBarAppearance: UITabBarAppearance = UITabBarAppearance()
        tabBarAppearance.configureWithOpaqueBackground()
        tabBar.standardAppearance = tabBarAppearance
    }
}


