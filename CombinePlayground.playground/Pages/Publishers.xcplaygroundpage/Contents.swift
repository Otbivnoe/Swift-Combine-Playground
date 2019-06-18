import Combine

let just = Publishers.Just<Int>(4)

just.sink(receiveCompletion: { (completion) in
    print("Publishers.Just completion = \(completion)")
}, receiveValue: { value in
    print("Publishers.Just value = \(value)")
})
