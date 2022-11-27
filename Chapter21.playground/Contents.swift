import UIKit

let coordinate = (x: 1, y: 0, z: 0)
if (coordinate.y == 0) && (coordinate.z == 0) {
    print("Along the x-axis")
}

// Pattern Matching
if case (_, 0, 0) = coordinate {
    print("Along the x-axis")
}

func process(point: (x: Int, y: Int, z: Int)) -> String {
    if case (0, 0, 0) = point {
        return "At origin"
    }
    return "Not at origin"
}
let point = (x: 0, y: 0, z: 0)
let status = process(point: point)

func processGuardVersion(point: (x: Int, y: Int, z: Int)) -> String {
    guard case (0, 0, 0) = point else {
        return "Not at origin"
    }
    return "At origin"
}

func processSwitchVersion(point: (x: Int, y: Int, z: Int)) -> String {
    let closeRange = -2...2
    let midRange = -5...5
    switch point {
    case (0, 0, 0):
        return "At origin"
    case (closeRange, closeRange, closeRange):
        return "Very close to origin"
    case (midRange, midRange, midRange):
        return "Nearby origin"
    default:
        return "Not near origin"
    }
}
let switchPoint = (x: 15, y: 5, z: 3)
let switchStatus = processSwitchVersion(point: switchPoint)

func populationSize(peopleCount: Int) {
    let few = 0...5
    let serveral = 6...10
    switch peopleCount {
    case 1:
        print("Single")
    case few:
        print("Few")
    case serveral:
        print("Serveral")
    default:
        print("Many")
    }
}

let groupSizes = [1, 5, 4, 6, 2, 1, 3]
for case 1 in groupSizes {
    print("Found an individual")
}
