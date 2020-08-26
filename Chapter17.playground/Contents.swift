import UIKit

enum PetKind {
    case cat
    case dog
}

struct KeeperKind {
    var keeperOf: PetKind
}

let catKeeper = KeeperKind(keeperOf: .cat)
let dogKeeper = KeeperKind(keeperOf: .dog)

protocol Pet {
    var name: String { get }
}

class Cat: Pet {
    var name: String
    
    init(name: String) {
        self.name = name
    }
}
class Dog: Pet {
    var name: String
    
    init(name: String) {
        self.name = name
    }
}

class KeeperForCats {}
class KeeperForDogs {}

// Generics provide a mechanism for using one set of types to define a new set of types.
class Keeper<Animal: Pet> {
    var name: String
    var morningCare: Animal
    var afternoonCare: Animal
    var takeCareAnimals: [Animal] = []
    
    var countAnimals: Int {
        takeCareAnimals.count
    }
    
    init(name: String, morningCare: Animal, afternoonCare: Animal) {
        self.name = name
        self.morningCare = morningCare
        self.afternoonCare = afternoonCare
    }
    
    func lookAfter(_ animal: Animal) {
        takeCareAnimals.append(animal)
    }
    
    func animalAtIndex(_ index: Int) -> Animal? {
        takeCareAnimals[index]
    }
}

let jason = Keeper(name: "Jason", morningCare: Cat(name: "Whiskers"), afternoonCare: Cat(name: "Sleepy"))
let star = Keeper(name: "Star", morningCare: Dog(name: "WangCai"), afternoonCare: Dog(name: "ErHa"))

// 当数组的元素都是 Cat 时，Array 才会实现 meow 方法
extension Array where Element: Cat {
    func meow() {
        forEach {
            print("\($0.name) says meow!")
        }
    }
}

protocol Meowable {
    func meow()
}

extension Cat: Meowable {
    func meow() {
        print("\(self.name) says meow!")
    }
}

// 当数组的元素遵守 Meowable 协议，Array 就会实现 Meowable 协议
extension Array: Meowable where Element: Meowable {
    func meow() {
        forEach {
            $0.meow()
        }
    }
}

func swapped<T, U>(_ x: T, _ y: U) -> (U, T) {
    (y, x)
}
swapped(44, "Haha")
