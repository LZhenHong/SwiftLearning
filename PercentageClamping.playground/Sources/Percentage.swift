import Foundation

extension Double {
    func clamp(to range: ClosedRange<Self>) -> Self {
        return max(min(self, range.upperBound), range.lowerBound)
    }
}

@propertyWrapper public struct Percentage {
    private var storage: Double
    private var upperBound: Double
    
    public init(wrappedValue: Double, upperBound: Double = 1) {
        storage = wrappedValue
        self.upperBound = upperBound
    }
    
    public var wrappedValue: Double {
        set {
            storage = newValue
        }
        get {
            return storage.clamp(to: 0.0...upperBound)
        }
    }
    
    public var projectedValue: Double {
        get {
            return storage
        }
    }
}
