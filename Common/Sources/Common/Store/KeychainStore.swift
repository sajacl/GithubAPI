//
//  KeychainStore.swift
//  
//
//  Created by Sajad Vishkai on 2023-01-07.
//

import Foundation

final public class KeychainStore: Store {
    let serviceName: String

    public init(serviceName: String) {
        self.serviceName = serviceName
    }

    public func read(key: String) throws -> Data {
        try readItemData(key)
    }

    public func write(_ data: Data, for key: String) throws {
        try addOrUpdateItem(key, data: data)
    }

    public func delete(key: String) throws {
        try deleteItem(key)
    }

    private func addItem(_ item: String, data: Data) throws {
        var query = createDefaultAttributes(item: item)
        query.merge(createAccessAttributes()) { current, _ in
            return current
        }
        query[kSecValueData] = data

        let status = SecItemAdd(query as CFDictionary, nil)
        if status != errSecSuccess {
            throw KeychainError(code: status)
        }
    }

    private func updateItem(_ item: String, data: Data) throws {
        let query = createDefaultAttributes(item: item)
        let status = SecItemUpdate(
            query as CFDictionary,
            [kSecValueData: data] as CFDictionary
        )

        if status != errSecSuccess {
            throw KeychainError(code: status)
        }
    }

    private func addOrUpdateItem(_ item: String, data: Data) throws {
        do {
            try updateItem(item, data: data)
        } catch let error as KeychainError where error == .itemNotFound {
            try addItem(item, data: data)
        } catch {
            throw error
        }
    }

    private func readItemData(_ item: String) throws -> Data {
        var query = createDefaultAttributes(item: item)
        query[kSecReturnData] = true

        var result: CFTypeRef?
        let status = SecItemCopyMatching(query as CFDictionary, &result)

        if status == errSecSuccess {
            return result as? Data ?? Data()
        } else {
            throw KeychainError(code: status)
        }
    }

    private func deleteItem(_ item: String) throws {
        let query = createDefaultAttributes(item: item)
        let status = SecItemDelete(query as CFDictionary)
        if status != errSecSuccess {
            throw KeychainError(code: status)
        }
    }

    private func createDefaultAttributes(item: String) -> [CFString: Any] {
        return [
            kSecClass: kSecClassGenericPassword,
            kSecAttrService: serviceName,
            kSecAttrAccount: item,
        ]
    }

    private func createAccessAttributes() -> [CFString: Any] {
        return [
            kSecAttrAccessible: kSecAttrAccessibleAfterFirstUnlock
        ]
    }
}

public struct KeychainError: LocalizedError, Equatable {
    public let code: OSStatus
    public init(code: OSStatus) {
        self.code = code
    }

    public var errorDescription: String? {
        return SecCopyErrorMessageString(code, nil) as String?
    }

    public static let duplicateItem = KeychainError(code: errSecDuplicateItem)
    public static let itemNotFound = KeychainError(code: errSecItemNotFound)

    public static func == (lhs: KeychainError, rhs: KeychainError) -> Bool {
        return lhs.code == rhs.code
    }
}
