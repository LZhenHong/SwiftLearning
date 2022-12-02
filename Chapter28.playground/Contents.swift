import UIKit

protocol Pet {
    associatedtype Food
    func eat(_ food: Food)
}

// type erasure
struct AnyPet<Food>: Pet {
    private let _eat: (Food) -> Void
    
    init<SomePet: Pet>(_ pet: SomePet) where SomePet.Food == Food {
        _eat = pet.eat(_:)
    }
    
    func eat(_ food: Food) {
        _eat(food)
    }
}

extension Pet {
    func eraseToAnyPet() -> AnyPet<Food> {
        .init(self)
    }
}

enum PetFood {
    case dry, wet
}

struct Cat: Pet {
    func eat(_ food: PetFood) {
        print("Eating cat food.")
    }
}

struct Dog: Pet {
    func eat(_ food: PetFood) {
        print("Eat dog food.")
    }
}

protocol WeightCalculatable {
    associatedtype WeightType: Numeric
    var weight: WeightType { get }
}

extension WeightCalculatable {
    static func +(left: Self, right: Self) -> WeightType {
        left.weight + right.weight
    }
}

protocol Product {
    init()
}

protocol ProductionLine {
    associatedtype ProductType
    func produce() -> ProductType
}

protocol Factory {
    associatedtype ProductType
    func produce() -> [ProductType]
}

struct Car: Product {
    init() {
        print("Producing one awesome Car")
    }
}

struct Chocolate: Product {
    init() {
        print("Producing one Chocolate bar")
    }
}

struct GenericProductionLine<P: Product>: ProductionLine {
    func produce() -> P {
        P()
    }
}

struct GenericFactory<P: Product>: Factory {
    var productionLines: [GenericProductionLine<P>] = []
    
    func produce() -> [P] {
        var newItems: [P] = []
        productionLines.forEach { newItems.append($0.produce()) }
        print("Finished Production")
        print("-------------------")
        return newItems
    }
}

var carFactory = GenericFactory<Car>()
carFactory.productionLines = [GenericProductionLine<Car>(), GenericProductionLine<Car>()]
carFactory.produce()

let array = Array(1...10)
let set = Set(array)
let reversedArray = array.reversed()

let collections = [
    AnyCollection(array),
    AnyCollection(set),
    AnyCollection(array.reversed())
]
let total = collections.flatMap { $0 }.reduce(0, +)
print(total)

func makeEquatableNumbericInt() -> some Numeric & Equatable {
    1
}

func makeEquatableNumbericDouble() -> some Numeric & Equatable {
    1.0
}

protocol VehicleToy {
    static var numberOfPieces: Int { get }
    init()
}

protocol Robot {
    associatedtype Toy where Toy: VehicleToy
    var piecesPerMinute: Int { get }
    
    func operate(durationInMinutes: Int) -> [Toy]
    func operate(newItems: Int) -> (Int, [Toy])
}

extension Robot {
    func operate(newItems: Int) -> (Int, [Toy]) {
        let totalPieces = newItems * Toy.numberOfPieces
        let operationTime = totalPieces / piecesPerMinute
        
        var newToys: [Toy] = []
        for _ in 0..<newItems {
            newToys.append(Toy())
        }
        return (operationTime, newToys)
    }
    
    func operate(durationInMinutes: Int) -> [Toy] {
        let numberOfToys = (durationInMinutes * piecesPerMinute) / Toy.numberOfPieces
        return operate(newItems: numberOfToys).1
    }
}
