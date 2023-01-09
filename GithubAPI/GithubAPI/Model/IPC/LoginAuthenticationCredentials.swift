//
//  LoginAuthenticationCredentials.swift
//  GithubAPI
//
//  Created by Sajad Vishkai on 2023-01-07.
//

import Foundation

struct LoginCredentials {
    let clientId: String
    let clientSecret: String
    let redirectURL: String
}

struct LoginAuthenticationCredentials {
    let clientId: String
    let clientSecret: String
    let code: String
    let redirectURL: String
    
    var dictionary: [String: String] {
        return [
            "client_id": clientId,
            "client_secret": clientSecret,
            "code": code,
            "redirect_uri": redirectURL
        ]
    }
}
