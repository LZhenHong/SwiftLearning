import UIKit

let restaurantLocation = (2, 4)
let restaurantRange = 2.5

let otherRestaurantLocation = (7, 8)
let otherRestaurantRange = 1.5

func distance(from source: (x: Int, y: Int), to target: (x: Int, y: Int)) -> Double {
    let distanceX = Double(source.x - target.x)
    let distanceY = Double(source.y - target.y)
    return (distanceX * distanceX + distanceY * distanceY).squareRoot()
}

func isInDeliveryRange(location: (x: Int, y: Int)) -> Bool {
    let deliveryDistance = distance(from: location, to: restaurantLocation)
    let otherDeliveryDistance = distance(from: location, to: otherRestaurantLocation)
    return deliveryDistance <= restaurantRange || otherDeliveryDistance <= otherRestaurantRange
}

struct Location {
    let x: Int
    let y: Int
}
// Initializers enforce that all properties are set before you start using them. This is one of the key safety features of Swift.
let storeLocation = Location(x: 2, y: 4)

func distance(from sourceLocation: Location, to targetLocation: Location) -> Double {
    let xDistance = sourceLocation.x - targetLocation.x
    let yDistance = sourceLocation.y - targetLocation.y
    let distance = (xDistance * xDistance) + (yDistance * yDistance)
    return Double(distance).squareRoot()
}

struct DeliveryArea: CustomStringConvertible {
    let center: Location
    var radius: Double
    
    var description: String {
        "Area with center: (x: \(center.x), y: \(center.y)), radius: \(radius)"
    }
    
    func contains(_ location: Location) -> Bool {
        distance(from: center, to: location) <= radius
    }
    
    func overlaps(with otherArea: DeliveryArea) -> Bool {
        distance(from: center, to: otherArea.center) <= radius + otherArea.radius
    }
}
var storeArea = DeliveryArea(center: storeLocation, radius: 4)

struct PizzaOrder {
    let toppings: String
    let size: Int
}

print(storeArea.radius)
print(storeArea.center.x)
storeArea.radius = 250

//func isInDeliveryRange(location: Location) -> Bool {
//    let storeLocation = storeArea.center
//    let deliveryDistance = distance(from: (location.x, location.y), to: (storeLocation.x, storeLocation.y))
//    return deliveryDistance <= storeArea.radius
//}

let areas = [
    DeliveryArea(center: Location(x: 2, y: 4), radius: 2.5),
    DeliveryArea(center: Location(x: 9, y: 7), radius: 4.5)
]

func isInDeliveryRange(_ location: Location) -> Bool {
    for area in areas {
        let distanceToStore = distance(from: (area.center.x, area.center.y), to: (location.x, location.y))
        if distanceToStore <= area.radius {
            return true
        }
    }
    return false
}
let customerLocation1 = Location(x: 8, y: 1)
let customerLocation2 = Location(x: 5, y: 5)

print(isInDeliveryRange(customerLocation1))
print(isInDeliveryRange(customerLocation2))

let area = DeliveryArea(center: Location(x: 5, y: 5), radius: 4.5)
let customerLocation = Location(x: 2, y: 2)
area.contains(customerLocation)

// Struct as value types
var area1 = DeliveryArea(center: Location(x: 2, y: 4), radius: 2.5)
var area2 = area1
print(area1.radius)
print(area2.radius)

area1.radius = 4
print(area1.radius)
print(area2.radius)

print(area1)
print(area2)

// The Int type is also a structure.

// ----- Challenges -----

struct Tshirt {
    let size: Int
    let color: String
    let materials: [String]
}

struct Ship {
    let origin: Location
    let direction: String
    let length: Int
}
