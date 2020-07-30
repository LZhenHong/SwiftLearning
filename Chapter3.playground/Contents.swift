import UIKit

// Bool
let yes = true
let no = false

let doesOneEqualTwo = (1 == 2)
let doesOneNotEqualTwo = (1 != 2)
let alsoTrue = !(1 == 2)
let isOneGreaterThanTwo = (1 > 2)
let isOneLessThanTwo = (1 < 2)
// <= >=

let and = true && true
let or = true || true
let andTrue = 1 < 2 && 4 > 3
let andFalse = 1 < 2 && 3 > 4
let orTrue = 1 < 2 || 3 > 4
let orFalse = 1 == 2 || 3 == 4
let andOr = (1 < 2 && 3 > 4) || 1 < 4

var switchState = true
switchState.toggle()
switchState.toggle()

// String equality
let guess = "dog"
let dogEqualCat = guess == "cat"
let order = "cat" < "dog"

// ----- Mini-exercises -----
let myAge = 25
let isTeenager = myAge >= 13 && myAge <= 19

let theirAge = 30
let bothTeenager = isTeenager && (theirAge >= 13 && theirAge <= 19)

let reader = "Eden"
let author = "Matt Galloway"
let authorIsReader = reader == author

let readerBeforeAuthor = reader < author

// if
if 2 > 1 {
    print("Yes, 2 is greater than 1.")
}

let animal = "Fox"
if animal == "Cat" || animal == "Dog" {
    print("Animal is a house pet.")
} else {
    print("Animal is not a house pet.")
}

let hourOfDay = 12
var timeOfDay = ""
// The order of your conditions matters
if hourOfDay < 6 {
    timeOfDay = "Early morning"
} else if hourOfDay < 12 {
    timeOfDay = "Morning"
} else if hourOfDay < 17 {
    timeOfDay = "Afternoon"
} else if hourOfDay < 20 {
    timeOfDay = "Evening"
} else if hourOfDay < 24 {
    timeOfDay = "Late evening"
} else {
    timeOfDay = "INVALID HOUR!"
}
print(timeOfDay)

var hoursWorked = 45
var price = 0
if hoursWorked > 40 {
    let hoursOver40 = hoursWorked - 40
    let priceOver40 = hoursOver40 * 50
    price += priceOver40
    hoursWorked -= hoursOver40
}
price += hoursWorked * 25

// 三元运算符
let a = 5
let b = 10
let minVal = a > b ? b : a
let minMath = min(a, b)
let maxVal = a > b ? a : b
let maxMath = max(a, b)

// ----- Mini-exercises -----
if myAge >= 13 && myAge <= 19 {
    print("Teenager")
} else {
    print("Not a teenager")
}

let answer = myAge >= 13 && myAge <= 19 ? "Teenager" : "Not a teenager"
print(answer)

// Loops
var sum = 1
while sum < 1_000 {
    sum += (sum + 1)
}

sum = 1
repeat {
    sum += (sum + 1)
} while sum < 1_000

sum = 1
while true {
    sum += (sum + 1)
    if sum >= 1_000 {
        break
    }
}

// ----- Mini-exercises -----
var counter = 0
while counter < 10 {
    print("counter is \(counter)")
    counter += 1
}

counter = 0
var roll = 0
repeat {
    roll = Int.random(in: 0...5)
    counter += 1
    print("After \(counter) rolls, roll is \(roll)")
} while roll != 0

// ----- Challenges -----
let currentPosition = 14
let diceRoll = Int.random(in: 1...6)
var nextPosition = currentPosition + diceRoll
if nextPosition == 3 {
    nextPosition = 15
} else if nextPosition == 7 {
    nextPosition = 12
} else if nextPosition == 11 {
    nextPosition = 2
} else if nextPosition == 17 {
    nextPosition = 9
}

let year = 2000
var days = 0
// 闰年
if (year % 4 == 0 && year % 100 != 0) || year % 400 == 0 {
    days = 29
}
