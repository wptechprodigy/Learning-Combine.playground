//: [Previous](@previous)

import Foundation
import Combine

example(of: "async/await") {

    // MARK: - Subject

    let subject = CurrentValueSubject<Int, Never>(0)

    Task {
        for await element in subject.value {
            print("Element: \(element)")
        }

        print("Completed.")
    }

    // MARK: - Emit/Publish

    subject.send(1)
    subject.send(2)
    subject.send(3)

    // MARK: - Complete

    subject.send(completion: .finished)
}

//: [Next](@next)
