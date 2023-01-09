//
//  ListViewController.swift
//  GithubAPI
//
//  Created by Sajad Vishkai on 2023-01-06.
//

import Foundation
import UIKit
import Common

typealias TableViewHandler = UITableViewDataSource & UITableViewDelegate

final class ListViewController: BaseViewController, ListViewInterface {
    var presenter: ListPresenterInterface!

    private lazy var listView = ListView(frame: view.frame, tableViewHandler: self)
        .prepareForAutoLayout()

    private var repositories: [RepositoryEntity] = []

    override func configViewController() {
        view.backgroundColor = UIColor.background

        title = NSLocalizedString(
            "LIST_TITLE",
            tableName: "List",
            value: "Repository list",
            comment: ""
        )

        listView.refreshControllerAction = { [weak self] in
            self?.requestRepositories()
        }

        requestRepositories()
    }

    override func addViews() {
        view.addSubview(listView)
    }

    override func constraintViews() {
        listView
            .topAnchor(equalTo: view.layoutMarginsGuide.topAnchor)
            .leadingAnchor(equalTo: view.leadingAnchor)
            .trailingAnchor(equalTo: view.trailingAnchor)
            .bottomAnchor(equalTo: view.bottomAnchor)
    }

    func requestRepositories() {
        presenter.fetchRepositories(for: "sajacl")
        listView.showLoading()
    }

    // MARK: - ListViewInterface

    func repositoriesReceived(_ repositories: [RepositoryEntity]) {
        self.repositories = repositories

        listView.stopRefreshingIfNeeded()
        listView.reload(animated: true)
    }

    func fetchRepositoriesFailed(with error: String) {
        listView.stopRefreshingIfNeeded()
        listView.showFailure(with: error)
    }
}

extension ListViewController: TableViewHandler {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        repositories.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(
            withIdentifier: ListView.tableCellIdentifier,
            for: indexPath
        ) as! RepositoryTableViewCell

        cell.updateView(with: repositories[indexPath.row])
        
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        presenter.repositorySelected(repositories[indexPath.row])
    }
}
