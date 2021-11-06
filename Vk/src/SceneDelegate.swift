//
//  SceneDelegate.swift
//  Eigth homework task
//
//  Created by Nihad on 11/16/20.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    func scene(_ scene: UIScene,
               willConnectTo session: UISceneSession,
               options connectionOptions: UIScene.ConnectionOptions) {
        guard let scene = scene as? UIWindowScene else { return }

        window = UIWindow(windowScene: scene)
        window?.rootViewController = WebLoginViewController()
//        window?.rootViewController = LoginViewController()
//        window?.rootViewController = MainTabBarController()
        window?.makeKeyAndVisible()
    }
}
