import UIKit

struct Car {
    // stored properties
    let make: String
    let color: String
    var fuelTank: FuelTank
    // computed properties: no actual memory allocated
}

struct Contact {
    var fullName: String
    var emailAddress: String
    var relationship: String = "Friend"
}
var person = Contact(fullName: "Grace Murray", emailAddress: "grace@navy.mil")
let name = person.fullName
let email = person.emailAddress
person.fullName = "Grace Hooper"
let grace = person.fullName
let relationship = person.relationship

var boss = Contact(fullName: "Ray Wenderlich", emailAddress: "ray@raywenderlich.com", relationship: "Boss")

// Computed property must be defined as a variable, must also include a type.
struct TV {
    var height: Double
    var width: Double
    
    var diagonal: Int {
        get {
            let result = (height * height + width * width).squareRoot().rounded()
            return Int(result)
        }
        set {
            let ratioWidth = 16.0
            let ratioHeight = 9.0
            let ratioDiagonal = (ratioWidth * ratioWidth + ratioHeight * ratioHeight).squareRoot()
            height = Double(newValue) / ratioHeight * ratioDiagonal
            width = height * ratioWidth / ratioHeight
        }
    }
}
var tv = TV(height: 53.93, width: 95.87)
let size = tv.diagonal

tv.width = tv.height
let diagonal = tv.diagonal

tv.diagonal = 70
let height = tv.height
let width = tv.width

struct Level {
    static var highestLevel = 1
    let id: Int
    var boss: String
    // willSet and didSet observers are only available for stored properties.
    // willSet and didSet observers are not called when a property is set during initialization.
    var unlocked: Bool {
        didSet {
            if unlocked && id > Self.highestLevel {
                Self.highestLevel = id
            }
        }
    }
}
Level.highestLevel

struct LightBulb {
    static let maxCurrent = 40
    var isOn = false
    var current = 0 {
        willSet {
            if newValue > Self.maxCurrent {
                print("Current is too high, turning off to prevent burn out.")
                isOn = false
            }
        }
        didSet {
            if current > Self.maxCurrent {
                print("Current is too high, falling back to previous setting.")
                current = oldValue
            }
        }
    }
}

// A stored property can have a didSet and/or a willSet observer. A computed property has a getter and optionally a setter.

struct Circle {
    // The lazy property must be a variable
    lazy var pi = {
        ((4.0 * atan(1.0 / 5.0)) - atan(1.0 / 239.0)) * 4.0
    }()
    var radius = 0.0
    var circumference: Double {
        get {
            Double.pi * radius * 2
        }
    }
    init(radius: Double) {
        self.radius = radius
    }
}
var circle = Circle(radius: 5)
let circumference = circle.circumference

// ----- Challenges -----
struct FuelTank {
    var lowFuel = false
    var level: Double {
        didSet {
            level = max(0.0, min(level, 1.0))
            lowFuel = level < 0.1
        }
    }
}
