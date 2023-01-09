//
//  URLRequestBuilder.swift
//  GithubAPI
//
//  Created by Sajad Vishkai on 2023-01-08.
//

import Foundation

final class URLRequestBuilder {
    private(set) var urlRequest: URLRequest
    private let codableProxy: CodableProxy

    init(with baseURL: String, path: String, codableProxy: CodableProxy) throws {
        guard let url = URL(string: baseURL + path) else {
            throw URLError(.badURL)
        }

        urlRequest = URLRequest(url: url)
        self.codableProxy = codableProxy
    }

    init(url: URL, codableProxy: CodableProxy) {
        urlRequest = URLRequest(url: url)
        self.codableProxy = codableProxy
    }

    @discardableResult
    func set(method: HTTPMethod) -> Self {
        urlRequest.httpMethod = method.rawValue
        return self
    }

    @discardableResult
    func set(header values: [HeaderName: ContentType]) -> Self {
        values.forEach {
            urlRequest.addValue($0.value.rawValue, forHTTPHeaderField: $0.key.rawValue)
        }
        return self
    }

    @discardableResult
    /// - Warning: Method is set to `GET` by default.
    func set(parameters: [String: String]) throws -> Self {
        if let httpMethod = urlRequest.httpMethod,
           let method = HTTPMethod(rawValue: httpMethod) {
            switch method {
            case .get:
                urlRequest.url = try buildURLParams(parameters)

            case .post:
                urlRequest.httpBody = try buildRequestParams(parameters)
            }
        } else {
            urlRequest.url = try buildURLParams(parameters)
        }

        return self
    }

    @discardableResult
    func set(timeout: UInt) -> Self {
        urlRequest.timeoutInterval = TimeInterval(timeout)
        return self
    }

    private func buildRequestParams(_ parameters: Encodable) throws -> Data {
        try codableProxy.producePayload(parameters)
    }

    private func buildURLParams(_ parameters: [String: String]) throws -> URL? {
        guard let url = urlRequest.url,
              var urlComponents = URLComponents(url: url, resolvingAgainstBaseURL: true)
        else { throw MalformedURLError() }

        urlComponents.percentEncodedQueryItems = parameters.map {
            URLQueryItem(name: $0.key, value: $0.value)
        }

        return urlComponents.url
    }

    struct MalformedURLError: LocalizedError {
        var errorDescription: String? {
            "URL for current request is malformed."
        }
    }
}

extension URLRequestBuilder {
    /// Wrapper for possible header name of a request.
    /// Making it a `struct` with rawValue instead of `enum` gives more flexibility.
    struct HeaderName: Hashable {
        var rawValue: String

        static let accept: HeaderName = "Accept"

        static let contentType = URLRequestBuilder.ContentType.header
    }

    /// Wrapper for value of a header.
    /// Making it a `struct` with rawValue instead of `enum` gives more flexibility.
    struct ContentType {
        var rawValue: String

        static let header: HeaderName = "Content-Type"

        static let applicationJSON: ContentType = "application/json"
    }
}

extension URLRequestBuilder.HeaderName: ExpressibleByStringLiteral {
    init(stringLiteral value: StringLiteralType) {
        self.init(rawValue: value)
    }
}

extension URLRequestBuilder.ContentType: ExpressibleByStringLiteral {
    init(stringLiteral value: StringLiteralType) {
        self.init(rawValue: value)
    }
}
