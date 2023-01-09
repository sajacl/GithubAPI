//
//  ServerURL.swift
//  GithubAPI
//
//  Created by Sajad Vishkai on 2023-01-07.
//

import Foundation

enum ServerUrl {
    case login
    case repositoryList(String)

    var url: String {
        let path: String

        switch self {
        case .login:
            path = "https://github.com/login/oauth/access_token"
        case let .repositoryList(owner):
            path = "https://api.github.com/users/\(owner)/repos"
        }

        return path
    }
}
