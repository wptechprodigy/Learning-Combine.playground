import UIKit
import Combine
//: ## Key points
//:  - Publishers transmit a sequence of values over time to one or more subscribers,
//: either synchronously or asynchronously.
//:  - A subscriber can subscribe to a publisher to receive values; however, the
//: subscriber’s input and failure types must match the publisher’s output and failure
//: types.
//:  - There are two built-in operators you can use to subscribe to publishers:
//: sink(\_:\_:) and assign(to:on:).
//:  - A subscriber may increase the demand for values each time it receives a value, but
//: it cannot decrease demand.
//:  - To free up resources and prevent unwanted side effects, cancel each subscription
//: when you’re done.
//:  - You can also store a subscription in an instance or collection of AnyCancellable
//: to receive automatic cancelation upon deinitialization.
//:  - You use a future to receive a single value asynchronously at a later time.
//:  - Subjects are publishers that enable outside callers to send multiple values
//: asynchronously to subscribers, with or without a starting value.
//:  - Type erasure prevents callers from being able to access additional details of the
//: underlying type.
//:  - Use the print() operator to log all publishing events to the console and see
//: what’s going on.
/// Publisher
example(of: "Publisher") {
    let myNotification = Notification.Name("MyNotification")
    _ = NotificationCenter.default
        .publisher(for: myNotification, object: nil)

    let center = NotificationCenter.default
    let observer = center.addObserver(
        forName: myNotification,
        object: nil,
        queue: nil) { notification in
            print("Notification received!!!")
        }

    center.post(name: myNotification, object: nil)
    center.removeObserver(observer)
}

/// Subscriber
example(of: "Subscriber") {
    let myNotification = Notification.Name("MyNotification")
    let center = NotificationCenter.default

    let publisher = center.publisher(for: myNotification, object: nil)

    let subscription = publisher
        .sink { _ in
        print("Notification received from a publisher!")
    }

    center.post(name: myNotification, object: nil)
    subscription.cancel()
}

/// assign(to:on:)
example(of: "assign(to:on:)") {
    class SomeObject {
        var value: String = "" {
            didSet {
                print(value)
            }
        }
    }

    let object = SomeObject()
    let publisher = ["Hello", "Combine!"].publisher

    _ = publisher
        .assign(to: \.value , on: object)
}

/// assign(to:)
example(of: "assign(to:)") {
    class SomeObject {
        @Published var value = 0
    }

    let object = SomeObject()

    object.$value
        .sink {
            print($0)
        }

    (0..<10).publisher
        .assign(to: &object.$value)
}

example(of: "Cancellable") {
    class MyObject {
        @Published var word: String = ""
        var subscriptions = Set<AnyCancellable>()

        init() {
            ["A", "B", "C"].publisher
                .assign(to: \.word, on: self)
                .store(in: &subscriptions)
        }
    }
}
