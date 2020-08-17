import UIKit

// While you’ll often use structures in your apps to represent values, you’ll generally use classes to represent objects.
class Person {
    var firstName: String
    var lastName: String
    
    // Unlike a struct, a class doesn’t provide a memberwise initializer automatically — which means you must provide it yourself if you need it.
    init(firstName: String, lastName: String) {
        self.firstName = firstName
        self.lastName = lastName
    }
    
    var fullName: String {
        return "\(firstName) \(lastName)"
    }
}

let john = Person(firstName: "Johnny", lastName: "Appleseed")
john.fullName

// Classes are reference types, so a variable of a class type doesn’t store an actual instance — it stores a reference to a location in memory that stores the instance.
class SimplePerson {
    let name: String
    
    init(name: String) {
        self.name = name
    }
}
var person1 = SimplePerson(name: "John")
var person2 = person1

// A structure as a value type stores the actual value, providing direct access to it.
struct SimplePersonStruct {
    let name: String
}
var structPerson1 = SimplePersonStruct(name: "John")
var structPerson2 = structPerson1

// 堆 VS 栈
// heap VS stack
// The system uses the stack to store anything on the immediate thread of execution; it’s tightly managed and optimized by the CPU.
// The system uses the heap to store instances of reference types. The heap is generally a large pool of memory from which the system can request and dynamically allocate blocks of memory.
var homeOwner = john
john.firstName = "John"
john.firstName
homeOwner.firstName

// The === identity operator compares the memory address of two references.
john === homeOwner

let imposterJohn = Person(firstName: "Johnny", lastName: "Appleseed")
john === homeOwner
john === imposterJohn
imposterJohn === homeOwner

homeOwner = imposterJohn
john === homeOwner

homeOwner = john
john === homeOwner

func memberOf(person: Person, group: [Person]) -> Bool {
    group.contains {
        $0 === person
    }
}

struct Grade {
    let letter: String
    let points: Double
    let credits: Double
}

class Student {
    var firstName: String
    var lastName: String
    var credits = 0.0
    var grades: [Grade] = []
    
    var gpa: Double {
        var points = 0.0
        var credits = 0.0
        grades.forEach {
            points += $0.points
            credits += $0.credits
        }
        return (points / credits)
    }
    
    init(firstName: String, lastName: String) {
        self.firstName = firstName
        self.lastName = lastName
    }
    
    func recordGrade(_ grade: Grade) {
        grades.append(grade)
        credits += grade.credits
    }
}
let jane = Student(firstName: "Jane", lastName: "Appleseed")
let history = Grade(letter: "B", points: 9.0, credits: 3.0)
let math = Grade(letter: "A", points: 16.0, credits: 4.0)
jane.recordGrade(history)
jane.recordGrade(math)
jane.gpa

// Remember, when you change the value of a struct, instead of modifying the value, you’re making a new value. The keyword mutating marks methods that replace the current value with a new one.

// Classes can be re-opened using the extension keyword to add methods and computed properties.
extension Student {
    var fullName: String {
        "\(firstName) \(lastName)"
    }
}

// ----- Challenge -----
class List {
    let name: String
    var movieTitles: [String] = []
    
    init(name: String) {
        self.name = name
    }
    
    func printMovieTitles() {
        movieTitles.forEach {
            print($0)
        }
    }
}

class User {
    var movieLists: [String: List] = [:]
    
    func addList(_ list: List) {
        movieLists[list.name] = list
    }
    
    func list(forName name: String) -> List? {
        return movieLists[name]
    }
}

struct TShirt {
    let size: Int
    let color: String
    let price: Double
    let image: String?
}

struct Address {
    let name: String
    let street: String
    let city: String
    let zipCode: String
}

class ShoppingCart {
    var currentOrder: String
    var address: Address
    var tShirts: [TShirt] = []
    
    var totalCost: Double {
        tShirts.reduce(0.0) {
            $0 + $1.price
        }
    }
    
    init(order: String, address: Address) {
        self.currentOrder = order
        self.address = address
    }
}

class TShirtUser {
    var name: String
    var email: String
    var shoppingCart: ShoppingCart
    
    init(name: String, email: String, cart: ShoppingCart) {
        self.name = name
        self.email = email
        self.shoppingCart = cart
    }
}


