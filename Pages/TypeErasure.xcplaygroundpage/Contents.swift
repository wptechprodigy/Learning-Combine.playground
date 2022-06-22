//: [Previous](@previous)

import Foundation
import Combine

example(of: "Type Erasure") {

    // MARK: - Subscriptions

    var subscriptions = Set<AnyCancellable>()

    // MARK: - Subject

    let subject = PassthroughSubject<Int, Never>()

    // MARK: - Publisher

    let publisher = subject.eraseToAnyPublisher()

    publisher
        .print()
        .sink(receiveValue: { print($0) })
        .store(in: &subscriptions)

    subject.send(0)
}

//: [Next](@next)
