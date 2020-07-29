import UIKit

// Swift wants to make sure you know what you’re doing and that you may end up losing data by performing the type conversion.

// In Swift, you can’t apply the operator to mixed types

// Number type
let hourlyRate: Double = 19.5
let hourlyWorked: Int = 10
let totalCost = hourlyRate * Double(hourlyWorked)

let typeInferredInt = 42
let typeInferredDouble = 3.14

let actuallyDouble = 3 as Double

// ----- Mini-exercises -----
let age1 = 42
let age2 = 21

let avg1 = Double(age1 + age2) / 2

// String & Character type
let characterA: Character = "a"
let characterDog = "🐶" as Character
let stringDog = "Dog"

var msg = "Hello" + "my name is "
let name = "Matt"
msg += name
let exclamationMark = "!" as Character
msg += String(exclamationMark)

// String interpolation: It’s simple to use, but offers no ability to customize the output.
var message = "Hello my name is \(name)!"

let oneThird = 1.0 / 3.0
let oneThirdLongString = "One third is \(oneThird) as a decimal."

let bigString = """
You can have a string
that contains multiple
lines
by
doing this.
"""
print(bigString)

// ----- Mini-exercises -----
let firstName = "liu"
let lastName = "zhenhong"
let fullName = firstName + " " + lastName
let myDetails = "Hello, my name is \(fullName)."

// Tuple type
let coordinates = (2, 3)
let x = coordinates.0
let y = coordinates.1

let coordinatesDouble = (2.1, 3.5)
let coordinatesMixed = (2.1, 3)

let coordinatesNamed = (x: 2, y: 3)
coordinatesNamed.x
coordinatesNamed.y

let coordinates3D = (x: 1, y: 2, z: 3)
let (x3, y3, z3) = coordinates3D
let (x4, y4, _) = coordinates3D

// ----- Mini-exercises -----
var weatherInfo = (year: 2020, month: 7, day: 29, averageTemperature: 35.5)
let (_, _, day, averageTemperature) = weatherInfo
weatherInfo.averageTemperature = 36.9

// More Number type
let numberInInt8 = -5 as Int8
let numberInInt16 = -5 as Int16
let numberInInt32 = -5 as Int32
let numberInInt64 = -5 as Int64
let numberInUInt8 = 5 as UInt8
let numberInUInt16 = 5 as UInt16
let numberInUInt32 = 5 as UInt32
let numberInUInt64 = 5 as UInt64

// Modern hardware has been optimized for Double, so it should be your go-to unless there is good reason to use a Float.
let a = 12 as Int16
let b = 255 as UInt8
let c = -10000 as Int32
let answer = Int(a) + Int(b) + Int(c)

// Type aliases
typealias Animal = String
let myPet: Animal = "Dog"

typealias Coordinate = (Int, Int)
let coordinatesTypeAlias: Coordinate = (2, 3)

// ----- Challenges -----
let coordinatesChallenge = (2, 3)
let namedCoordinate = (row: 1, column: 2)

let tuple = (100, 1.5, 10)
let val = tuple.1

let date = (day: 15, month: 8, year: 2015)
let month = date.month

let number = 10
let multiplier = 5
let summary = "\(number) multiplied by \(multiplier) equals \(number * multiplier)"

Double.pi
Float.pi
