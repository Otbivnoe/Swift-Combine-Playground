import Combine

// https://developer.apple.com/documentation/combine/publishers/empty
example("Empty") {
    let empty = Publishers.Empty<Never, Never>(completeImmediately: true)

    empty.sink(receiveCompletion: { (completion) in
        print("completion = \(completion)")
    }, receiveValue: { value in
        print("value = \(value)")
    })
}

// https://developer.apple.com/documentation/combine/publishers/fail
example("Fail") {
    let fail = Publishers.Fail<Never, PlaygroundError>(error: .error1)

    fail.sink(receiveCompletion: { (completion) in
        print("completion = \(completion)")
    }, receiveValue: { value in
        print("value = \(value)")
    })
}

// https://developer.apple.com/documentation/combine/publishers/just
example("Just") {
    let just = Publishers.Just<String>("🥥")

    just.sink(receiveCompletion: { (completion) in
        print("completion = \(completion)")
    }, receiveValue: { value in
        print("value = \(value)")
    })
}

// https://developer.apple.com/documentation/combine/publishers/once
example("Once") {
    let once = Publishers.Once<String, PlaygroundError>(.success("🍇"))

    once.sink(receiveCompletion: { completion in
        print("completion = \(completion)")
    }, receiveValue: { value in
        print("value = \(value)")
    })
}

// https://developer.apple.com/documentation/combine/publishers/optional
example("Optional") {
    let optional = Publishers.Optional<String, PlaygroundError>(.success(nil))

    optional.sink(receiveCompletion: { completion in
        print("completion = \(completion)")
    }, receiveValue: { value in
        print("value = \(value)")
    })
}

// https://developer.apple.com/documentation/combine/publishers/sequence
example("Sequence") {
    let sequence = Publishers.Sequence<[String], PlaygroundError>(sequence: ["🍓", "🍍"])

    sequence.sink(receiveCompletion: { (completion) in
        print("completion = \(completion)")
    }, receiveValue: { value in
        print("value = \(value)")
    })
}

// https://developer.apple.com/documentation/combine/publishers/deferred
example("Deferred") {
    let sequence = Publishers.Deferred<Publishers.Just<String>> {
        print("inside closure")
        // удобно, когда значение, которое хочешь отправить, нужно отложено посчитать
        return .init("🥥")
    }

    print("before `sink`")

    sequence.sink(receiveCompletion: { (completion) in
        print("completion = \(completion)")
    }, receiveValue: { value in
        print("value = \(value)")
    })
}

example("AnyPublisher") {
    let publisher = AnyPublisher<String, Never> { subscriber in
        subscriber.receive("1")
        subscriber.receive("2")
        subscriber.receive("3")
        subscriber.receive("4")
    }

    let subscriber = AnySubscriber <String, Never>(receiveSubscription: { subscription in
        print("subscription = \(subscription)")
    }, receiveValue: { value in
        print("value = \(value)")
        return .unlimited
    }, receiveCompletion: { completion in
        print("completion = \(completion)")
    })

    publisher.subscribe(subscriber)
}
