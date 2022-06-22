//: [Previous](@previous)

import Foundation
import Combine

example(of: "Dynamically adjusting demand") {

    final class IntSubscriber: Subscriber {

        // MARK: - Input & Failure

        typealias Input = Int
        typealias Failure = Never

        // MARK: - Subscription

        func receive(subscription: Subscription) {
            subscription.request(.max(2))
        }

        // MARK: - Demand (Receive)

        func receive(_ input: Int) -> Subscribers.Demand {
            print("Received value", input)

            switch input {
                case 1: return .max(2)
                case 3: return .max(1)
                default: return .none
            }
        }

        // MARK: - Complete

        func receive(completion: Subscribers.Completion<Never>) {
            print("Received completion", completion)
        }
    }

    let subscriber = IntSubscriber()

    // MARK: - Subject

    let subject = PassthroughSubject<Int, Never>()

    // MARK: - Subject Subscription

    subject.subscribe(subscriber)

    subject.send(1)
    subject.send(2)
    subject.send(3)
    subject.send(4)
    subject.send(5)
    subject.send(6)
}

//: [Next](@next)
