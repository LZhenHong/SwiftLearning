import Foundation

// API
// Access Control
public protocol Account {
    associatedtype Currency
    
    var balance: Currency { get }
    func deposit(amount: Currency)
    func withdraw(amount: Currency)
}

public typealias Dollars = Double

// For a class, method or property to be overridden by code in another module, it is required to be declared open.
open class BasicAccount: Account {
    // The setter of balance is made private.
    public private(set) var balance: Dollars = 0.0
    
    public init() {}
    
    public func deposit(amount: Dollars) {
        balance += amount
    }
    
    public func withdraw(amount: Dollars) {
        if amount <= balance {
            balance -= amount
        } else {
            balance = 0
        }
    }
}
