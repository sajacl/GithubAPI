//
//  ListInteractor.swift
//  GithubAPI
//
//  Created by Sajad Vishkai on 2023-01-06.
//

import Foundation
import Operations

private let dispatchQueueLabel = "ListInteractor<InternalQueue>"

final class ListInteractor: ListInteractorInterface {
    var queue: OperationQueue {
        return AsyncOperationQueue()
    }

    private let internalDispatchQueue = DispatchQueue(label: dispatchQueueLabel)

    func fetchList(
        for owner: String,
        _ completion: @escaping ResultOperation<[RepositoryDecodableModel], Error>.CompletionHandler
    ) {
        let operation = FetchRepositoriesOperation.createOperationFactory(
            owner: owner,
            dispatchQueue: internalDispatchQueue,
            parser: .default,
            completion: completion
        )

        queue.addOperation(operation)
    }

    deinit {
        queue.cancelAllOperations()
    }
}
