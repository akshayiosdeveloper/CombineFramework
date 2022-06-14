import Combine
import Foundation

public class TypeWithSubject {
    public let publisher: some Publisher = PassthroughSubject<Int,Never>()
}
public class TypeWithErasedSubject {
    public let publisher: some Publisher = PassthroughSubject<Int,Never>()
        .eraseToAnyPublisher()
}

// In another module:
let nonErased = TypeWithSubject()
if let subject = nonErased.publisher as? PassthroughSubject<Int,Never> {
    print("Successfully cast nonErased.publisher.")
}
let erased = TypeWithErasedSubject()
if let subject = erased.publisher as? PassthroughSubject<Int,Never> {
    print("Successfully cast erased.publisher.")
}


