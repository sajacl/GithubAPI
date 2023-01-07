//
//  RepositoryDecodableModel.swift
//  GithubAPI
//
//  Created by Sajad Vishkai on 2023-01-07.
//

import Foundation

struct RepositoryDecodableModel: Decodable {
    let id: Int?
    let nodeId, name, fullName: String?
    let owner: RepositoryOwnerDecodableModel?
    let isPrivate: Bool?
    let htmlURL: String?
    let description: String?
    let url: String?
    let forksCount, stargazersCount, watchersCount: Int?

    enum CodingKeys: String, CodingKey {
        case id
        case nodeId = "node_id"
        case name
        case fullName = "full_name"
        case owner
        case isPrivate = "private"
        case htmlURL = "html_url"
        case description = "description"
        case url
        case forksCount = "forks_count"
        case stargazersCount = "stargazers_count"
        case watchersCount = "watchers_count"
    }
}

struct RepositoryOwnerDecodableModel: Decodable {
    let login: String?
    let id: Int?
    let avatarURL, url, htmlURL: String?

    enum CodingKeys: String, CodingKey {
        case login, id
        case avatarURL = "avatar_url"
        case url
        case htmlURL = "html_url"
    }
}
