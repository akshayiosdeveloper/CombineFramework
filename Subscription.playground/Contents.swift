    // 2
    import Combine
    let publisher = (1...6).publisher
    final class IntSubscriberDemo: Subscriber {
        typealias Input = Int
        typealias Failure = Never
        func receive(subscription: Subscription) {
            //Creates a demand for the given maximum number of elements.
            // The maximum number of elements. Providing a negative value for this parameter results in a fatal error.
            subscription.request(.max(3))
        }
        func receive(_ input: Int) -> Subscribers.Demand {
            print("Received value",input)
            return .unlimited
            // indicating that the subscriber will not adjust its demand; .none is equivalent to .max(0).
        }
        func receive(completion: Subscribers.Completion<Never>) {
            print("Received completion",completion)
        }
    }
    
    let subscriber = IntSubscriberDemo()
    publisher.subscribe(subscriber)
    

