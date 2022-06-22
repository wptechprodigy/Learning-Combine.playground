//: [Previous](@previous)

import Foundation
import Combine

example(of: "PassthroughSubject") {

    // MARK: - Error

    enum MyError: Error {
        case test
    }

    final class StringSubscriber: Subscriber {

        // MARK: - Input & Error

        typealias Input = String
        typealias Failure = MyError

        // MARK: - Subscription

        func receive(subscription: Subscription) {
            subscription.request(.max(2))
        }

        // MARK: - Receive

        func receive(_ input: String) -> Subscribers.Demand {
            print("Received value", input)
            return input == "World" ? .max(1) : .none
        }

        // MARK: - Complete

        func receive(completion: Subscribers.Completion<MyError>) {
            print("Received completion", completion)
        }
    }

    // MARK: - Subscriber

    let subscriber = StringSubscriber()

    // MARK: - Subject

    /// A go-between to enable non-Combine imperative code
    /// to send values to Combine subscribers
    let subject = PassthroughSubject<String, MyError>()
    subject.subscribe(subscriber)

    // MARK: - Subscription

    let subscription = subject
        .sink { completion in
            print("Received completion (sink)", completion)
        } receiveValue: { value in
            print("Received value (sink)", value)
        }

    // MARK: - Publish Values on Demand

    subject.send("Hello")
    subject.send("World")

    // MARK: - Cancel

    subscription.cancel()

    subject.send("Still there?")

    // subject.send(completion: .failure(MyError.test))

    subject.send(completion: .finished)
    subject.send("How about another one?")
}

//: [Next](@next)
