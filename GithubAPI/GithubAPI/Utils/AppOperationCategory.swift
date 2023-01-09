//
//  AppOperationCategory.swift
//  GithubAPI
//
//  Created by Sajad Vishkai on 2023-01-06.
//

import Foundation

/// All operations that we run through the app life cycle.
/// For the sake of MVP I will not add nested types.
/// Operation's added here will be mutually exclusive.
enum AppOperationCategory: String {
    /// Operation to fetch access token from api.
    case login
    /// Operation to fetch repository list from api.
    case fetchList
}
