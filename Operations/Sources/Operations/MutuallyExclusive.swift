//
//  MutuallyExclusive.swift
//  
//
//  Created by Sajad Vishkai on 2022-11-19.
//

import Foundation

public final class MutuallyExclusive: OperationCondition {
    public let name: String

    public var isMutuallyExclusive: Bool {
        return true
    }

    public init(category: String) {
        name = "MutuallyExclusive<\(category)>"
    }

    public func evaluate(for operation: Operation, completion: @escaping (Bool) -> Void) {
        completion(true)
    }
}
