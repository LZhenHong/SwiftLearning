import UIKit

// Advanced Control Flow

// The second number must always be greater than or equal to the ﬁrst.
let closedRange = 0...5
let halfOpenRange = 0..<5

while Int.random(in: 1...6) != 6 {
    print("Not a six")
}

let count = 10
var sum = 0
for i in 1...count {
    sum += i
}

sum = 1
var lastSum = 0
for _ in 0..<count {
    let temp = sum
    sum += lastSum
    lastSum = temp
}

sum = 0
for i in 1...count where i % 2 == 1 {
    sum += i
}

sum = 0
for row in 0..<8 where row % 2 == 0 {
    for col in 0..<8 {
        sum += row * col
    }
}

sum = 0
for row in 0..<8 {
    for col in 0..<8 where row > col {
        sum += row * col
    }
}

sum = 0
// 不实用，了解就好，有更好的方式实现
// You need to use labeled statements if you want to manipulate an outer loop.
rowLoop: for row in 0..<8 {
    colLoop: for col in 0..<8 {
        if row == col {
            continue rowLoop
        }
        sum += row * col
    }
}

// ----- Mini-exercises -----
let range = 1...10
for i in range {
    print(i * i)
}

for i in range {
    print(Double(i).squareRoot())
}

sum = 0
for row in 0..<8 where row % 2 != 0 {
    for col in 0..<8 {
        sum += row * col
    }
}

// Switch
// When you want nothing to happen for a case, you use the break statement. This tells Swift that you meant to not write any code here and that nothing should happen. Cases can never be empty, so you must write some code, even if it’s just a break!
let number = 10
switch number {
case 0:
    print("Zero")
default:
    print("Not zero")
}

let animal = "Dog"
switch animal {
case "Cat", "Dog":
    print("Animal is a house pet.")
default:
    print("Animal is not a house pet.")
}

let hourOfDay = 12
var timeOfDay = ""

switch hourOfDay {
case 0...5:
    timeOfDay = "Early morning"
case 6...11:
    timeOfDay = "Morning"
case 12...16:
    timeOfDay = "Afternoon"
case 17...19:
    timeOfDay = "Evening"
case 20...23:
    timeOfDay = "Late evening"
default:
    timeOfDay = "INVALID HOUR!"
}
print(timeOfDay)

switch number {
case _ where number % 2 == 0:
    print("Even")
default:
    print("Odd")
}

let coordinates = (x: 3, y: 2, z: 5)

switch coordinates {
case (0, 0, 0):
    print("Origin")
case (_, 0, 0):
    print("On the x-axis.")
case (0, _, 0):
    print("On the y-axis.")
case (0, 0, _):
    print("On the z-axis.")
default:
    print("Somewhere in space")
}

switch coordinates {
case (0, 0, 0):
    print("Origin")
case (let x, 0, 0):
    print("On the x-axis at x = \(x)")
case (0, let y, 0):
    print("On the y-axis at y = \(y)")
case (0, 0, let z):
    print("On the z-axis at z = \(z)")
case let (x, y, z):
    print("Somewhere in space at x = \(x), y = \(y), z = \(z)")
}

switch coordinates {
case let (x, y, _) where x == y:
    print("Along the y = x line.")
case let (x, y, _) where y == x * x:
    print("Along the y = x^2 line.")
default:
    break
}

// ----- Mini-exercises -----
let myAge = 25
switch myAge {
case 0...2:
    print("Infant")
case 3...12:
    print("Child")
case 13...19:
    print("Teenager")
case 20...39:
    print("Adult")
case 40...60:
    print("Middle aged")
default:
    print("Elderly")
}

let person = ("Eden", 25)
switch person {
case let (name, age) where age >= 0 && age <= 2:
    print("\(name) is infant.")
case let (name, age) where age > 2 && age <= 12:
    print("\(name) is child.")
case let (name, age) where age > 12 && age <= 19:
    print("\(name) is teenager.")
case let (name, age) where age > 19 && age <= 39:
    print("\(name) is adult.")
case let (name, age) where age > 40 && age <= 60:
    print("\(name) is middle aged.")
case let (name, age) where age > 60:
    print("\(name) is elderly.")
default:
    print("INVALID AGE!")
}

// ----- Challenges -----
var aLotOfAs = ""
while aLotOfAs.count < 10 {
    aLotOfAs += "a"
}

var counter = 10
while counter >= 0 {
    print(counter)
    counter -= 1
}
