//
//  Store 2.swift
//  
//
//  Created by Sajad Vishkai on 2023-01-07.
//

import Foundation

public protocol Store {
    func read(key: String) throws -> Data
    func write(_ data: Data, for key: String) throws
    func delete(key: String) throws
}
