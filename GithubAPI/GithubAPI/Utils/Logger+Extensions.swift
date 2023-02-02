//
//  Logger+Extensions.swift
//  GithubAPI
//
//  Created by Sajad Vishkai on 2023-01-08.
//

import Foundation
import OSLog

extension Logger {
    private static var subsystem = Bundle.main.bundleIdentifier!
    
    /// Logs events related to login sequence.
    static let login = Logger(subsystem: subsystem, category: "Login")

    /// Logs events related to list.
    static let list = Logger(subsystem: subsystem, category: "List")

    func error<T: Error>(
        error: T,
        message: @autoclosure () -> String? = nil,
        file: String = #file,
        function: String = #function,
        line: UInt = #line
    ) {
        var _error = ""

        if let prefixMessage = message() {
            _error = prefixMessage.addLineBreak()
        }

        _error += "{".addLineBreak()
        _error += "\t" + file.addLineBreak()
        _error += "\t" + function.addLineBreak()
        _error += "\t" + String(line).addLineBreak()
        _error += "}".addLineBreak()

        _error += error.localizedDescription

        self.error("\(_error)")
    }
}

private extension String {
    func addLineBreak() -> Self {
        self + "\n"
    }
}
