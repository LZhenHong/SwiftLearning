import UIKit

// Notice how the closure has no external names for the parameters.
var multipleClosure: (Int, Int) -> Int
multipleClosure = {
    $0 * $1
}
let result = multipleClosure(4, 2)

func operateOnNumbers(_ a: Int, _ b: Int, operation: (Int, Int) -> Int) -> Int {
    let result = operation(a, b)
    print(result)
    return result
}
operateOnNumbers(4, 2, operation: multipleClosure)
// It can only be done when the closure is the final parameter passed to a function.
operateOnNumbers(4, 2) {
    $0 + $1
}
operateOnNumbers(4, 2, operation: +)

// Void is actually just a typealias for ().
let voidClosure: () -> Void = {
    print("Swift Apprentice is awesome!")
}
voidClosure()

var counter = 0
let incrementCounter = {
    counter += 1
}
incrementCounter()
counter

func countingClosure() -> (() -> Int) {
    var counter = 0
    let incrementCounter: () -> Int = {
        counter += 1
        return counter
    }
    return incrementCounter
}
let counter1 = countingClosure()
let counter2 = countingClosure()
counter1()
counter2()
counter1()
counter1()
counter2()

let names = ["ZZZZZZ", "BB", "A", "CCCC", "EEEEE"]
names.sorted {
    $0.count > $1.count
}

let values = [1, 2, 3, 4, 5, 6]
values.forEach {
    print("\($0): \($0 * $0)")
}

var prices = [1.4, 10, 4.99, 2.30, 8.19]
let largePrices = prices.filter {
    $0 > 5
}
print(largePrices)

let largePrice = prices.first {
    $0 > 5
}
print(largePrice as Any)

let salePrices = prices.map {
    $0 * 0.9
}
print(salePrices)

let userInput = ["0", "11", "haha", "42"]
let numbers1 = userInput.map {
    Int($0)
}
print(numbers1)

let numbers2 = userInput.compactMap {
    Int($0)
}
print(numbers2)

let sum = prices.reduce(0) {
    $0 + $1
}
print(sum)

let stock = [1.5: 5, 10: 2, 4.99: 20, 2.30: 5, 8.19: 30]
let stockSum = stock.reduce(0) {
    $0 + $1.key * Double($1.value)
}
print(stockSum)

let farmAnimals = ["🐎": 5, "🐄": 10, "🐑": 50, "🐶": 1]
let allAnimals = farmAnimals.reduce(into: []) {
    (result, this: (key: String, value: Int)) in
    for _ in 0..<this.value {
        result.append(this.key)
    }
}
print(allAnimals)

let removeFirst = prices.dropFirst()
let removeFirstTwo = prices.dropFirst(2)

let removeLast = prices.dropLast()
let removeLastTwo = prices.dropLast(2)

let firstTwo = prices.prefix(2)
let lastTwo = prices.suffix(2)

prices.removeAll() {
    $0 > 2
}
prices.removeAll()

// Lazy collection
func isPrime(_ number: Int) -> Bool {
    if number == 1 {
        return false
    }
    if number == 2 || number == 3 {
        return true
    }
    for i in 2...Int(Double(number).squareRoot()) {
        if number % i == 0 {
            return false
        }
    }
    return true
}
let primes = (1...).lazy.filter {
    isPrime($0)
}.prefix(10)
// The sequence has not been generated at all. No primes have been checked. It is only on the second statement, the primes.forEach that the sequence is evaluated and the ﬁrst ten prime numbers are printed out.
primes.forEach {
    print($0)
}

// ----- Mini-exercises -----
let exNames = ["Ali", "Bob", "Cat", "Dog", "Eden", "Frank", "Gina"]
let allNames = exNames.reduce("") {
    $0 + $1
}
print(allNames)

exNames.filter {
    $0.count > 4
}.reduce("") {
    $0 + $1
}

let namesAndAges = ["Ali": 24, "Bob": 30, "Cat": 12, "Dog": 8, "Eden": 25, "Frank": 48, "Gina": 33]
let filterNames = namesAndAges.filter {
    $0.value < 18
}
filterNames


let exAges = namesAndAges.filter {
    $0.value >= 18
}.map {
    $0.value
}
exAges

// ----- Challenges -----
func repeatTask(times: Int, task: () -> Void) {
    for _ in 0..<times {
        task()
    }
}
repeatTask(times: 10) {
    print("Swift Apprentice is a great book!")
}

func mathSum(length: Int, series: (Int) -> (Int)) -> Int {
    return (1...length).reduce(0) {
        $0 + series($1)
    }
}
mathSum(length: 10) {
    $0 * $0
}

let appRating = [
    "Calendar Pro": [1, 5, 5, 4, 2, 1, 5, 4],
    "The Messenger": [5, 4, 2, 5, 4, 1, 1, 2],
    "Socialise": [2, 1, 2, 2, 1, 2, 4, 2]
]
var averageRatings: [String: Double] = [:]
appRating.forEach {
    let sum = $0.value.reduce(0, +)
    averageRatings[$0.key] = Double(sum) / Double($0.value.count)
}
averageRatings

averageRatings.filter {
    $0.value > 3
}.map {
    $0.key
}
