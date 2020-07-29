import UIKit

// 浮点数的取余
(28.0).truncatingRemainder(dividingBy: (10.0))

1 << 3
32 >> 2
((8000 / (5 * 10)) - 32) >> (29 % 5)

// √2
(2.0).squareRoot()
(9.0).squareRoot()

// constant
let number: Int = 10

// variable
var variableNumber: Int = 42
variableNumber = 1_000_000


// ----- exercise -----
let myAge: Int = 25

var average: Double = 25
average = 27.5

let testNumber: Int = 5
let evenOdd: Int = testNumber % 2

var testNumberVar: Int = 5
var evenOddVar: Int = testNumberVar % 2

var answer: Int = 0
answer += 1
answer *= 10
answer >> 3


// ----- challenges -----
let myNewAge = 25
var dogs = 0
dogs += 1

var age: Int = 16
print(age)
age = 30
print(age)

let x: Int = 46
let y: Int = 10
let answer1: Int = (x * 100) + y
let answer2: Int = (x * 100) + (y * 100)
let answer3: Int = (x * 100) + (y / 10)

8 - 4 * 2 + 6 / 3 * 4
(8 - 4) * (2 + 6) / 3 * 4

let rating1: Double = 4.9
let rating2: Double = 4.8
let rating3: Double = 4.5
let averageRating: Double = (rating1 + rating2 + rating3) / 3

let randomNumber = arc4random()
let diceRoll = randomNumber % 6 + 1

let a: Double = 1
let b: Double = 4
let c: Double = 4
let root1 = (-b + (pow(b, 2) - 4 * a * c).squareRoot()) / (2 * a)
let root2 = (-b - (pow(b, 2) - 4 * a * c).squareRoot()) / (2 * a)
