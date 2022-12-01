import UIKit

protocol Pet {
    associatedtype Food
    var name: String { get }
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
