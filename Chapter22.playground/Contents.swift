import UIKit

enum PetFood: String {
case kibble, canned
}

let morning = PetFood(rawValue: "kibble")
let snack = PetFood(rawValue: "fuuud!")

struct PetHouse {
    let squareFeet: Int
    
    init?(squareFeet: Int) {
        if squareFeet < 1 {
            return nil
        }
        self.squareFeet = squareFeet
    }
}

let tooSmall = PetHouse(squareFeet: 0)
let house = PetHouse(squareFeet: 1)

class Toy {
    enum Kind {
        case ball, zombie, bone, mouse
    }
    
    enum Sound {
        case squeak, bell
    }
    
    let kind: Kind
    let color: String
    var sound: Sound?
    
    init(kind: Kind, color: String, sound: Sound? = nil) {
        self.kind = kind
        self.color = color
        self.sound = sound
    }
}

class Pet {
    enum Kind {
        case dog, cat, guineaPig
    }
    
    let name: String
    let kind: Kind
    let favoriteToy: Toy?
    
    init(name: String, kind: Kind, favoriteToy: Toy? = nil) {
        self.name = name
        self.kind = kind
        self.favoriteToy = favoriteToy
    }
}

class Person {
    let pet: Pet?
    var name: String
    var age: Int
    
    init(name: String, age: Int, pet: Pet? = nil) {
        self.name = name
        self.age = age
        self.pet = pet
    }
}

enum PersonError: Error {
    case noName, noAge, noData
}

extension Person {
    var data: String {
        get throws {
            guard !name.isEmpty else {
                throw PersonError.noName
            }
            
            guard age > 0 else {
                throw PersonError.noAge
            }
            
            return "\(name) is \(age) years old."
        }
    }
}

extension Person {
    subscript(key: String) -> String {
        get throws {
            switch key {
            case "name":
                return name
            case "age":
                return "\(age)"
            default:
                throw PersonError.noData
            }
        }
    }
}

let janie = Person(name: "janie", age: 15, pet: Pet(name: "Delia", kind: .dog, favoriteToy: Toy(kind: .ball, color: "Purple", sound: .bell)))
let tammy = Person(name: "tammy", age: 20, pet: Pet(name: "Evil Cat Overlord", kind: .cat, favoriteToy: Toy(kind: .mouse, color: "Orange")))
let felipe = Person(name: "felipe", age: 22)
let team = [janie, tammy, felipe]
team.compactMap { $0.pet?.name }

class Pastry {
    let flavor: String
    var numberOnHand: Int
    
    init(flavor: String, numberOnHand: Int) {
        self.flavor = flavor
        self.numberOnHand = numberOnHand
    }
}

enum BakeryError: Error {
    case tooFew(numberOnHand: Int), doNotSell, wrongFlavor
    case inventory, noPower
}

class Bakery {
    var itemForSale = [
        "Cookie": Pastry(flavor: "ChocolateChip", numberOnHand: 20),
        "PopTart": Pastry(flavor: "WildBerry", numberOnHand: 13),
        "Donut" : Pastry(flavor: "Sprinkles", numberOnHand: 24),
        "HandPie": Pastry(flavor: "Cherry", numberOnHand: 6)
    ]
    
    func open(_ now: Bool = Bool.random()) throws -> Bool {
        guard now else {
            throw Bool.random() ? BakeryError.inventory : BakeryError.noPower
        }
        return now
    }
    
    func orderPastry(item: String, amountRequested: Int, flavor: String) throws -> Int {
        guard let pastry = itemForSale[item] else {
            throw BakeryError.doNotSell
        }
        guard flavor == pastry.flavor else {
            throw BakeryError.wrongFlavor
        }
        guard amountRequested <= pastry.numberOnHand else {
            throw BakeryError.tooFew(numberOnHand: pastry.numberOnHand)
        }
        
        pastry.numberOnHand -= amountRequested
        return pastry.numberOnHand
    }
}
let bakery = Bakery()
do {
    try bakery.open()
    try bakery.orderPastry(item: "Albatross", amountRequested: 1, flavor: "AlbatrossFlavor")
} catch BakeryError.inventory, BakeryError.noPower {
    print("Sorry, the bakery is now closed.")
} catch BakeryError.doNotSell {
    print("Sorry, but we don't sell this item.")
} catch BakeryError.wrongFlavor {
    print("Sorry, but we don't carry this flavor.")
} catch BakeryError.tooFew {
    print("Sorry, we don't has enough items to fulfill your order.")
}

let open = try? bakery.open(false)
let remaining = try? bakery.orderPastry(item: "Albatross", amountRequested: 1, flavor: "AlbatrossFlavor")

enum Direction {
    case left, right, forward
}

enum PugBotError: Error {
    case invalidMode(found: Direction, expected: Direction)
    case endOfPath
}

class PugBot {
    let name: String
    let correctPath: [Direction]
    private var currentStepInPath = 0
    
    init(name: String, correctPath: [Direction]) {
        self.name = name
        self.correctPath = correctPath
    }
    
    func move(_ direction: Direction) throws {
        guard currentStepInPath < correctPath.count else {
            throw PugBotError.endOfPath
        }
        
        let nextDirection = correctPath[currentStepInPath]
        guard nextDirection == direction else {
            throw PugBotError.invalidMode(found: direction, expected: nextDirection)
        }
        currentStepInPath += 1
    }
    
    func reset() {
        currentStepInPath = 0
    }
}

let pug = PugBot(name: "Pug", correctPath: [.forward, .left, .forward, .right])
func goHome() throws {
    try pug.move(.forward)
    try pug.move(.left)
    try pug.move(.forward)
    try pug.move(.right)
}

func moveSafely(_ movement: () throws -> ()) -> String {
    do {
        try movement()
        return "Completed operation successfully."
    } catch PugBotError.invalidMode(let found, let expected) {
        return "The PugBot was supposed to move \(expected), but moved \(found) instead."
    } catch PugBotError.endOfPath {
        return "The PugBot tried to move past the end of the path."
    } catch {
        return "An unknown error occurred."
    }
}

do {
    try goHome()
} catch {
    print("PugBot failed to get home.")
}

pug.reset()
moveSafely(goHome)

pug.reset()
moveSafely {
    try pug.move(.forward)
    try pug.move(.left)
    try pug.move(.forward)
    try pug.move(.right)
}

func perform(times: Int, movement: () throws -> ()) rethrows {
    for _ in 1...times {
        try movement()
    }
}
