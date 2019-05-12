//
//  TabBarController.swift
//  never-the-less
//
//  Created by Philip on 4/29/19.
//  Copyright © 2019 Philip. All rights reserved.
//

import Foundation
import UIKit

class TabBarController: UITabBarController, UITabBarControllerDelegate {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        delegate = self
        
        self.setUpViewControllersWithTabBarItems()
    }
    
    func tabBarController(_ tabBarController: UITabBarController, shouldSelect viewController: UIViewController) -> Bool {
        print("Should select viewController: \(viewController.title ?? "") ?")
        return true
    }
}

extension TabBarController {
    func setUpViewControllersWithTabBarItems(with givenViewControllers: [UIViewController]? = nil) {
        
        // Check if we were given view controllers already
        guard let controllers = givenViewControllers else {
            
            // if we weren't given vcs, lets just use what we want 😈
            let todayVC = UpcomingShowsController()
            todayVC.tabBarItem = UITabBarItem(tabBarSystemItem: .featured, tag: 0)
            
            let profileViewController = ProfileViewController()
            profileViewController.tabBarItem = UITabBarItem(tabBarSystemItem: .more, tag: 0)
            
            self.viewControllers = [todayVC, profileViewController]
            
            return
        }
        
        self.viewControllers = controllers
    }
}
