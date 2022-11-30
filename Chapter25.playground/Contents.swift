import UIKit

struct Color: CustomStringConvertible {
    var red, green, blue: Double
    
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

var azure = Color.blue
var wallBlue = azure

azure
wallBlue.darken()
azure

struct PaintingPlan {
    var accent = Color.white
    private var bucket = Bucket(color: .green)
    
    var bucketColor: Color {
        set {
            if isKnownUniquelyReferenced(&bucket) {
                bucket.color = bucketColor
            } else {
                bucket = Bucket(color: newValue)
            }
        }
        get {
            bucket.color
        }
    }
}

private class Pixels {
    let storageBuffer: UnsafeMutableBufferPointer<UInt8>
    
    init(size: Int, value: UInt8) {
        let p = UnsafeMutablePointer<UInt8>.allocate(capacity: size)
        storageBuffer = UnsafeMutableBufferPointer(start: p, count: size)
        storageBuffer.initialize(from: repeatElement(value, count: size))
    }
    
    init(pixels: Pixels) {
        let otherStorage = pixels.storageBuffer
        let p = UnsafeMutablePointer<UInt8>.allocate(capacity: otherStorage.count)
        storageBuffer = UnsafeMutableBufferPointer<UInt8>(start: p, count: otherStorage.count)
        storageBuffer.initialize(from: otherStorage)
    }
    
    subscript(offset: Int) -> UInt8 {
        set {
            storageBuffer[offset] = newValue
        }
        get {
            storageBuffer[offset]
        }
    }
    
    deinit {
        storageBuffer.baseAddress!.deallocate()
    }
}

struct Image {
    private(set) var width: Int
    private(set) var height: Int
    private var pixels: Pixels
    private var mutatingPixels: Pixels {
        mutating get {
            if !isKnownUniquelyReferenced(&pixels) {
                pixels = Pixels(pixels: pixels)
            }
            return pixels
        }
    }
    
    init(width: Int, height: Int, value: UInt8) {
        self.width = width
        self.height = height
        self.pixels = Pixels(size: width * height, value: value)
    }
    
    subscript(x: Int, y: Int) -> UInt8 {
        set {
            mutatingPixels[y * width + x] = newValue
        }
        get {
            return pixels[y * width + x]
        }
    }
    
    mutating func clear(with value: UInt8) {
        for (i, _) in self.mutatingPixels.storageBuffer.enumerated() {
            self.mutatingPixels.storageBuffer[i] = value
        }
    }
}
