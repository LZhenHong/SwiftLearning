import Foundation

public struct Person {
    public let firstName: String
    public let lastName: String
    
    public var fullName: String {
        "\(firstName) \(lastName)"
    }
    
    public init(firstName: String, lastName: String) {
        self.firstName = firstName
        self.lastName = lastName
    }
}
