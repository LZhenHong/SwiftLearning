import UIKit

// An enumeration can have methods and computed properties, all while acting as a convenient state machine.

let months = ["January", "February", "March", "April", "May", "June", "July", "August", "September", "October", "November", "December"]

func semester(for month: String) -> String {
    switch month {
    case "August", "September", "October", "November", "December":
        return "Autumn"
    case "January", "February", "March", "April", "May":
        return "Spring"
    default:
        return "Not in the school year"
    }
}
semester(for: "April")

// The commonly accepted best practice is to start each member value with a lower case ﬁrst letter, just like a property.
enum Month: Int {
    case january = 1
    case february
    case march
    case april
    case may
    case june
    case july
    case august
    case september
    case october
    case november
    case december
    
    var semester: String {
        switch self {
        case .august, .september, .october, .november, .december:
            return "Autumn"
        case .january, .february, .march, .april, .may:
            return "Spring"
        case .june, .july:
            return "Summber"
        }
    }
    
    var monthsUntilWinterBreak: Int {
        Month.december.rawValue - rawValue
    }
    
    var monthsUntilSummberBreak: Int {
        if rawValue > Month.june.rawValue {
            return Month.june.rawValue - rawValue + 12
        } else {
            return Month.june.rawValue - rawValue
        }
    }
}

func semester(for month: Month) -> String {
    switch month {
    case .august, .september, .october, .november, .december:
        return "Autumn"
    case .january, .february, .march, .april, .may:
        return "Spring"
    case .june, .july:
        return "Summber"
    }
}

var month = Month.april
semester(for: month)
month = .september
semester(for: month)

month.semester

month = .april
month.monthsUntilWinterBreak

let fifthMonth = Month(rawValue: 5)

enum Icon: String {
    case music
    case sports
    case weather
    
    var filename: String {
        "\(rawValue).png"
    }
}
let icon = Icon.weather
icon.filename

enum Coin: Int {
    case penny = 1
    case nickel = 5
    case dime = 10
    case quarter = 25
}
let coin = Coin.quarter
coin.rawValue

// Associated values aren’t properties you can access freely.
enum WithdrawalResult {
    case success(newBalance: Int)
    case error(message: String)
}

var balance = 100
func withdraw(amount: Int) -> WithdrawalResult {
    if amount <= balance {
        balance -= amount
        return .success(newBalance: balance)
    } else {
        return .error(message: "Not enough money!")
    }
}
let result = withdraw(amount: 99)
switch result {
case .success(let newBalance):
    print("Your new balance is: \(newBalance)")
case .error(let message):
    print(message)
}

enum HTTPMethod {
    case get
    case post(body: String)
}

let request = HTTPMethod.post(body: "Hi")
guard case .post(let body) = request else {
    fatalError("No message was posted")
}
print(body)

enum TrafficLight {
    case red, yellow, green
}
let trafficLight = TrafficLight.red

enum Light {
    case on, off
}

enum Pet: CaseIterable {
    case cat, dog, bird, turtle, fish, hamster
}

for pet in Pet.allCases {
    print(pet)
}

enum Math {
    static func factorial(of number: Int) -> Int {
        (1...number).reduce(1, *)
    }
    
    static let e = 2.7183
}

let optionalNil: Int? = .none
optionalNil == nil
optionalNil == .none

// ----- Challenge -----
func calTotalCents(_ coins: [Coin]) -> Int {
    coins.reduce(0, {
        $0 + $1.rawValue
    })
}
let coinPurse: [Coin] = [.penny, .quarter, .nickel, .dime, .penny, .dime, .quarter]
calTotalCents(coinPurse)

enum Direction {
    case north
    case south
    case east
    case west
}
