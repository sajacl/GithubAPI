//
//  ThreadManagement.swift
//  GithubAPI
//
//  Created by Sajad Vishkai on 2023-01-06.
//

import Foundation

private let userInteractiveQueueLabel = "ThreadManagement<userInteractive>"
private let backgroundQueueLabel = "ThreadManagement<background>"

public protocol ThreadManagement {
    func doOnMainThread(_ job: @escaping () -> Void)
    func doOnMainThreadAfter(delay: DispatchTime, _ job: @escaping () -> Void)
    func doOnBackgroundThread(_ job: @escaping () -> Void)
    func doOnBackgroundThreadAfter(delay: DispatchTime, _ job: @escaping () -> Void)
    func doOnCustomThread(queue: DispatchQueue, _ job: @escaping () -> Void)
    func doOnCustomThreadAfter(delay: DispatchTime, queue: DispatchQueue, _ job: @escaping () -> Void)
    func doOnCustomGroup(group: DispatchGroup, timeOut: DispatchTime?, _ job: (_ group: DispatchGroup) -> Void)

    func returnOnMainThread<T>(value: T) -> T
    func returnOnBackgroundThread<T>(value: T) -> T
}

public extension ThreadManagement {
    func doOnMainThread(_ job: @escaping () -> Void) {
        DispatchQueue.main.async { job() }
    }

    func doOnMainThreadAfter(delay: DispatchTime, _ job: @escaping () -> Void) {
        DispatchQueue.main.asyncAfter(deadline: delay) { job() }
    }

    func doOnBackgroundThread(_ job: @escaping () -> Void) {
        DispatchQueue.global(qos: .background).async { job() }
    }

    func doOnBackgroundThreadAfter(delay: DispatchTime, _ job: @escaping () -> Void) {
        DispatchQueue.global(qos: .background).asyncAfter(deadline: delay) { job() }
    }

    func doOnCustomThread(queue: DispatchQueue, _ job: @escaping () -> Void) {
        queue.async { job() }
    }

    func doOnCustomThreadAfter(delay: DispatchTime, queue: DispatchQueue, _ job: @escaping () -> Void) {
        queue.asyncAfter(deadline: delay) { job() }
    }

    func doOnCustomGroup(group: DispatchGroup, timeOut: DispatchTime?, _ job: (_ group: DispatchGroup) -> Void) {
        group.enter()
        job(group)

        if let timeOut = timeOut {
            _ = group.wait(timeout: timeOut)
        } else {
            group.wait()
        }
    }

    func returnOnMainThread<T>(value: T) -> T {
        let queueWithIdentifier = DispatchQueue(
            label: userInteractiveQueueLabel, qos: .userInteractive, attributes: .concurrent
        )

        let group = DispatchGroup()
        var result: T?
        group.enter()

        queueWithIdentifier.async(group: group) {
            result = value
            group.leave()
        }

        group.wait()

        return result!
    }

    func returnOnBackgroundThread<T>(value: T) -> T {
        let queueWithIdentifier = DispatchQueue(
            label: backgroundQueueLabel, qos: .background, attributes: .concurrent
        )

        let group = DispatchGroup()
        var result: T?
        group.enter()

        queueWithIdentifier.async(group: group) {
            result = value
            group.leave()
        }

        group.wait()

        return result!
    }
}
