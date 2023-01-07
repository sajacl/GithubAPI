//
//  AccessTokenDecodableModel.swift
//  GithubAPI
//
//  Created by Sajad Vishkai on 2023-01-07.
//

import Foundation

struct AccessTokenDecodableModel: Decodable {
    public let accessToken: String
    public let tokenType: String
    public let scope: String

    enum CodingKeys: String, CodingKey {
        case accessToken = "access_token"
        case tokenType = "token_type"
        case scope = "scope"
    }
}
