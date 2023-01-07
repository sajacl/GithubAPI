//
//  OperationCondition.swift
//  
//
//  Created by Sajad Vishkai on 2022-11-10.
//

import Foundation

public protocol OperationCondition {
    var name: String { get }
    var isMutuallyExclusive: Bool { get }

    func evaluate(for operation: Operation, completion: @escaping (Bool) -> Void)
}
