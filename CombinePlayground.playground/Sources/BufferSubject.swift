import Combine
import Foundation

public class BufferSubject<Output, Failure> : Subject where Failure : Error {

    private var subscriber: AnySubscriber<Output, Failure>?

    private var values: [Output] = []
    private let maxValues: Int

    public init(maxValues: Int) {
        self.maxValues = maxValues
    }

    public func send(_ value: Output) {
        values.append(value)
        values.removeFirst(Swift.max(0, values.count - maxValues))
        
        self.subscriber?.receive(value)
    }

    public func send(completion: Subscribers.Completion<Failure>) {
        self.subscriber?.receive(completion: completion)
    }

    public func receive<S>(subscriber: S) where S : Subscriber, BufferSubject.Failure == S.Failure, BufferSubject.Output == S.Input {
        self.subscriber = subscriber.eraseToAnySubscriber()

        self.values.forEach { (value) in
            self.subscriber?.receive(value)
        }
    }
}
