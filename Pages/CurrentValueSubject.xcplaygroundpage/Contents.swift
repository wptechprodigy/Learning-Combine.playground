//: [Previous](@previous)

import Foundation
import Combine

/// CurrentValueSubject
/// Unlike a PassthroughSubject, the current value of a CurrentValueSubject
/// can be asked at any time.
example(of: "CurrentValueSubject") {

    // MARK: - Subscription Sets

    var subscriptions = Set<AnyCancellable>()

    // MARK: - Subject

    let subject = CurrentValueSubject<Int, Never>(0)

    // MARK: - Subscription & Receive

    subject
        .print()
        .sink { print($0) }
        .store(in: &subscriptions)

    subject
        .print()
        .sink(receiveValue: { print("Second subscription:", $0) })
        .store(in: &subscriptions)

    // MARK: - Send New Values

//    (1...5).forEach {
//        subject.send($0)
//    }

    subject.value = 2
    subject.value = 3
}

//: [Next](@next)
