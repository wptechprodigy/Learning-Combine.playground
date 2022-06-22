//: [Previous](@previous)

import Foundation
import Combine

example(of: "Custom Subscriber") {

    // MARK: - Publisher

    let publisher = (1...6).publisher

    // MARK: - Custom Subscriber

    final class IntSubscriber: Subscriber {

        // MARK: - Properties

        typealias Input = Int
        typealias Failure = Never

        // MARK: - Subscription

        func receive(subscription: Subscription) {
            subscription.request(.max(1))
        }

        // MARK: - Receive Value(s)

        func receive(_ input: Int) -> Subscribers.Demand {
            print("Received value", input)
            return .unlimited
        }

        // MARK: - Completion

        func receive(completion: Subscribers.Completion<Never>) {
            print("Received completion", completion)
        }
    }

    let subscriber = IntSubscriber()
    publisher.subscribe(subscriber)
}

//: [Next](@next)
