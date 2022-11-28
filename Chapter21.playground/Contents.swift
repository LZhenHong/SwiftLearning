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

if case (let x, 0, 0) = coordinate {
    print("On the x-axis at \(x)")
}

let names: [String?] = ["Michelle", nil, "Brandon", "Christine", nil, "David"]
for case .some(let name) in names {
    print(name)
}

for case let name? in names {
    print(name)
}

let response: [Any] = [15, "George", 2.0]

for element in response {
    switch element {
    case is String:
        print("Found a string")
    default:
        print("Found something else")
    }
}

for element in response {
    switch element {
    case let text as String:
        print("Found a string: \(text)")
    default:
        print("Found something else")
    }
}

enum LevelStatus {
    case complete
    case inProgress(percent: Double)
    case notStarted
}

let levels: [LevelStatus] = [.complete, .inProgress(percent: 0.9), .notStarted]
for level in levels {
    switch level {
    case .inProgress(let percent) where percent > 0.8:
        print("Almost there!")
    case .inProgress(let percent) where percent > 0.5:
        print("Halfway there!")
    case .inProgress(let percent) where percent > 0.2:
        print("Made it through the beginning!")
    default:
        break
    }
}

1...10 ~= 5

func ~=<T: BinaryInteger>(pattern: [T], value: T) -> Bool {
    return pattern.contains(value)
}

let list = [0, 1, 2, 3]
let integer = 2
let isInArray = list ~= integer
if case list = integer {
    print("The integer is in the array")
} else {
    print("The integer is not in the array")
}

enum FormField {
    case firstName(String)
    case lastName(String)
    case emailAddress(String)
    case age(Int)
}

let minimumAge = 21
let submittedAge = FormField.age(22)

if case .age(let age) = submittedAge, age < minimumAge {
    print("Error")
}

enum CelestialBody {
    case star
    case planet(liquidWater: Bool)
    case comet
}
let telescopeCensus = [CelestialBody.star, .planet(liquidWater: false), .planet(liquidWater: true), .planet(liquidWater: true), .comet]
for case .planet(let liquid) in telescopeCensus where liquid {
    print("planet with liquid water")
}

let queenAlbums = [("A Night at the Opera", 1974), ("Sheer Heart Attack", 1974), ("Jazz", 1978), ("The Game", 1980)]
for case (let album, 1974) in queenAlbums {
    print(album)
}
