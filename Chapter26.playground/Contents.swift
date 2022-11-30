import UIKit

@propertyWrapper
struct ZeroToOne {
    private var value: Double
    
    private static func clamped(_ input: Double) -> Double {
        min(max(0, input), 1)
    }
    
    init(wrappedValue: Double) {
        value = Self.clamped(wrappedValue)
    }
    
    var wrappedValue: Double {
        set {
            value = Self.clamped(newValue)
        }
        get {
            value
        }
    }
}

@propertyWrapper
struct ZeroToOneV2 {
    private var value: Double
    
    init(wrappedValue: Double) {
        value = wrappedValue
    }
    
    var wrappedValue: Double {
        set {
            value = newValue
        }
        get {
            min(max(0, value), 1)
        }
    }
    
    var projectedValue: Double {
        value
    }
}

@propertyWrapper
struct ZeroTo<Value: Numeric & Comparable>{
    private var value: Value
    let upper: Value
    
    init(wrappedValue: Value, upper: Value) {
        value = wrappedValue
        self.upper = upper
    }
    
    var wrappedValue: Value {
        set {
            value = newValue
        }
        get {
            min(max(0, value), upper)
        }
    }
    
    var projectedValue: Value {
        value
    }
}

struct Color {
    @ZeroToOne var red: Double
    @ZeroToOne var green: Double
    @ZeroToOne var blue: Double
}

func printValue(@ZeroToOne _ value: Double) {
    print("The wrapped value: \(value)")
}
printValue(3.14)

func printValueV2(@ZeroToOneV2 _ value: Double) {
    print("The wrapped value is: \(value)")
    print("The projected value is: \($value)")
}
printValueV2(3.14)

func printValueV3(@ZeroTo(upper: 10) _ value: Double) {
    print("The wrapped value is: \(value)")
    print("The projected value is: \($value)")
}
printValueV3(42)

extension Color: CustomStringConvertible {
    var description: String {
        "r: \(red) g: \(green) b: \(blue)"
    }
}

extension Color {
    mutating func darken() {
        red *= 0.9
        green *= 0.9
        blue *= 0.9
    }
}

extension Color {
    static var black = Color(red: 0, green: 0, blue: 0)
    static var white = Color(red: 1, green: 1, blue: 1)
    static var blue = Color(red: 0, green: 0, blue: 1)
    static var green = Color(red: 0, green: 1, blue: 0)
}

class Bucket {
    var color: Color
    var isRefilled = false
    
    init(color: Color) {
        self.color = color
    }
    
    func refill() {
        isRefilled = true
    }
}

struct PaintingPlan {
    var accent = Color.white
    
    @CopyOnWriteColor var bucketColor = .blue
    @CopyOnWriteColor var bucketColorForDoor = .blue
    @CopyOnWriteColor var bucketColorForWalls = .blue
}

@propertyWrapper
struct CopyOnWriteColor {
    private var bucket: Bucket
    
    init(wrappedValue: Color) {
        bucket = Bucket(color: wrappedValue)
    }
    
    var wrappedValue: Color {
        set {
            if isKnownUniquelyReferenced(&bucket) {
                bucket.color = newValue
            } else {
                bucket = Bucket(color: newValue)
            }
        }
        get {
            bucket.color
        }
    }
}

@propertyWrapper
public struct ValidatedDate {
    private var storage: Date? = nil
    private(set) var formatter = DateFormatter()
    
    public init(wrappedValue: String) {
        formatter.dateFormat = "yyyy-mm-dd"
        self.wrappedValue = wrappedValue
    }
    
    public var wrappedValue: String {
        set {
            self.storage = formatter.date(from: newValue)
        }
        get {
            if let date = self.storage {
                return formatter.string(from: date)
            } else {
                return "invalid"
            }
        }
    }
    
    public var projectedValue: DateFormatter {
        set {
            formatter = newValue
        }
        get {
            formatter
        }
    }
}

struct Order {
    @ValidatedDate var orderPlacedDate: String
    @ValidatedDate var shippingDate: String
    @ValidatedDate var deliveredDate: String
}

private class StorageBox<StoredValue> {
    var value: StoredValue

    init(_ value: StoredValue) {
        self.value = value
    }
}

@propertyWrapper
struct CopyOnWrite<StoredValue> {
    private var box: StorageBox<StoredValue>
    
    init(wrappedValue: StoredValue) {
        box = StorageBox(wrappedValue)
    }
    
    var wrappedValue: StoredValue {
        set {
            if isKnownUniquelyReferenced(&box) {
                box.value = newValue
            } else {
                box = StorageBox(newValue)
            }
        }
        get {
            box.value
        }
    }
}

protocol DeepCopyable {
    func deepCopy() -> Self
}

@propertyWrapper
struct ValueSemantic<T: DeepCopyable> {
    private var storage: StorageBox<T>
    
    init(wrappedValue: T) {
        storage = StorageBox(wrappedValue)
    }
    
    var wrappedValue: T {
        set {
            if isKnownUniquelyReferenced(&storage) {
                storage.value = newValue
            } else {
                storage = StorageBox(newValue.deepCopy())
            }
        }
        mutating get {
            if isKnownUniquelyReferenced(&storage) {
                return storage.value
            } else {
                storage = StorageBox(storage.value.deepCopy())
                return storage.value
            }
        }
    }
}
