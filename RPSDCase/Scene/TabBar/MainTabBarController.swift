//
//  MainTabBarController.swift
//  RPSDCase
//
//  Created by Ensar Batuhan Ünverdi on 31.05.2023.
//

import UIKit

class MainTabBarController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTabBarAppearance()
        setupViewControllers()
        setSelectedIndex()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setSelectedTabBarItemColor()
    }
    
    private func setupTabBarAppearance() {
        tabBar.tintColor = .red
        tabBar.backgroundColor = .systemBackground
    }
    
    private func setupViewControllers() {
        let vc1 = UINavigationController(rootViewController: RecordedListController())
        let vc2 = UINavigationController(rootViewController: CameraController())
        let vc3 = UINavigationController(rootViewController: PlayerStatusListController())
        setViewControllers([vc1, vc2, vc3], animated: true)
        
        guard let items = tabBar.items else { return }
        items[0].image = UIImage(systemName: "film.fill")
        items[1].image = UIImage(systemName: "camera.circle.fill")
        items[2].image = UIImage(systemName: "person.2.fill")
        items[0].title = MainTabBarControllersTitle.RecordedListController.rawValue
        items[1].title = MainTabBarControllersTitle.CameraController.rawValue
        items[2].title = MainTabBarControllersTitle.PlayerStatusController.rawValue
    }
    
    private func setSelectedIndex() {
        selectedIndex = 1
    }
    
    private func setSelectedTabBarItemColor() {
        if let items = tabBar.items {
            let textColor: UIColor = .red
            
            for (index, item) in items.enumerated() {
                if index == selectedIndex {
                    item.setTitleTextAttributes([NSAttributedString.Key.foregroundColor: textColor], for: .selected)
                } else {
                    item.setTitleTextAttributes([NSAttributedString.Key.foregroundColor: textColor], for: .selected)
                }
            }
        }
    }
}
