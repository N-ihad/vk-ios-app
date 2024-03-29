//
//  Helper.swift
//
//  Created by Nihad on 11/16/20.
//

import UIKit

struct Helper {
    static func makeNavigationController(icon: UIImage,
                                         rootViewController: UIViewController) -> UINavigationController {
        let navigationController = UINavigationController(rootViewController: rootViewController)
        navigationController.tabBarItem.image = icon
        navigationController.navigationBar.barTintColor = .white
        return navigationController
    }

    static func makeInputContainerView(withImage image: UIImage, textField: UITextField) -> UIView {
        let view = UIView()
        view.heightAnchor.constraint(equalToConstant: 50).isActive = true

        let leftIconImageView = UIImageView()
        leftIconImageView.image = image
        leftIconImageView.tintColor = .white
        
        view.addSubview(leftIconImageView)
        leftIconImageView.anchor(
            left: view.leftAnchor,
            bottom: view.bottomAnchor,
            paddingLeft: 8,
            paddingBottom: 8,
            width: 28,
            height: 24
        )
        
        view.addSubview(textField)
        textField.anchor(
            left: leftIconImageView.rightAnchor,
            bottom: view.bottomAnchor,
            right: view.rightAnchor,
            paddingLeft: 8,
            paddingBottom: 8
        )
        
        let dividerView = UIView()
        dividerView.backgroundColor = .white

        view.addSubview(dividerView)
        dividerView.anchor(
            left: view.leftAnchor,
            bottom: view.bottomAnchor,
            right: view.rightAnchor,
            paddingLeft: 8,
            height: 0.3
        )
        
        return view
    }

    static func makeTextField(withPlaceholder placeholder: String) -> UITextField {
        let tf = UITextField()
        tf.placeholder = placeholder
        tf.textColor = .white
        tf.font = .systemFont(ofSize: 16)
        tf.attributedPlaceholder = NSAttributedString(
            string: placeholder,
            attributes: [.foregroundColor: UIColor.white]
        )
        return tf
    }

    static func makeButton(with color: UIColor,
                           imgForNormalState: UIImage,
                           imgForSelectedState: UIImage,
                           width: Int,
                           height: Int) -> UIButton {
        let btn = UIButton()
        let img = imgForNormalState.imageWith(newSize: CGSize(width: 100, height: 100), color: .themeBlue)
        let imgFilled = imgForSelectedState.imageWith(newSize: CGSize(width: 100, height: 100), color: .themeBlue)
        btn.setImage(img, for: .normal)
        btn.setImage(imgFilled, for: .selected)
        btn.setDimensions(width: CGFloat(width), height: CGFloat(height))

        return btn
    }

    static func makeDividerView(color: UIColor) -> UIView {
        let view = UIView()
        view.backgroundColor = .gray
        view.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width).isActive = true
        view.heightAnchor.constraint(equalToConstant: 0.3).isActive = true
        return view
    }

    static func animate(view: UIView) {
        UIView.animate(
            withDuration: 0.3,
            delay: 0,
            usingSpringWithDamping: 0.5,
            initialSpringVelocity: 0.5,
            options: .curveEaseIn,
            animations: {
                view.transform = CGAffineTransform(scaleX: 0.8, y: 0.8)
            }
        ) { _ in

            UIView.animate(
                withDuration: 0.15,
                delay: 0,
                usingSpringWithDamping: 0.4,
                initialSpringVelocity: 2,
                options: .curveEaseIn,
                animations: {
                    view.transform = CGAffineTransform(scaleX: 1, y: 1)
                }
            )
        }
    }

    static func makeLoadingView() -> UIView {
        let loadingOverlay = UIView()
        loadingOverlay.contentMode = .scaleAspectFit
        loadingOverlay.backgroundColor = .black
        loadingOverlay.alpha = 0.5
        loadingOverlay.isUserInteractionEnabled = true
        loadingOverlay.layer.zPosition = 1

        let loadingLayer = CAReplicatorLayer()
        loadingLayer.frame = CGRect(x: -10, y: 0, width: 100, height: 10)

        let circle = CALayer()
        circle.frame = CGRect(x: -10, y: 0, width: 10, height: 10)
        circle.backgroundColor = UIColor.gray.cgColor
        circle.cornerRadius = 10 / 2

        loadingLayer.addSublayer(circle)
        loadingLayer.instanceCount = 3
        loadingLayer.instanceTransform = CATransform3DMakeTranslation(20, 0, 0)

        let anim = CABasicAnimation(keyPath: #keyPath(CALayer.opacity))
        anim.fromValue = 1.0
        anim.toValue = 0.2
        anim.duration = 1
        anim.repeatCount = .infinity
        circle.add(anim, forKey: nil)

        loadingLayer.instanceDelay = anim.duration / Double(loadingLayer.instanceCount)

        let view = UIView()
        view.layer.addSublayer(loadingLayer)

        loadingOverlay.addSubview(view)
        view.center(inView: loadingOverlay)

        return loadingOverlay
    }
}
