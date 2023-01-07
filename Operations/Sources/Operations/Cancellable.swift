//
//  Cancellable.swift
//  
//
//  Created by Sajad Vishkai on 2022-11-10.
//

import Foundation

public protocol Cancellable {
    func cancel()
}

extension Operation: Cancellable {}
