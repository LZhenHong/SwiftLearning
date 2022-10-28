import Cocoa

struct Car {
    @Percentage var fuelLevel: Double = 1.0
    @Percentage var wiperFluidLevel: Double = 0.5
    @Percentage(upperBound: 2.0) var stereoVolume: Double = 1.0
}

extension Car: CustomStringConvertible {
    var description: String {
        return "fuelLevel: \(fuelLevel), wrapped by: \(_fuelLevel)"
    }
}

var myCar = Car()
print(myCar)

myCar.fuelLevel = 1.1
print("Fuel: \(myCar.fuelLevel)")

myCar.stereoVolume = 2.5
print("Volume: \(myCar.stereoVolume)")

print("Projected volume: \(myCar.$stereoVolume)")
