//
//  RepositoryEntity.swift
//  GithubAPI
//
//  Created by Sajad Vishkai on 2023-01-08.
//

import Foundation

struct RepositoryEntity: Hashable {
    let id: Int
    let nodeId, name, fullName: String
    let owner: RepositoryOwnerDecodableModel?
    let isPrivate: Bool
    let htmlURL: String
    let description: String
    let url: String
    let forksCount, stargazersCount, watchersCount: Int

    init(from decodable: RepositoryDecodableModel) {
        self.id = decodable.id ?? -1
        self.nodeId = decodable.nodeId ?? ""
        self.name = decodable.name ?? ""
        self.fullName = decodable.fullName ?? ""
        self.owner = decodable.owner
        self.isPrivate = decodable.isPrivate ?? false
        self.htmlURL = decodable.htmlURL ?? ""
        self.description = decodable.description ?? ""
        self.url = decodable.url ?? ""
        self.forksCount = decodable.forksCount ?? -1
        self.stargazersCount = decodable.stargazersCount ?? -1
        self.watchersCount = decodable.watchersCount ?? -1
    }

    func hash(into hasher: inout Hasher) {
        hasher.combine(url)
    }

    static func == (lhs: RepositoryEntity, rhs: RepositoryEntity) -> Bool {
        lhs.id == rhs.id
    }
}
