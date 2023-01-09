//
//  FetchRepositoriesOperation.swift
//  GithubAPI
//
//  Created by Sajad Vishkai on 2023-01-06.
//

import Foundation
import Operations
import class UIKit.UIApplication

private let fetchListBackgroundObserverTag = "FetchRepositories<BGObserver>"

final class FetchRepositoriesOperation: ResultOperation<[RepositoryDecodableModel], Error> {
    /// I prefer to put the actual site that I'm trying to fetch data from,
    /// You can put what ever you like, `Google` or `Apple` or etc...
    private static let urlToTestReachability = URL(string: "www.github.com")!

    private var urlSessionTask: URLSessionDataTask?

    private let owner: String
    private let urlSession: URLSession
    private let parser: CodableProxy

    private init(
        owner: String,
        urlSession: URLSession,
        parser: CodableProxy,
        dispatchQueue: DispatchQueue?,
        completionQueue: DispatchQueue?,
        completionHandler: ResultOperation<[RepositoryDecodableModel], Error>.CompletionHandler?
    ) {
        self.owner = owner
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

        guard let url = URL(string: ServerUrl.repositoryList(owner).url) else {
            finish(error: URLError(.badURL))
            return
        }

        urlSessionTask = urlSession.dataTask(with: URLRequest(url: url)) { [weak self] data, response, error in
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
            let repositories = try parser.parsePayload(as: [RepositoryDecodableModel].self, from: data)
            self.finish(completion: .success(repositories))
        } catch {
            finish(error: error)
        }
    }

    override func operationDidCancel() {
        urlSessionTask?.cancel()
    }
}

struct NotValidDataError: LocalizedError {
    var errorDescription: String? {
        "Could not get data value from url session data task."
    }
}

// MARK: - Factory method

extension FetchRepositoriesOperation {
    static func createOperationFactory(
        owner: String,
        urlSession: URLSession = .shared,
        dispatchQueue: DispatchQueue,
        parser: CodableProxy,
        completion: @escaping ResultOperation<[RepositoryDecodableModel], Error>.CompletionHandler
    ) -> AsyncOperation {
        let operation = FetchRepositoriesOperation(
            owner: owner,
            urlSession: urlSession,
            parser: parser,
            dispatchQueue: dispatchQueue,
            completionQueue: .main,
            completionHandler: completion
        )

//        operation.addCondition(ReachabilityCondition(host: Self.urlToTestReachability))
        operation.addCondition(MutuallyExclusive(category: AppOperationCategory.fetchList.rawValue))

        return operation
    }
}
