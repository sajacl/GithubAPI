//
//  LoginViewModel.swift
//  GithubAPI
//
//  Created by Sajad Vishkai on 2023-01-07.
//

import Foundation
import Operations
import OSLog

private let dispatchQueueLabel = "LoginViewModel<InternalQueue>"

final class LoginViewModel {
    private var queue: OperationQueue {
        return AsyncOperationQueue()
    }

    private let internalDispatchQueue = DispatchQueue(label: dispatchQueueLabel)
    private let codableProxy = CodableProxy.default

    var successCallback: (() -> Void)?
    var errorCallback: ((String) -> Void)?

    private let logger = Logger.login

    func requestToken(with credentials: LoginAuthenticationCredentials) {
        guard let url = URL(string: ServerUrl.login.url) else {
            errorCallback?(URLError(.badURL).localizedDescription)
            return
        }

        let buidler = URLRequestBuilder(url: url, codableProxy: codableProxy)

        do {
            try buidler
                .set(method: .get)
                .set(header: [.accept: .applicationJSON])
                .set(parameters: credentials.dictionary)
        } catch {
            logger.error(
                error: error,
                message: "Failure to add parameters to login http request."
            )

            errorCallback?(error.localizedDescription)
            return
        }

        let operation = FetchAccessTokenOperation.createOperationFactory(
            request: buidler.urlRequest,
            dispatchQueue: internalDispatchQueue,
            parser: codableProxy) { [weak self] result in
                guard let self = self else {
                    // no op
                    // There is no need to show changes,
                    // when user decided to dismiss this module.
                    return
                }

                switch result {
                case let .success(token):
                    self.saveTokenToKeychain(token)

                case let .failure(error):
                    self.logger.error(
                        error: error,
                        message: "Failure to login via Github api."
                    )

                    self.errorCallback?(error.localizedDescription)

                case .cancelled: break
                }
            }

        queue.addOperation(operation)
    }

    private func saveTokenToKeychain(_ token: String) {
        do {
            try KeychainManager.save(token: token)

            successCallback?()
        } catch {
            logger.error(error: error, message: "Failure to save token in keychain.")
            errorCallback?(error.localizedDescription)
        }
    }

    static func buildURLFactory(credentials: LoginCredentials) -> URL {
        var urlComponents = URLComponents()
        urlComponents.scheme = "https"
        urlComponents.host = "github.com"
        urlComponents.path = "/login/oauth/authorize"

        urlComponents.queryItems = [
            URLQueryItem(name: LoginQueryKey.scope.rawValue, value: LoginScope.repo),
            URLQueryItem(name: LoginQueryKey.redirectURL.rawValue, value: credentials.redirectURL),
            URLQueryItem(name: LoginQueryKey.allowSignup.rawValue, value: "false"),
            URLQueryItem(name: LoginQueryKey.clientId.rawValue, value: credentials.clientId)
        ]

        return urlComponents.url!
    }

    private enum LoginQueryKey: String {
        case scope
        case redirectURL = "redirect_uri"
        case allowSignup = "allow_signup"
        case clientId = "client_id"
    }
}
