import UIKit

// Optionals：为了解决通过哨兵值来判断值是否有效，不需要给一些值赋予特别的含义
// A value or nil, that's not a question.

// If you’re handling a non-optional type, then you’re guaranteed to have a value and don’t need to worry about a sentinel value with special meaning.
// If you are using an optional type, then you know you must handle the nil case. It removes the ambiguity introduced by using sentinel values.

// Optional types can never be inferred from initialization values, as those values are of a regular, non-optional type, or nil, which can be used with any optional type.
var errorCode: Int?
errorCode = 100
errorCode = nil

// ----- Mini-exercises -----
var myFavoriteSong: String?
myFavoriteSong = nil

let parsedInt = Int("10")

var result: Int? = 30
print(result as Any)

var authorName: String? = "Matt Galloway"
var authorAge: Int? = 30
// Force unwrapping is only appropriate when an optional is guaranteed contain a value.
var unwrappedAuthorName = authorName!
print("Author is \(unwrappedAuthorName)")

// Optional binding
if let unwrappedAuthorName = authorName {
    print("Author is \(unwrappedAuthorName)")
} else {
    print("No author.")
}

if let authorName = authorName {
    print("Author is \(authorName)")
} else {
    print("No author.")
}

// This code unwraps two values. It will only execute the if part of the statement when both optionals contain a value.
if let authorName = authorName, let authorAge = authorAge {
    print("The author is \(authorName) who is \(authorAge) years old.")
} else {
    print("No author or no age.")
}

if let authorName = authorName, let authorAge = authorAge, authorAge >= 40 {
    print("The author is \(authorName) who is \(authorAge) years old.")
} else {
    print("No author or no age or age less than 40.")
}

// ----- Mini-exercises -----
if let myFavoriteSong = myFavoriteSong {
    print("My favorite song is \(myFavoriteSong)")
} else {
    print("I don't have a favorite song.")
}

// guard
func guardMyCastle(name: String?) {
    guard let castleName = name else {
        print("No castle!")
        return
    }
    print("You castle called \(castleName) was guarded!")
}

func calculateNumberOfSides(shape: String) -> Int? {
    switch shape {
    case "Triangle":
        return 3
    case "Square":
        return 4
    case "Rectangle":
        return 4
    case "Pentagon":
        return 5
    case "Hexagon":
        return 6
    default:
        return nil
    }
}

func maybePrintSides(shape: String) {
    guard let sides = calculateNumberOfSides(shape: shape) else {
        print("I don't know the number of sides for \(shape).")
        return
    }
    print("A \(shape) has \(sides) sides.")
}

// Nil coalescing
var optionalInt: Int? = 10
var mustHaveResult = optionalInt ?? 0

// ----- Challenges -----
var name: String? = "Ray"
// var age: Int = nil // Error happens
let distance: Float = 26.7
var middleName: String? = nil

func divideIfWhole(_ number: Int, by divisor: Int) -> Int? {
    let remainer = number % divisor
    guard remainer == 0 else {
        return nil
    }
    return number / divisor
}

func printCanBeDividedIfWhole(number: Int, divisor: Int) {
    guard let times = divideIfWhole(number, by: divisor) else {
        print("Not divisible.")
        return
    }
    print("Yep, it divides \(times) times.")
}
printCanBeDividedIfWhole(number: 10, divisor: 2)
printCanBeDividedIfWhole(number: 10, divisor: 3)

let number: Int??? = 10
print(number!!!)
