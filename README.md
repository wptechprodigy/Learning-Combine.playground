# Learning-Combine.playground

My journey on learning the Cobine framework using the Raywenderlich Combine Asynchronuous Programming with Swift book.

## What is the Combine Framework?

In Apple’s own words: 

> “The Combine framework provides a declarative approach for
how your app processes events. Rather than potentially implementing multiple delegate
callbacks or completion handler closures, you can create a single processing chain for a
given event source. Each part of the chain is a Combine operator that performs a distinct
action on the elements received from the previous step.”

## Introduction

In the introduction part, I learned the following concept in Combine:

 - Publisher, Subscription & Subscriber
 - Demand
 - Dynamically adjusting demand
 - PassthroughSubject & CurrentValueSubject (Some other kinds of Publishers called Subject)
 - Just
 - Future
 - How to create a custom Subscriber (Thus far - will be learning to create custom Publisher later)
 - Type erasure and so on

## Sample Custom Subcriber - Double Subcriber

```swift
import Combine

final class DoubleSubscriber: Subscriber {
    
    // Mark: Type & Error Definitions
    
    enum DoubleError: Error {
        case sampleError
    }
    
    typealias Input = Double
    typealias Failure = DoubleError
    
    // Mark: Subscribe
    
    func receive(subscription: Subscription) {
        subscription.request(.max(3))
    }
    
    // Mark: Demand
    
    func receive(_ input: Double) -> Subscribers.Demand {
        // Set the number of times to recive values from a publisher
        print("Received value", input)
        return .max(1)
    }
    
    // Mark: Complete
    
    func receive(completion: Subscribers.Completion<DoubleError>) {
        // Handle completion and error if there happens to be one
        print("Received completion", completion)
    }
}
```

#### Notes

I'll update the README as I progress with my learning

Thanks to the Team at Raywenderlich for the great resource
