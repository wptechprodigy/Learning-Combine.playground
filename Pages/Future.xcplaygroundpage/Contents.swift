//: [Previous](@previous)

import Foundation
import Combine

/// Future: can be used to asynchronuously produce
/// a single result and then complete
example(of: "Future") {

    // MARK: - Subscriptions

    var subscriptions = Set<AnyCancellable>()

    // MARK: - Future Factory

    func futureIncrement(
        integer: Int,
        afterDelay delay: TimeInterval
    ) -> Future<Int, Never> {

        Future<Int, Never> { promise in
            DispatchQueue.global().asyncAfter(deadline: .now() + delay) {
                promise(.success(integer + 1))
            }
        }
    }

    let future = futureIncrement(integer: 1, afterDelay: 3)
    future
        .sink(
            receiveCompletion: { print($0) },
            receiveValue: { print($0) })
        .store(in: &subscriptions)
}

//: [Next](@next)
