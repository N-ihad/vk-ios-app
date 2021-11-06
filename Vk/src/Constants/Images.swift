//
//  Images.swift
//  Vk
//
//  Created by Nihad on 11/6/21.
//

import Foundation
import UIKit

extension UIImage {
    static var vkLogo: UIImage {
        UIImage(named: "vk-logo-light")!
    }

    static var emailIcon: UIImage {
        UIImage(named: "email")!
    }

    static var passwordIcon: UIImage {
        UIImage(named: "password")!
    }

    static var friendsTabBarIcon: UIImage {
        UIImage(named: "person.3")!
    }

    static var groupsTabBarIcon: UIImage {
        UIImage(named: "list.bullet.indent")!
    }

    static var feedTabBarIcon: UIImage {
        UIImage(named: "newspaper")!
    }

    static var star: UIImage {
        UIImage(systemName: "star")!
    }

    static var starFilled: UIImage {
        UIImage(systemName: "star.fill")!
    }

    static var heart: UIImage {
        UIImage(systemName: "heart")!
    }

    static var heartFilled: UIImage {
        UIImage(systemName: "heart.fill")!
    }

    static var share: UIImage {
        UIImage(systemName: "arrowshape.turn.up.left")!
    }

    static var shareFilled: UIImage {
        UIImage(systemName: "arrowshape.turn.up.left.fill")!
    }
}
