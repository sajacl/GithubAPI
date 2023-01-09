//
//  CodableProxy.swift
//  GithubAPI
//
//  Created by Sajad Vishkai on 2023-01-07.
//

import Foundation

/// Simple entity to handle decoding and encoding.
struct CodableProxy {
    /// The decoder used to decode values.
    private let decoder: JSONDecoder

    /// The encoder used to encode values.
    private let encoder: JSONEncoder

    static let `default` = CodableProxy(
        decoder: JSONDecoder(),
        encoder: JSONEncoder()
    )

    init(decoder: JSONDecoder, encoder: JSONEncoder) {
        self.decoder = decoder
        self.encoder = encoder
    }

    /// Produces encoded data from the given type
    func producePayload<T: Encodable>(_ payload: T) throws -> Data {
        return try encoder.encode(payload)
    }

    /// Returns payload as the given type.
    func parsePayload<T: Decodable>(
        as type: T.Type,
        from data: Data
    ) throws -> T {
        return try decoder.decode(T.self, from: data)
    }
}
