import UIKit

protocol Vehicle {
    func accelerate()
    func stop()
}

// A protocol can be adopted by a class, struct or enum — and when another type adopts a protocol, it’s required to implement the methods and properties deﬁned in the protocol.

class Unicycle: Vehicle {
    var peddling = false
    
    func accelerate() {
        peddling = true
    }
    
    func stop() {
        peddling = false
    }
}

enum Direction {
    case left
    case right
}

protocol DirectionalVehicle {
    func accelerate()
    func stop()
    func turn(_ direction: Direction)
    func description() -> String
}

// When defining properties in a protocol, you must explicitly mark them as get or get set.
// Even if the property has only a get requirement, you’re still allowed to implement it as a stored property or a read-write computed property, as the requirements in the protocol are only minimum requirements.
protocol VehicleProperties {
    var weight: Int { get }
    var name: String { get set }
}

protocol Account {
    var value: Double { get set }
    init(initialAmount: Double)
    init?(transferAccount: Account)
}

class BitcoinAccount: Account {
    var value: Double
    
    required init(initialAmount: Double) {
        value = initialAmount
    }
    
    required init?(transferAccount: Account) {
        guard transferAccount.value > 0 else {
            return nil
        }
        value = transferAccount.value
    }
}

var accountType: Account.Type = BitcoinAccount.self
let account = accountType.init(initialAmount: 30.0)
let transferAccount = accountType.init(transferAccount: account)!

protocol WheeledVehicle: Vehicle {
    var numbersOfWheels: Int { get }
    var wheelSize: Double { get set }
}

protocol Area {
    var area: Double { get }
}

struct Square: Area {
    var area: Double {
        return 1
    }
}

struct Triangle: Area {
    var area: Double {
        return 1
    }
}

struct Circle: Area {
    var area: Double {
        return 1
    }
}

let shapes: [Area] = [Square(), Triangle(), Circle()]
let areas: [Double] = shapes.map {
    $0.area
}

/*
Protocols don’t care how you implement their requirements, as long as you implement them. Your choices for implementing a get requirement are:
 
 • A constant stored property.
 • A variable stored property.
 • A read-only computed property.
 • A read-write computed property.
 
 Your choices for implementing both a get and a set property are limited to a variable stored property or a read-write computed property.
 */

class Bike: WheeledVehicle {
    let numbersOfWheels = 2
    var wheelSize = 16.0
    
    var peddling = false
    var brakesApplied = false
    
    func accelerate() {
        peddling = true
        brakesApplied = false
    }
    
    func stop() {
        peddling = false
        brakesApplied = true
    }
}

// Note that this prevents you from using the protocol as a simple variable type, because the compiler doesn’t know what WeightType will be ahead of time.
protocol WeightCalculatable {
    associatedtype WeightType
    var weight: WeightType { get }
}

class HeavyThing: WeightCalculatable {
    var weight: Int { 100 }
}

class LightThing: WeightCalculatable {
    typealias WeightType = Double
    
    var weight: Double { 0.0025 }
}

protocol Wheeled {
    var numbersOfWheels: Int { get }
    var wheelSize: Double { get set }
}

class NewBike: Vehicle, Wheeled {
    let numbersOfWheels: Int = 2
    var wheelSize: Double = 2.0
    
    func accelerate() {
        print("Bike accelerate")
    }
    
    func stop() {
        print("Bike stop")
    }
}

func roundAndRound(transportation: Vehicle & Wheeled) {
    transportation.stop()
    print("The brakes are being applied to \(transportation.numbersOfWheels) wheels.")
}
roundAndRound(transportation: NewBike())

protocol Reflective {
    var typeName: String { get }
}

extension String: Reflective {
    var typeName: String {
        "I'm a String"
    }
}

class AnotherBike: Wheeled {
    var peddling = false
    let numbersOfWheels = 2
    var wheelSize = 16.0
}

extension AnotherBike: Vehicle {
    func accelerate() {
        peddling = true
    }
    
    func stop() {
        peddling = false
    }
}

//protocol Named {
protocol Named: AnyObject {
    var name: String { get set }
}

class ClassyName: Named {
    var name: String

    init(name: String) {
        self.name = name
    }
}

//struct StructyName: Named {
//    var name: String
//}

var named: Named = ClassyName(name: "Classy")
var copy = named

named.name = "Still Classy"
named.name
copy.name

//named = StructyName(name: "Structy")
//copy = named
//
//named.name = "Still Structy?"
//named.name
//copy.name

class Record {
    var wins: Int
    var losses: Int
    
    init(wins: Int, losses: Int) {
        self.wins = wins
        self.losses = losses
    }
}

// Equatable
extension Record: Equatable {
    static func ==(lhs: Record, rhs: Record) -> Bool {
        lhs.wins == rhs.wins && lhs.losses == rhs.losses
    }
}

// Comparable
extension Record: Comparable {
    static func <(lhs: Record, rhs: Record) -> Bool {
        if lhs.wins == rhs.wins {
            return lhs.wins > rhs.wins
        }
        return lhs.wins < rhs.wins
    }
}

let recordA = Record(wins: 10, losses: 5)
let recordB = Record(wins: 10, losses: 5)
recordA == recordB

let teamA = Record(wins: 14, losses: 11)
let teamB = Record(wins: 23, losses: 8)
let teamC = Record(wins: 25, losses: 9)
var leagueRecors = [teamA, teamB, teamC]
leagueRecors.sort()
leagueRecors.max()
leagueRecors.min()
leagueRecors.starts(with: [teamA, teamC])
leagueRecors.contains(teamA)

// For value types (structs, enums) the compiler will generate Equatable and Hashable conformance for you automatically, but you will need to do it yourself for reference (class) types.
// Values that are considered equal by == must also have the same hash value. Just make sure that everything that you include in the == comparison is also combined using the hasher.

class Student {
    let email: String
    let firstName: String
    let lastName: String
    
    init(email: String, firstName: String, lastName: String) {
        self.email = email
        self.firstName = firstName
        self.lastName = lastName
    }
}

extension Student: Hashable {
    static func ==(lhs: Student, rhs: Student) -> Bool {
        lhs.email == rhs.email && lhs.firstName == rhs.firstName && lhs.lastName == rhs.lastName
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(email)
        hasher.combine(firstName)
        hasher.combine(lastName)
    }
}

extension Student: Identifiable {
    var id: String {
        email
    }
}

let john = Student(email: "johnny.appleseed@apple.com", firstName: "Johnny", lastName: "Appleseed")
let lockerMap = [john: "14B"]

// CustomStringConvertible
extension Student: CustomStringConvertible {
    var description: String {
        "\(firstName) \(lastName)"
    }
}
print(john)
