//: [Previous](@previous)

import Combine
import PlaygroundSupport

example("CurrentValueSubject") {
    let subject = CurrentValueSubject<String, Never>("🍏")

    subject.sink { print("First subscription received: \($0)") }
    subject.send("🍐")

    // При подписке получает не последнее, а initial значение
    subject.sink { print("Second subscription received: \($0)") }
    subject.send("🍌")
}

example("PassthroughSubject") {
    let subject = PassthroughSubject<Int, Never>()

    let _ = subject.sink(receiveCompletion: { (completion) in
        print("PassthroughSubject completion = \(completion)")
    }, receiveValue: { value in
        print("PassthroughSubject value = \(value)")
    })


    // subscriber.cancel() - only in SinkSubscriber
    // eraseToAnySubject()

    subject.send(1)
    subject.send(2)
    subject.send(3)
    subject.send(completion: .finished)
}

example("Custom subject: LastValueSubject") {
    let subject = LastValueSubject<String, Never>()

    subject.sink { print("First subscriber received: \($0)") }
    subject.send("🍐")
    subject.send("🍌")

    subject.sink { print("Second subscriber received: \($0)") }
}

example("Custom subject: BufferSubject") {
    let subject = BufferSubject<String, Never>(maxValues: 3)

    subject.sink { print("First subscriber received: \($0)") }
    subject.send("🍐")
    subject.send("🍌")
    subject.send("🍏")

    subject.sink { print("Second subscriber received: \($0)") }
}

//: [Next](@next)
