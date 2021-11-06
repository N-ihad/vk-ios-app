//
//  TabBarController.swift
//
//  Created by Nihad on 11/16/20.
//

import UIKit
import Alamofire

final class TabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()

        setup()
    }

    override var shouldAutorotate: Bool {
        false
    }
    
    private func setup() {
        let friendsNavigationController = Helper.makeNavigationController(icon: .friendsTabBarIcon, rootViewController: FriendsViewController())
        let groupsNavigationController = Helper.makeNavigationController(icon: .groupsTabBarIcon, rootViewController: GroupsViewController())
        let feedNavigationController = Helper.makeNavigationController(icon: .feedTabBarIcon, rootViewController: FeedViewController())
        
        viewControllers = [friendsNavigationController, groupsNavigationController, feedNavigationController]
    }
}

