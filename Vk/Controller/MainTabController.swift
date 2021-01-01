//
//  MainTabController.swift
//  Eigth homework task
//
//  Created by Nihad on 11/16/20.
//

import UIKit
import Alamofire

class MainTabController: UITabBarController {
    
    // MARK: - Properties
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()

        configureViewControllers()
        testRequests()
    }

    // MARK: - Helpers
    
    override var shouldAutorotate: Bool {
        return false
    }
    
    func configureViewControllers() {
        let friendsVC  = FriendsVC()
        let friendsNav = templateNavigationController(image: UIImage(named: "person.3")!, rootViewController: friendsVC)
        
        let groupsVC = GroupsVC()
        let groupsNav = templateNavigationController(image: UIImage(named: "list.bullet.indent")!, rootViewController: groupsVC)
        
        let newsVC = NewsVC()
        let newsNav = templateNavigationController(image: UIImage(named: "newspaper")!, rootViewController: newsVC)
        
        viewControllers = [friendsNav, groupsNav, newsNav]
    }
    
    func templateNavigationController(image: UIImage, rootViewController: UIViewController) -> UINavigationController {
        let navCtrl = UINavigationController(rootViewController: rootViewController)
        navCtrl.tabBarItem.image = image
        navCtrl.navigationBar.barTintColor = .white
        return navCtrl
    }
    
    // MARK: - Requests
    
    func testRequests() {
        
    }
    
}

