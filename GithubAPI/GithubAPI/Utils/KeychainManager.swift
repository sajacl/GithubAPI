//
//  KeychainManager.swift
//  GithubAPI
//
//  Created by Sajad Vishkai on 2023-01-07.
//

import Foundation
import Common

private let keychainServiceName = "GithubAPI"

enum KeychainManager {
    private static let store: Store = KeychainStore(
        serviceName: keychainServiceName
    )

    private static func makeParser() -> CodableProxy {
        .default
    }

    static func save(token: String) throws {
        let tokenData = try makeParser().producePayload(token)
        try save(tokenData, for: .token)
    }

    static func readToken() throws -> String {
        let tokenData = try read(key: .token)
        return try makeParser().parsePayload(as: String.self, from: tokenData)
    }

    static func deleteToken() throws {
        try delete(key: .token)
    }

    static private func save(_ data: Data, for key: Key) throws {
        try store.write(data, for: key.rawValue)
    }

    static private func read(key: Key) throws -> Data {
        try store.read(key: key.rawValue)
    }

    static private func delete(key: Key) throws {
        try store.delete(key: key.rawValue)
    }
}

extension KeychainManager {
    enum Key: String {
        case token
    }
}
