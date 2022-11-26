import UIKit

// 值类型 VS 引用类型

// In Swift, you should try to make your function calls read like a sentence.
func printMyName() {
    print("My name is eden.")
}
printMyName()

func printMultipleOfFive(val: Int) {
    print("\(val) * 5 = \(val * 5)")
}
printMultipleOfFive(val: 10)

// You can make this even clearer by giving a parameter a different external name.
// The idea behind this is to allow you to have a function call be readable in a sentence like manner, but still have an expressive name within the function itself.
// @param: (and) external name
// @param: (value) internal name
func printMultipleOf(_ multiplier: Int, and value: Int) {
    print("\(multiplier) * \(value) = \(multiplier * value)")
}
printMultipleOf(4, and: 2)

func printMultipleOf(_ multiplier: Int, _ value: Int = 1) {
    print("\(multiplier) * \(value) = \(multiplier * value)")
}
printMultipleOf(4)

func multiply(_ number: Int, by multiplier: Int) -> Int {
    return number * multiplier
}
let result = multiply(4, by: 2)

func multiplyAndDivide(_ number: Int, by factor: Int) -> (product: Int, quotient: Int) {
    // If the function had more lines of code in it, then you wouldn’t be able to do this.
    (number * factor, number / factor)
}
let results = multiplyAndDivide(4, by: 2)
let product = results.product
let quotient = results.quotient

// Function parameters are constants by default, which means they can’t be modiﬁed.
// The value goes in to the function and comes back out again, thus the keyword inout.
func incrementAndPrint(_ value: inout Int) {
    value += 1
    print(value)
}
var number = 5
incrementAndPrint(&number)

// Overloading: lets you define similar functions using a single name.
func getValue() -> Int {
    25
}

func getValue() -> String {
    "Eden"
}

let valueInt: Int = getValue()
let valueString: String = getValue()
// When only the return type is overloaded, as in the above example, you loose type inference and so is not recommended.

// ----- Mini-exercises -----
func printFullName(firstName: String, lastName: String) {
    print(firstName + " " + lastName)
}

func printFullName(_ firstName: String, _ lastName: String) {
    print(firstName + " " + lastName)
}

func calculateFullName(firstName: String, lastName: String) -> String {
    firstName + " " + lastName
}
let fullName: String = calculateFullName(firstName: "liu", lastName: "eden")

func calculateFullName(firstName: String, lastName: String) -> (fullName: String, nameLength: Int) {
    (firstName + " " + lastName, (firstName + " " + lastName).count)
}

// 一等公民：函数
func add(_ a: Int, _ b: Int) -> Int {
    a + b
}
var function = add
function(4, 2)

func subtract(_ a: Int, _ b: Int) -> Int {
    a - b
}
function = subtract
function(4, 2)

func printResult(_ function: (Int, Int) -> Int, _ a: Int, _ b: Int) {
    let result = function(a, b)
    print(result)
}
printResult(add, 4, 2)
printResult(subtract, 4, 2)

// It’s useful because by the compiler knowing that the function won’t ever return, it can make certain optimizations when generating the code to call the function.
func infiniteLoop() -> Never {
    while true { }
}

/// Calculates the average of three values
/// - Parameters:
///     - a: The first value
///     - b: The second value
///     - c: The third value
/// - Returns: The average of the three values.
func calculateAverage(of a: Double, and b: Double, and c: Double) -> Double {
    let total = a + b + c
    let average = total / 3
    return average
}
calculateAverage(of: 1, and: 3, and: 5)

// ----- Challenge -----
for index in stride(from: 10.0, through: 9.0, by: -0.1) {
    print(index)
}

func isNumberDivisible(_ number: Int, by divisor: Int) -> Bool {
    (number % divisor) == 0
}

func isPrime(_ number: Int) -> Bool {
    guard number >= 0 else {
        return false
    }
    let half = Int(Double(number).squareRoot())
    for index in 2...half {
        if isNumberDivisible(number, by: index) {
            return false
        }
    }
    return true
}
isPrime(6)
isPrime(13)
isPrime(8893)

func fibonacci(_ number: Int) -> Int {
    if number < 0 {
        return 0
    } else if number <= 2 {
        return 1
    }
    return fibonacci(number - 1) + fibonacci(number - 2)
}
fibonacci(1)
fibonacci(2)
fibonacci(3)
fibonacci(4)
fibonacci(5)
fibonacci(10)
