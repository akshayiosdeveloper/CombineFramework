
import Foundation
import Combine

enum MyError :Error {
    case test
}
final class StringSubscriber: Subscriber {
    typealias Input = String
    
    typealias Failure = MyError
    func receive(subscription: Subscription) {
        subscription.request(.max(2))
    }
    func receive(_ input: String) -> Subscribers.Demand {
       // print("Received value",input)
        return input == "World" ? .max(1) : .none
    }
    func receive(completion: Subscribers.Completion<MyError>) {
      print("received completion",completion)
    }
}
let subscriber = StringSubscriber()

let passthroughSubject1 = PassthroughSubject<String,MyError>()
// attach subject with publisher
passthroughSubject1.subscribe(subscriber)
let subscription = passthroughSubject1.sink { completion in
    print("sink",completion)
    switch completion {
    case .finished:
        print("Done")
    case .failure(MyError.test):
         print("errpr")
    }
   
    
} receiveValue: { value in
    print("sink1",value)
}

passthroughSubject1.send("Akshay")
passthroughSubject1.send("Kumar")
passthroughSubject1.send("World")

//subscription.cancel()
//passthroughSubject1.send(completion: .finished)
passthroughSubject1.send(completion: .failure(MyError.test))
passthroughSubject1.send("ui")
