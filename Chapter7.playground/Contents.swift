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
