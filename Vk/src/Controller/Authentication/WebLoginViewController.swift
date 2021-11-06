//
//  WebLoginViewController.swift
//  Vk
//
//  Created by Nihad on 12/20/20.
//

import UIKit
import WebKit

final class WebLoginViewController: UIViewController {

    private let webView: WKWebView = {
        let webView = WKWebView()
        var urlComponents = URLComponents()
        urlComponents.scheme = "https"
        urlComponents.host = "oauth.vk.com"
        urlComponents.path = "/authorize"
        urlComponents.queryItems = [
            URLQueryItem(name: "client_id", value: "7712978"),
            URLQueryItem(name: "display", value: "mobile"),
            URLQueryItem(name: "redirect_uri", value: "https://oauth.vk.com/blank.html"),
            URLQueryItem(name: "scope", value: "262150"),
            URLQueryItem(name: "response_type", value: "token"),
            URLQueryItem(name: "v", value: "5.68")
        ]
                
        let request = URLRequest(url: urlComponents.url!)
        webView.load(request)

        return webView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        UserDefaults.standard.set(false, forKey: "_UIConstraintBasedLayoutLogUnsatisfiable")

        setup()
        layout()
    }

    private func setup() {
        webView.uiDelegate = self
        webView.navigationDelegate = self
    }

    private func layout() {
        view.addSubview(webView)
        webView.pinTo(view)
    }
}

// MARK: - WKUIDelegate, WKNavigationDelegate
extension WebLoginViewController: WKUIDelegate, WKNavigationDelegate {
    func webView(_ webView: WKWebView,
                 decidePolicyFor navigationResponse: WKNavigationResponse,
                 decisionHandler: @escaping (WKNavigationResponsePolicy) -> Void) {

        guard let url = navigationResponse.response.url,
              url.path == "/blank.html",
                let fragment = url.fragment  else {
            decisionHandler(.allow)
            return
        }

        let params = fragment
            .components(separatedBy: "&")
            .map { $0.components(separatedBy: "=") }
            .reduce([String: String]()) { result, param in
                var dict = result
                let key = param[0]
                let value = param[1]
                dict[key] = value
                return dict
        }

        let token = params["access_token"]
        let userID = params["user_id"]

        if let token = token,
           let userID = userID {
            VkService.shared.setSession(with: token, and: userID)
        }

        let mainTabBarController = MainTabBarController()
        mainTabBarController.modalPresentationStyle = .fullScreen
        present(mainTabBarController, animated: true)

        decisionHandler(.cancel)
    }
}
