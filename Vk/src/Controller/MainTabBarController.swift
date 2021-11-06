//
//  MainTabBarController.swift
//  Eigth homework task
//
//  Created by Nihad on 11/16/20.
//

import UIKit
import Alamofire

final class MainTabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()

        setup()
    }

    override var shouldAutorotate: Bool {
        false
    }
    
    private func setup() {
        let friendsNav = makeNavigationController(icon: .friendsTabBarIcon, rootViewController: FriendsViewController())
        let groupsNav = makeNavigationController(icon: .groupsTabBarIcon, rootViewController: GroupsViewController())
        let newsNav = makeNavigationController(icon: .feedTabBarIcon, rootViewController: NewsViewController())
        
        viewControllers = [friendsNav, groupsNav, newsNav]
    }
    
    private func makeNavigationController(icon: UIImage, rootViewController: UIViewController) -> UINavigationController {
        let navCtrl = UINavigationController(rootViewController: rootViewController)
        navCtrl.tabBarItem.image = icon
        navCtrl.navigationBar.barTintColor = .white
        return navCtrl
    }
}

