//
//  LoginViewController.swift
//  Eigth homework task
//
//  Created by Nihad on 11/16/20.
//

import UIKit

final class LoginViewController: UIViewController {
    
    private let logoImageView: UIImageView = {
        let logoImageView = UIImageView()
        logoImageView.contentMode = .scaleAspectFit
        logoImageView.clipsToBounds = true
        logoImageView.image = .vkLogo
        return logoImageView
    }()

    private lazy var emailContainerView = Utilities.makeInputContainerView(withImage: .emailIcon, textField: emailTextField)
    private lazy var passwordContainerView = Utilities.makeInputContainerView(withImage: .passwordIcon, textField: passwordTextField)
    
    private let emailTextField = Utilities.makeTextField(withPlaceholder: "Email")
    
    private let passwordTextField: UITextField = {
        let passwordTextField = Utilities.makeTextField(withPlaceholder: "Password")
        passwordTextField.isSecureTextEntry = true
        return passwordTextField
    }()
    
    private lazy var loginButton: UIButton = {
        let loginButton = UIButton(type: .system)
        loginButton.setTitle("Log In", for: .normal)
        loginButton.setTitleColor(.themeBlue, for: .normal)
        loginButton.backgroundColor = .white
        loginButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
        loginButton.layer.cornerRadius = 5
        loginButton.titleLabel?.font = .boldSystemFont(ofSize: 20)
        loginButton.addTarget(self, action: #selector(onLogin), for: .touchUpInside)
        return loginButton
    }()

    override var preferredStatusBarStyle: UIStatusBarStyle {
        .lightContent
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        layout()
    }

    private func layout() {
        view.addSubview(logoImageView)
        logoImageView.centerX(inView: view, topAnchor: view.safeAreaLayoutGuide.topAnchor)
        logoImageView.setDimensions(width: 150, height: 150)
        
        let stack = UIStackView(arrangedSubviews: [emailContainerView, passwordContainerView, loginButton])
        stack.axis = .vertical
        stack.spacing = 20
        stack.distribution = .fillEqually
        
        view.addSubview(stack)
        stack.anchor(
            top: logoImageView.bottomAnchor,
            left: view.leftAnchor,
            right: view.rightAnchor,
            paddingLeft: 32,
            paddingRight: 32
        )
    }

    private func style() {
        view.backgroundColor = .themeBlue
    }

    @objc private func onLogin() {
        let mainTabBarController = MainTabBarController()
        mainTabBarController.modalPresentationStyle = .fullScreen
        present(mainTabBarController, animated: true)
    }
}
