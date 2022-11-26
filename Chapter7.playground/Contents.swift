import UIKit

let evenNumbers = [2, 4, 6, 8]
var subscribers: [String] = []
let allZeros = Array(repeating: 0, count: 5)
let vowels = ["A", "E", "I", "O", "U"]

var players = ["Alice", "Bob", "Cindy", "Dan"]
print(players.isEmpty)
if players.count < 2 {
    print("We need at least two players!")
} else {
    print("Let's start!")
}
var currentPlayer = players.first
print(currentPlayer as Any)
print(players.last as Any)
print(players.min() as Any)

print([2, 3, 1].first as Any)
print([2, 3, 1].min() as Any)
print([2, 3, 1].max() as Any)

if let currentPlayer = currentPlayer {
    print("\(currentPlayer) will start")
}

var firstPlayer = players[0]
print("First player is \(firstPlayer)")

// The reason for this type difference is to make clear that upcomingPlayersSlice shares storage with players.
// ArraySlice
let upcomingPlayersSlice = players[1...2]
print(upcomingPlayersSlice[1], upcomingPlayersSlice[2])

let upcomingPlayersArray = Array(players[1...2])
print(upcomingPlayersArray[0], upcomingPlayersArray[1])

func isEliminated(player: String) -> Bool {
    !players.contains(player)
}
print(isEliminated(player: "Bob"))
players[1...3].contains("Bob")

// Arrays can only store values of the same type
players.append("Eli")
players += ["Gina"]
print(players)

players.insert("Frank", at: 5)

var removedPlayer = players.removeLast()
print("\(removedPlayer) was removed")

removedPlayer = players.remove(at: 2)
print("\(removedPlayer) was removed")

let danIndex = players.firstIndex(of: "Dan")
if let index = danIndex {
//    removedPlayer = players.remove(at: index)
//    print("\(removedPlayer) was removed")
    print("Dan is at \(index)")
}

players[4] = "Franklin"
players[0...1] = ["Donna", "Craig", "Brian", "Anna"]

players.swapAt(1, 3)
print(players)
players.sorted() // 不改变原数组，返回新的数组
print(players)
players.sort() // 直接改变原数组
print(players)

for player in players {
    print(player)
}

for (index, player) in players.enumerated() {
    print("\(index + 1). \(player)")
}

// Arrays are stored as a continuous block in memory. That means if you have ten elements in an array, the ten values are all stored one next to the other.

// Dictionaries are unordered!
var namesAndScores = ["Anna": 2, "Brian": 2, "Craig": 8, "Donna": 6]
namesAndScores = [:]
var pairs: [String: Int] = [:]
pairs.reserveCapacity(20)

namesAndScores = ["Anna": 2, "Brian": 2, "Craig": 8, "Donna": 6]
print(namesAndScores["Anna"] as Any)
print(namesAndScores["Greg"] as Any)

// A dictionary needs to loop through all of the values to compute the count.
namesAndScores.isEmpty
namesAndScores.count

var bobData = [
    "name": "Bob",
    "profession": "Card Player",
    "country": "USA"
]
bobData.updateValue("CA", forKey: "state")
bobData["city"] = "San Francisco"
func printPlayerCityAndState(playerData: [String: String]) {
    guard let city = playerData["city"], let state = playerData["state"] else {
        print("Player has no city or state.")
        return
    }
    print("Player comes from \(city), \(state)")
}
printPlayerCityAndState(playerData: bobData)

bobData.updateValue("Bobby", forKey: "name")
bobData["profession"] = "Mailman"

bobData.removeValue(forKey: "state")
bobData["city"] = nil

for (player, score) in namesAndScores {
    print("\(player) - \(score)")
}

for player in namesAndScores.keys {
    print("\(player), ", terminator: "")
}
print("")

for score in namesAndScores.values {
    print("\(score), ", terminator: "")
}
print("")

// Hash key

let setOne: Set<Int> = [1]
var explicitSet: Set<Int> = [1, 2, 3, 1]
var someSet = Set([1, 2, 3, 1])

print(someSet.contains(1))
print(someSet.contains(4))

someSet.insert(5)
let removeElment = someSet.remove(1)
print(removeElment as Any)


// ----- Challenges -----
let array1 = [Int]()
// let array2 = [] // Error happens
let array3: [String] = []

let array4 = [1, 2, 3]
print(array4[0])
array4[1...2]

var array5 = [1, 2, 3]
array5[0] = array5[1]
array5[0...1] = [4, 5]
for item in array5 {
    print("Array: \(item)")
}

func removingOnce(_ item: Int, from array: [Int]) -> [Int] {
    var resArray = array
    if let itemIndex = array.firstIndex(of: item) {
        resArray.remove(at: itemIndex)
    }
    return resArray
}

func removing(_ item: Int, from array: [Int]) -> [Int] {
    var indexs: [Int] = []
    for (index, arrayItem) in array.enumerated() {
        if arrayItem == item {
            indexs.append(index)
        }
    }
    guard !indexs.isEmpty else {
        return array
    }
    var resArray = Array(array[0...array.count - 1])
    for index in indexs.reversed() {
        resArray.remove(at: index)
    }
    return resArray
}

func reversed(_ array: [Int]) -> [Int] {
    var resArray: [Int] = []
    for item in array {
        resArray.insert(item, at: 0)
    }
    return resArray
}

func middle(_ array: [Int]) -> Int? {
    guard !array.isEmpty else {
        return nil
    }
    
    return array[array.count / 2]
}

func minMax(of numbers: [Int]) -> (min: Int, max: Int)? {
    guard !numbers.isEmpty else {
        return nil
    }
    
    let tmpNumbers = numbers.sorted()
    return (tmpNumbers.first!, tmpNumbers.last!)
}

var dict5 = ["NY": "New York", "CA": "California"]
dict5["NY"]
dict5["WA"] = "Washington"
dict5["CA"] = nil

func printValueMoreThan8(locationMap: [String: String]) {
    for (_, location) in locationMap where location.count > 8 {
        print(location)
    }
}
printValueMoreThan8(locationMap: dict5)

func merging(_ dict1: [String: String], with dict2: [String: String]) -> [String: String] {
    var resDict = dict1
    for (key, val) in dict2 {
        resDict[key] = val
    }
    return resDict
}

func occurrencesOfCharacters(in text: String) -> [Character: Int] {
    guard !text.isEmpty else {
        return [:]
    }
    var resDict: [Character: Int] = [:]
    for char in text {
        let count = resDict[char, default: 0]
        resDict[char] = count + 1
    }
    return resDict
}

func isInvertible(_ dictionary: [String: Int]) -> Bool {
    var containerSet: Set<Int> = []
    for (_, val) in dictionary {
        containerSet.insert(val)
    }
    return containerSet.count == dictionary.values.count
}

var nameTitleLookup: [String: String?] = ["Mary": "Engineer", "Patrick": "Intern", "Ray": "Hacker"]
nameTitleLookup.updateValue(nil, forKey: "Patrick")
nameTitleLookup["Ray"] = nil
