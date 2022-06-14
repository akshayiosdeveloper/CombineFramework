import Combine
import Foundation

var current = CurrentValueSubject<Int,Never>(10)
var passthrough = PassthroughSubject<Int,Never>()

current.send(11)
passthrough.send(11)
current.sink(receiveValue: {print($0)})
 passthrough.sink(receiveValue: {print($0)})
passthrough.send(16)
