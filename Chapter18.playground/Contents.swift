import UIKit
import XCTest

// The internal access level means that an entity can be accessed from anywhere within the software module in which it’s defined.

let johnChecking = CheckingAccount()
johnChecking.deposit(amount: 300.0)

let check = johnChecking.writeCheck(amount: 200.0)!

let janeChecking = CheckingAccount()
janeChecking.deposit(check)
janeChecking.balance

janeChecking.deposit(check)
janeChecking.balance

// open 申明的方法、属性或者类可以被其他模块重写，继承；public 申明的不行
class SavingAccount: BasicAccount {
    var interestRate: Double
    private let pin: Int
    
    @available(*, deprecated, message: "Use init(interestRate:pin:) instead")
    init(interestRate: Double) {
        self.interestRate = interestRate
        self.pin = 0
    }
    
    init(interestRate: Double, pin: Int) {
        self.interestRate = interestRate
        self.pin = pin
    }
    
    @available(*, deprecated, message: "Use processInterest(pin:) instead")
    func processInterest() {
        let interest = balance * interestRate
        deposit(amount: interest)
    }
    
    func processInterest(pin: Int) {
        if pin == self.pin {
            let interest = balance * interestRate
            deposit(amount: interest)
        }
    }
}

let person = Person(firstName: "Levine", lastName: "Eden")
person.firstName
person.lastName
person.fullName

class Doctor: ClassyPerson {
    override var fullName: String {
        "Dr. \(firstName) \(lastName)"
    }
}
let doctor = Doctor(firstName: "Levine", lastName: "Eden")
doctor.firstName
doctor.lastName
doctor.fullName

// opaque return type
func createAccount() -> some Account {
    CheckingAccount()
}

// Unit tests help you verify that you don’t break anything.
class BankingTests: XCTestCase {
    var checkingAccount: CheckingAccount!
    
    // setUp method is executed before each test, and its purpose is to initialize the needed state for the tests to run.
    override func setUp() {
        super.setUp()
        checkingAccount = CheckingAccount()
    }
    
    // Adding tests to a test class is super easy - just add a function that starts with the word test, takes no arguments and returns nothing.
    func testNewAccountBalanceZero() {
        XCTAssertEqual(checkingAccount.balance, 0)
    }
    
    func testCheckOverBudgetFails() {
        let check = checkingAccount.writeCheck(amount: 100)
        XCTAssertNil(check)
    }
    
    func testNewAPI() throws {
        guard #available(iOS 14, *) else {
            throw XCTSkip("Only available in iOS 14 and above")
        }
    }
    
    // Similarly to how setUp is executed before each test, tearDown runs after every test regardless of whether the test passes or fails.
    override func tearDown() {
        checkingAccount.withdraw(amount: checkingAccount.balance)
        super.tearDown()
    }
}
BankingTests.defaultTestSuite.run()

final fileprivate class Logger {
    static let sharedLogger = Logger()
    
    private init() {}
    
    func log(_ logMsg: String) {
        print(logMsg)
    }
}

struct Stack<T> {
    private var innerArray: [T] = []
    
    var count: Int {
        innerArray.count
    }
    
    mutating func push(_ element: T) {
        innerArray.append(element)
    }
    
    mutating func pop() -> T? {
        guard !innerArray.isEmpty else {
            return nil
        }
        return innerArray.removeLast()
    }
    
    func peek() -> T? {
        innerArray.last
    }
}
