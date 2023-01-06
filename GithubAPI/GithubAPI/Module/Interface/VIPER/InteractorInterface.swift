//
//  InteractorInterface.swift
//  GithubAPI
//
//  Created by Sajad Vishkai on 2023-01-06.
//

import Foundation

protocol InteractorInterface: AnyObject {
    var queue: OperationQueue { get }

    func cancelAll()
}

extension InteractorInterface {
    func cancelAll() {
        queue.cancelAllOperations()
    }
}
