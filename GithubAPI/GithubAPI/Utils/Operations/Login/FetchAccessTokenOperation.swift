//
//  FetchAccessTokenOperation.swift
//  GithubAPI
//
//  Created by Sajad Vishkai on 2023-01-07.
//

import Foundation
import Operations
import class UIKit.UIApplication

private let fetchAccessBackgroundObserverTag = "FetchAccessToken<BGObserver>"

final class FetchAccessTokenOperation: ResultOperation<String, Error> {
    /// I prefer to put the actual site that I'm trying to fetch data from,
    /// You can put what ever you like, `Google` or `Apple` or etc...
    private static let urlToTestReachability = URL(string: "www.github.com")!

    private var urlSessionTask: URLSessionDataTask?

    private let request: URLRequest
    private let urlSession: URLSession
    private let parser: CodableProxy

    private init(
        request: URLRequest,
        urlSession: URLSession = .shared,
        parser: CodableProxy,
        dispatchQueue: DispatchQueue,
        completionQueue: DispatchQueue?,
        completionHandler: @escaping ResultOperation<String, Error>.CompletionHandler
    ) {
        self.request = request
        self.urlSession = urlSession
        self.parser = parser

        super.init(
            dispatchQueue: dispatchQueue,
            completionQueue: completionQueue,
            completionHandler: completionHandler
        )
    }

    override func main() {
        dispatchPrecondition(condition: .onQueue(dispatchQueue))

        guard !isCancelled else {
            finish(completion: .cancelled)
            return
        }

        urlSessionTask = urlSession.dataTask(with: request) { [weak self] data, response, error in
            guard let self = self else {

                return
            }

            if let error = error {
                self.finish(error: error)
                return
            }

            guard let response = response as? HTTPURLResponse else {
                self.finish(error: URLError(.cannotParseResponse))
                return
            }

            guard response.statusCode == 200 else {
                self.finish(error: URLError(.badServerResponse))
                return
            }

            guard let data = data else {
                self.finish(error: NotValidDataError())
                return
            }

            self.decodeData(data)
        }

        urlSessionTask?.resume()
    }

    private func decodeData(_ data: Data) {
        do {
            let accessTokenResponse = try parser.parsePayload(as: AccessTokenDecodableModel.self, from: data)

            if !accessTokenResponse.scope.contains(LoginScope.repo) {
                finish(error: AccessDeniedError())
                return
            }

            finish(completion: .success(accessTokenResponse.accessToken))
        } catch {
            finish(error: error)
        }
    }

    override func operationDidCancel() {
        urlSessionTask?.cancel()
    }
}

// MARK: - Factory method

extension FetchAccessTokenOperation {
    static func createOperationFactory(
        request: URLRequest,
        urlSession: URLSession = .shared,
        dispatchQueue: DispatchQueue,
        parser: CodableProxy,
        application: UIApplication = .shared,
        completion: @escaping ResultOperation<String, Error>.CompletionHandler
    ) -> AsyncOperation {
        let operation = FetchAccessTokenOperation(
            request: request,
            urlSession: urlSession,
            parser: parser,
            dispatchQueue: dispatchQueue,
            completionQueue: .main,
            completionHandler: completion
        )

        operation.addObserver(BackgroundObserver(application: application,
                                                 name: fetchAccessBackgroundObserverTag,
                                                 cancelUponExpiration: true))

//        operation.addCondition(ReachabilityCondition(host: Self.urlToTestReachability))
        operation.addCondition(MutuallyExclusive(category: AppOperationCategory.fetchList.rawValue))

        return operation
    }
}

struct AccessDeniedError: LocalizedError {
    var errorDescription: String? {
        "User denied to give us access to repositories."
    }
}
