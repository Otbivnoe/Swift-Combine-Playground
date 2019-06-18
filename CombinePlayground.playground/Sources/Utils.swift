import Foundation

public func example(_ description: @autoclosure () -> String, block: () -> Void) {
    print("\n---Example: \(description())")
    block()
}
