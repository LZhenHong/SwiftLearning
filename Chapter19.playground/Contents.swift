import UIKit

// unary binary ternary
// 一元运算符: postfix prefix
// 二元运算符: infix
// 三元运算符

precedencegroup ExponentiationPrecedence {
    associativity: right
    higherThan: MultiplicationPrecedence
}

infix operator **: ExponentiationPrecedence

func **<T: BinaryInteger>(base: T, power: Int) -> T {
    precondition(power >= 2)
    var result = base
    for _ in 2...power {
        result *= base
    }
    return result
}

func **(base: String, power: Int) -> String {
    precondition(power >= 2)
    var result = base
    for _ in 2...power {
        result += base
    }
    return result
}

infix operator **=

func **=<T: BinaryInteger>(lhs: inout T, rhs: Int) {
    lhs = lhs ** rhs
}

func **=(lhs: inout String, rhs: Int) {
    lhs = lhs ** rhs
}

let result = 2 ** 2

var number = 2
number **= 2

let baseString = "abc"
let times = 5
var multipliedString = baseString ** times
multipliedString **= times

// The setter is optional, so the subscript can be either read-write or read-only.
class Person {
    let name: String
    let age: Int
    
    init(name: String, age: Int) {
        self.name = name
        self.age = age
    }
}

extension Person {
    subscript(key: String) -> String? {
        switch key {
        case "name":
            return name
        case "age":
            return "\(age)"
        default:
            return nil
        }
    }
}

let me = Person(name: "Cosmin", age: 33)
me["name"]
me["age"]
me["gender"]

class File {
    let name: String
    
    init(name: String) {
        self.name = name
    }
    
    static subscript(key: String) -> String {
        switch key {
        case "path":
            return "Custom path"
        default:
            return "Default path"
        }
    }
}
File["path"]
File["PATH"]

// Mark Instrument as @dynamicMemberLookup to enable dot syntax for its subscripts.
// While you can use @dynamicMemberLookup for other purposes, its main purpose is to support interacting with dynamic languages like Python or Ruby.
@dynamicMemberLookup
class Instrument {
    let brand: String
    let year: Int
    private let details: [String: String]
    
    init(brand: String, year: Int, details: [String: String]) {
        self.brand = brand
        self.year = year
        self.details = details
    }
    
    // Conform Instrument to @dynamicMemberLookup by implementing subscript(dynamicMember:)
    subscript(dynamicMember key: String) -> String {
        switch key {
        case "info":
            return "\(brand) made in \(year)."
        default:
            return details[key] ?? ""
        }
    }
}
let instrument = Instrument(brand: "Roland", year: 2019,
                            details: ["type": "acoustic", "pitch": "C"])
instrument.info
instrument.pitch
instrument.brand
instrument.year

class Guitar: Instrument {}
let guitar = Guitar(brand: "Fender", year: 2019,
                    details: ["type": "electric", "pitch": "C"])
guitar.info

@dynamicMemberLookup
class Folder {
    let name: String
    
    init(name: String) {
        self.name = name
    }
    
    class subscript(dynamicMember key: String) -> String {
        switch key {
        case "path":
            return "Custom Path"
        default:
            return "Default Path"
        }
    }
}
Folder.path
Folder.PATH

// KeyPath
class Tutorial {
    let title: String
    let author: Person
    let details: (type: String, category: String)
    
    init(title: String, author: Person, details: (type: String, category: String)) {
        self.title = title
        self.author = author
        self.details = details
    }
}

let tutorial = Tutorial(title: "Object Oriented Programming in Swift", author: me, details: (type: "Swift", category: "iOS"))

let title = \Tutorial.title
let tutorialTitle = tutorial[keyPath: title]

let authorName = \Tutorial.author.name
var tutorialAuthor = tutorial[keyPath: authorName]

let type = \Tutorial.details.type
let tutorialType = tutorial[keyPath: type]

let category = \Tutorial.details.category
let tutorialCategory = tutorial[keyPath: category]

let authorPath = \Tutorial.author
let authorNamePath = authorPath.appending(path: \.name)
tutorialAuthor = tutorial[keyPath: authorNamePath]

class Jukebox {
    var song: String
    
    init(song: String) {
        self.song = song
    }
}
let jukebox = Jukebox(song: "Nothing Else Matters")
let song = \Jukebox.song
jukebox[keyPath: song] = "Stairway to Heaven"

struct Point {
    let x, y: Int
}

@dynamicMemberLookup
struct Circle {
    let center: Point
    let radius: Int
    
    subscript(dynamicMember keyPath: KeyPath<Point, Int>) -> Int {
        center[keyPath: keyPath]
    }
}
let center = Point(x: 1, y: 2)
let circle = Circle(center: center, radius: 1)
circle.x
circle.y
