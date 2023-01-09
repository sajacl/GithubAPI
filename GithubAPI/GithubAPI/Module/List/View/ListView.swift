//
//  ListView.swift
//  GithubAPI
//
//  Created by Sajad Vishkai on 2023-01-08.
//

import Foundation
import UIKit
import Common

final class ListView: BaseView {
    static let tableCellIdentifier = "ListCellIdentifier"

    private lazy var refreshControl: UIRefreshControl = {
        let parent = UIRefreshControl(frame: .zero)
        parent.attributedTitle = NSAttributedString(
            string: refreshControlLabel,
            attributes: [NSAttributedString.Key.foregroundColor: UIColor.text]
        )
        parent.accessibilityLabel = refreshControlLabel
        return parent
    }()

    private lazy var repositoriesTableView: UITableView = {
        let parent = UITableView()
        parent.backgroundColor = UIColor.background
        parent.refreshControl = refreshControl
        parent.dataSource = tableViewHandler
        parent.delegate = tableViewHandler
        parent.register(RepositoryTableViewCell.self, forCellReuseIdentifier: Self.tableCellIdentifier)
        parent.rowHeight = 60
        parent.separatorStyle = .none
        parent.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 20, right: 0)
        parent.isHidden = true
        parent.prepareForAutoLayout()
        return parent
    }()

    private lazy var loadingView: UIView = {
        let parent = LoadingView()
        parent.prepareForAutoLayout()
        return parent
    }()

    private lazy var failureView: UILabel = {
        let parent = UILabel()
        parent.font = UIFont.systemFont(ofSize: 15, weight: .semibold)
        parent.isHidden = true
        parent.prepareForAutoLayout()
        return parent
    }()

    private var state: State = .loading

    private let tableViewHandler: TableViewHandler

    var refreshControllerAction: (() -> Void)?

    init(frame: CGRect, tableViewHandler: TableViewHandler) {
        self.tableViewHandler = tableViewHandler

        super.init(frame: frame)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func configViewController() {
        self.backgroundColor = UIColor.background
    }

    override func addViews() {
        self.addSubviews(
            repositoriesTableView,
            loadingView,
            failureView
        )
    }

    override func constraintViews() {
        repositoriesTableView
            .topAnchor(equalTo: self.topAnchor)
            .leadingAnchor(equalTo: self.leadingAnchor)
            .trailingAnchor(equalTo: self.trailingAnchor)
            .bottomAnchor(equalTo: self.bottomAnchor)

        loadingView
            .topAnchor(equalTo: self.topAnchor)
            .leadingAnchor(equalTo: self.leadingAnchor)
            .trailingAnchor(equalTo: self.trailingAnchor)
            .bottomAnchor(equalTo: self.bottomAnchor)

        failureView
            .centerXAnchor(equalTo: self.centerXAnchor)
            .centerYAnchor(equalTo: self.centerYAnchor)
            .leadingAnchor(equalTo: self.leadingAnchor)
            .trailingAnchor(equalTo: self.trailingAnchor)
    }

    override func subscribeClicks() {
        refreshControl.addTarget(self, action: #selector(refresherTriggered), for: .valueChanged)
    }

    func stopRefreshingIfNeeded() {
        if refreshControl.isRefreshing, state.isRefreshing {
            refreshControl.endRefreshing()
        }
    }

    func reload(animated: Bool) {
        if animated {
            repositoriesTableView.reloadSections(IndexSet(integer: 0), with: .automatic)
        } else {
            repositoriesTableView.reloadData()
        }

        updateView(with: .items)
    }

    func showFailure(with error: String) {
        lazy var error = getFailureText(error)

        if case let .failure(currentError) = state {
            guard error != currentError else {
                // no op
                // Showing the same message twice?
                return
            }
        }

        updateView(with: .failure(error))
    }

    func showLoading() {
        guard state.isLoading else {
            // no op
            return
        }

        updateView(with: .loading)
    }

    @objc private func refresherTriggered(_ sender: UIRefreshControl) {
        guard !state.isRefreshing else {
            // no op
            return
        }

        updateView(with: .refreshing)
    }

    private func updateView(with state: State) {
        switch state {
        case .items:
            doWithAnimation {
                self.loadingView.isHidden = true
                self.failureView.isHidden = true
                self.repositoriesTableView.isHidden = false
            }

        case .loading:
            doWithAnimation {
                self.repositoriesTableView.isHidden = true
                self.failureView.isHidden = true
                self.loadingView.isHidden = false
            }

        case .refreshing:
            refreshControllerAction?()

        case let .failure(error):
            doWithAnimation {
                self.repositoriesTableView.isHidden = true
                self.loadingView.isHidden = true
                self.failureView.isHidden = false
            } completion: { _ in
                self.failureView.text = self.getFailureText(error)
            }
        }

        self.state = state
    }

    private func doWithAnimation(
        _ animations: @escaping () -> Void,
        completion: ((Bool) -> Void)? = nil
    ) {
        UIView.animate(withDuration: 0.2, delay: 0, options: [.curveEaseInOut]) {
            animations()
        } completion: { isFinished in
            completion?(isFinished)
        }
    }

    /// Localized string to be used for title and accessibility label.
    private var refreshControlLabel: String {
        NSLocalizedString(
            "REFRESH_CONTROL_TITLE",
            tableName: "List",
            value: "Fetching repositories",
            comment: ""
        )
    }

    private func getFailureText(_ error: String) -> String {
        NSLocalizedString(
            "FAILURE_TITLE",
            tableName: "List",
            value: "Fetching repositories has failed.\n\(error)",
            comment: ""
        )
    }

    private enum State {
        case loading
        case refreshing
        case failure(String)
        case items

        var isRefreshing: Bool {
            if case .refreshing = self {
                return true
            }

            return false
        }

        var isLoading: Bool {
            if case .loading = self {
                return true
            }

            return false
        }
    }
}
