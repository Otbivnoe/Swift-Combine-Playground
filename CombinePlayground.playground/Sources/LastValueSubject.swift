import Combine
import Foundation

public class LastValueSubject<Output, Failure> : Subject where Failure : Error {

//    private var demand: Subscribers.Demand = .
    private var lastValue: Output?
    private var subscriber: AnySubscriber<Output, Failure>?

    public init() {}

    public func send(_ value: Output) {
        self.lastValue = value
        self.subscriber?.receive(value)
    }

    public func send(completion: Subscribers.Completion<Failure>) {
        self.subscriber?.receive(completion: completion)
    }

    public func receive<S>(subscriber: S) where S : Subscriber, LastValueSubject.Failure == S.Failure, LastValueSubject.Output == S.Input {

        self.subscriber = subscriber.eraseToAnySubscriber()

        if let value = lastValue {
            self.subscriber?.receive(value)
        }
    }
}
