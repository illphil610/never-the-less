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
        
        let profileViewController = ProfileViewController()
        profileViewController.tabBarItem = UITabBarItem(tabBarSystemItem: .featured, tag: 0)
        
        let upcomingShowsViewController = UpcomingShowsViewController()
        upcomingShowsViewController.tabBarItem = UITabBarItem(tabBarSystemItem: .recents, tag: 1)
        
        let testViewController = ViewController()
        testViewController.tabBarItem = UITabBarItem(tabBarSystemItem: .more, tag: 2)
        
        self.viewControllers = [profileViewController, testViewController]
    }
    
    func tabBarController(_ tabBarController: UITabBarController, shouldSelect viewController: UIViewController) -> Bool {
        print("Should select viewController: \(viewController.title ?? "") ?")
        return true
    }
}
