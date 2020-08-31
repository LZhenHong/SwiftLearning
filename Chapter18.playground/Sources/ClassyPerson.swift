import Foundation

open class ClassyPerson {
    public let firstName: String
    public let lastName: String
    
    open var fullName: String {
        "\(firstName) \(lastName)"
    }
    
    public init(firstName: String, lastName: String) {
        self.firstName = firstName
        self.lastName = lastName
    }
}
