//
//  LoginViewController.swift
//  GithubAPI
//
//  Created by Sajad Vishkai on 2023-01-07.
//

import Foundation
import UIKit
import Common

/// URLQuery key regarding `code` that we use to fetch access token.
private let codeURLQueryKey = "code"

final class LoginViewController: BaseViewController {
    private let webViewController: WebViewController

    private let viewModel = LoginViewModel()

    private let credentials: LoginCredentials

    public init(credentials: LoginCredentials) {
        self.credentials = credentials

        webViewController = WebViewController(url: LoginViewModel.buildURLFactory(credentials: credentials))

        super.init()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func configViewController() {
        view.backgroundColor = UIColor.background

        title = _title

        viewModel.errorCallback = { [weak self] error in
            guard let self = self else {
                // no op
                return
            }

            let alert = self.makeErrorAlertViewController(with: error)
            self.present(alert, animated: true)
        }

        viewModel.successCallback = { [weak self] in
            guard let self = self else {
                // no op
                return
            }

            if UIDevice.current.userInterfaceIdiom == .pad {
                self.dismiss(animated: true)
            } else {
                self.navigationController?.setRootWireframe(ListRouter())
            }
        }

        webViewController.didMove(toParent: self)
        webViewController.delegate = self
    }

    override func addViews() {
        addChild(webViewController)

        webViewController.view.prepareForAutoLayout()

        view.addSubview(webViewController.view)
    }

    override func constraintViews() {
        webViewController.view
            .topAnchor(equalTo: view.topAnchor)
            .leadingAnchor(equalTo: view.leadingAnchor)
            .trailingAnchor(equalTo: view.trailingAnchor)
            .bottomAnchor(equalTo: view.bottomAnchor)
    }

    private func makeErrorAlertViewController(with message: String) -> UIViewController {
        return UIAlertController(
            title: errorTitle,
            message: message,
            preferredStyle: .alert
        )
    }

    private var _title: String {
        NSLocalizedString(
            "LOGIN_TITLE",
            tableName: "Login",
            value: "Login via Github",
            comment: ""
        )
    }

    private lazy var errorTitle: String = {
        NSLocalizedString(
            "ERROR_TITLE",
            tableName: "Login",
            value: "Try again",
            comment: ""
        )
    }()
}

extension LoginViewController: WebViewControllerDelegate {
    func didFinishNavigation(with url: URL?) {
        guard let url = url,
              let urlComponents = URLComponents(string: url.absoluteString),
              let host = urlComponents.host,
              let scheme = urlComponents.scheme else {

            return
        }

        let path = urlComponents.path
        let _url = scheme + "://" + host + path

        guard _url == credentials.redirectURL else { return }

        guard let queryItem = urlComponents.queryItems?.first(where: { $0.name == codeURLQueryKey }),
              let code = queryItem.value else {

            return
        }

        viewModel.requestToken(with: LoginAuthenticationCredentials(
            clientId: credentials.clientId,
            clientSecret: credentials.clientSecret,
            code: code,
            redirectURL: credentials.redirectURL
        ))
    }
}
