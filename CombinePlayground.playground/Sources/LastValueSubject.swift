import Combine
import Foundation

public class LastValueSubject<Output, Failure> : Subject where Failure : Error {

    private var lastValue: Output?
    private var subscribers: [AnySubscriber<Output, Failure>] = []

    public init() {}

    public func send(_ value: Output) {
        self.lastValue = value
        self.subscribers.forEach { $0.receive(value) }
    }

    public func send(completion: Subscribers.Completion<Failure>) {
        self.subscribers.forEach { $0.receive(completion: completion) }
        self.subscribers = []
    }

    public func receive<S>(subscriber: S) where S : Subscriber, LastValueSubject.Failure == S.Failure, LastValueSubject.Output == S.Input {
        self.subscribers.append(subscriber.eraseToAnySubscriber())

        if let value = lastValue {
            self.subscribers.forEach { $0.receive(value) }
        }
    }
}
