import UIKit

// Properties hold values that you can get and set, while methods perform work.

struct SimpleDate {
    static let months = ["January", "February", "March", "April", "May", "June", "July", "August", "September", "October", "November", "December"]
    
    var month: String
    var day: Int
    
    var monthsUntilWinterBreakProperty: Int {
        get {
            Self.months.firstIndex(of: "December")! - Self.months.firstIndex(of: month)!
        }
    }
    
    init() {
        month = "January"
        day = 1
    }
    
    init(month: String, day: Int) {
        self.month = month
        self.day = day
    }
    
    func monthsUntilWinterBreak() -> Int {
        Self.months.firstIndex(of: "December")! - Self.months.firstIndex(of: month)!
    }
    
    // By marking a method as mutating, you’re also telling the Swift compiler this method must not be called on constants.
    mutating func advance() {
        day += 1
        if day > 31 {
            day -= 31
            guard var monthIndex = Self.months.firstIndex(of: month) else {
                return
            }
            monthIndex = (monthIndex + 1) % Self.months.count
            month = Self.months[monthIndex]
        }
    }
}
var date = SimpleDate(month: "December", day: 31)
date.advance()
date.month
date.day
date.monthsUntilWinterBreak()

let valentinesDay = SimpleDate(month: "February", day: 14)
valentinesDay.month
valentinesDay.day

// You can group related functions together as type methods in a structure. The structure is said to act as a namespace.

struct Math {
    static func factorial(of number: Int) -> Int {
        (1...number).reduce(1, *)
    }
    
    static func triangle(of number: Int) -> Int {
        (1...number).reduce(0, *)
    }
}
Math.factorial(of: 6)
Math.triangle(of: 7)

// In an extension, you cannot add stored properties to an existing structure because that would change the size and memory layout of the structure and break existing code.
extension Math {
    static func primeFactors(of value: Int) -> [Int] {
        var remainingValue = value
        var testFactor = 2
        var primes: [Int] = []
        while testFactor * testFactor <= remainingValue {
            if remainingValue % testFactor == 0 {
                primes.append(testFactor)
                remainingValue /= testFactor
            } else {
                testFactor += 1
            }
        }
        if remainingValue > 1 {
            primes.append(remainingValue)
        }
        return primes
    }
}
Math.primeFactors(of: 81)

extension Math {
    static func isEven(_ number: Int) -> Bool {
        number % 2 == 0
    }
    
    static func isOdd(_ number: Int) -> Bool {
        !isEven(number)
    }
}

extension Int {
    var isEven: Bool {
        self % 2 == 0
    }
    var isOdd: Bool {
        self % 2 != 0
    }
}
