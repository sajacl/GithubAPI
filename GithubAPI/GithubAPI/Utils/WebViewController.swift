//
//  WebViewController.swift
//  GithubAPI
//
//  Created by Sajad Vishkai on 2023-01-07.
//

import WebKit
import Common

protocol WebViewControllerDelegate: AnyObject {
    func didFinishNavigation(with url: URL?)
}

final class WebViewController: BaseViewController {
    private let url: URL

    weak var delegate: WebViewControllerDelegate?

    init(url: URL) {
        self.url = url

        super.init()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private lazy var webView = WKWebView()
        .prepareForAutoLayout()

    override func configViewController() {
        setupWebview(url: url)

        self.navigationController?.navigationBar.titleTextAttributes = [
            NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 15),
            NSAttributedString.Key.foregroundColor: UIColor.darkGray
        ]
    }

    override func addViews() {
        view.addSubview(webView)
    }

    override func constraintViews() {
        webView
            .topAnchor(equalTo: view.layoutMarginsGuide.topAnchor)
            .leadingAnchor(equalTo: view.leadingAnchor)
            .trailingAnchor(equalTo: view.trailingAnchor)
            .bottomAnchor(equalTo: view.bottomAnchor)
    }

    // MARK: - Private methods

    private func setupWebview(url: URL) {
        webView.navigationDelegate = self

        let request = URLRequest(url: url)

        // There is an known issue with WKWebView about hanging warning,
        // You can follow the discussion from bugzilla or hacking with swift.
        // https://www.hackingwithswift.com/forums/swiftui/xcode-14-warning-this-method-should-not-be-called-on-the-main-thread-as-it-may-lead-to-ui-unresponsiveness/17431
        // I'm putting this here so in future you can't blame it on me :D
        webView.load(request)
    }

    private lazy var closeButton: UIButton = {
        let button = UIButton(type: .close)
        button.backgroundColor = .white
        return button
    }()

    public func addCloseButton() {
        webView.addSubview(closeButton)

        closeButton
            .trailingAnchor(equalTo: webView.trailingAnchor, constant: -19)
            .topAnchor(equalTo: webView.topAnchor, constant: 20)
            .widthAnchor(constant: 26)
            .heightAnchor(constant: 26)

        closeButton.addTarget(self, action: #selector(closeButtonClicked), for: .touchUpInside)
    }

    @objc private func closeButtonClicked(_ sender: UIButton) {
        if (navigationController?.viewControllers.count ?? 0) > 0 {
            self.navigationController?.popViewController(animated: true)
        } else {
            self.dismiss(animated: true)
        }
    }
}

// MARK: - WKNavigationDelegate

extension WebViewController: WKNavigationDelegate {
    func webView(_ webView: WKWebView, didFinish _: WKNavigation) {
        self.title = webView.title

        delegate?.didFinishNavigation(with: webView.url)
    }
}
