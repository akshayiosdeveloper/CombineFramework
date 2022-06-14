import Combine
import Foundation

struct Uploader {
    enum State {
        case pending, uploading, finished
    }
    enum Error: Swift.Error {
        case uploadFailed
    }
    let subject = CurrentValueSubject<State,Error>(.pending)
    func startUpload() {
        subject.send(.uploading)
    }
    func finishUpload() {
        subject.value = .finished
        subject.send(completion: .finished)
    }
    func failedUpload() {
        subject.send(completion: .failure(.uploadFailed))
    }
}


let uploader = Uploader()
let anyCancellable = uploader.subject.sink { completion in
    switch completion {
    case .finished:
        print("Received finished")
    case .failure(let error):
        print("Received error:\(error)")
        
    }
} receiveValue: { state in
    print(state)
}

uploader.startUpload()
//uploader.finishUpload()
anyCancellable.cancel()
//uploader.startUpload()
