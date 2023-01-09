//
//  ReachabilityCondition.swift
//  
//
//  Created by Sajad Vishkai on 2022-11-10.
//

import Foundation
import SystemConfiguration

public struct ReachabilityCondition: OperationCondition {
    public var name: String {
        "Reachability"
    }

    public var isMutuallyExclusive: Bool {
        return true
    }

    let host: URL

    public init(host: URL) {
        self.host = host
    }

    public func evaluate(for operation: Operation, completion: @escaping (Bool) -> Void) {
        ReachabilityController.requestReachability(host, completionHandler: completion)
    }
}

/// A private singleton that maintains a basic cache of `SCNetworkReachability` objects.
/// This is a very basic "is reachable" check, you can go crazy on your implementation if you like :).
private class ReachabilityController {
    static var reachabilityRefs = [String: SCNetworkReachability]()

    static let reachabilityQueue = DispatchQueue(label: "Operations.Reachability")

    static func requestReachability(_ url: URL, completionHandler: @escaping (Bool) -> Void) {
        if let host = url.host {
            reachabilityQueue.async {
                var ref = self.reachabilityRefs[host]

                if ref == nil {
                    let hostString = host as NSString
                    ref = SCNetworkReachabilityCreateWithName(nil, hostString.utf8String!)
                }

                if let ref = ref {
                    self.reachabilityRefs[host] = ref

                    var reachable = false
                    var flags: SCNetworkReachabilityFlags = []
                    if SCNetworkReachabilityGetFlags(ref, &flags) {
                        reachable = flags.contains(.reachable)
                    }
                    completionHandler(reachable)
                } else {
                    completionHandler(false)
                }
            }
        } else {
            completionHandler(false)
        }
    }
}
