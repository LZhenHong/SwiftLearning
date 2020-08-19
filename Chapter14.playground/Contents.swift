import UIKit

struct Grade {
    var letter: Character
    var points: Double
    var credits: Double
}

class Person {
    var firstName: String
    var lastName: String
    
    init(firstName: String, lastName: String) {
        self.firstName = firstName
        self.lastName = lastName
    }
    
    deinit {
        print("\(firstName) \(lastName) is being removed from memory!")
    }
}

class Student: Person {
    var grades: [Grade] = []
    weak var partner: Student?
    
    static var graduates: [String] = []
    
    func recordGrade(_ grade: Grade) {
        grades.append(grade)
    }
    
    deinit {
        Student.graduates.append("\(firstName) \(lastName)")
    }
}

let john = Person(firstName: "Johnny", lastName: "Appleseed")
let jane = Student(firstName: "Jane", lastName: "Appleseed")

john.firstName
jane.firstName

let history = Grade(letter: "B", points: 9.0, credits: 3.0)
jane.recordGrade(history)

// A Swift class can inherit from only one other class, a concept known as single inheritance.

class BandMember: Student {
    var minimumPracticeTime = 2
}

class OboePlayer: BandMember {
    override var minimumPracticeTime: Int {
        get {
            super.minimumPracticeTime * 2
        }
        set {
            super.minimumPracticeTime = newValue / 2
        }
    }
}

func phonebookName(_ person: Person) -> String {
    "\(person.lastName), \(person.firstName)"
}

let person = Person(firstName: "Johnny", lastName: "Appleseed")
let oboePlayer = OboePlayer(firstName: "Jane", lastName: "Appleseed")

phonebookName(person)
phonebookName(oboePlayer)

var hallMonitor = Student(firstName: "Jill", lastName: "Bananapeel")
hallMonitor = oboePlayer

oboePlayer as Student

hallMonitor as? BandMember
(hallMonitor as? BandMember)?.minimumPracticeTime

if let hallMonitor = hallMonitor as? BandMember {
    print("This hall monitor is a band member and practices at least \(hallMonitor.minimumPracticeTime) hours per week.")
}

func afterClassActivity(for student: Student) -> String {
    "Goes home!"
}

func afterClassActivity(for student: BandMember) -> String {
    "Goes to practice!"
}

afterClassActivity(for: oboePlayer)
afterClassActivity(for: oboePlayer as Student)

class StudentAthlete: Student {
    var failedClasses: [Grade] = []
    
    override func recordGrade(_ grade: Grade) {
        super.recordGrade(grade)
        
        if grade.letter == "F" {
            failedClasses.append(grade)
        }
    }
    
    var isEligible: Bool {
        failedClasses.count < 3
    }
}

// final keyword can remind you — or others on your team! — that a class wasn’t designed to have subclasses.
final class FinalStudent: Person {}

class AnotherStudent: Person {
    final func recordGrade(_ grade: Grade) {}
}

class NewStudent {
    let firstName: String
    let lastName: String
    var grades: [Grade] = []
    
    // This keyword will force all subclasses of NewStudent to implement this initializer.
    required init(firstName: String, lastName: String) {
        self.firstName = firstName
        self.lastName = lastName
    }
    
    // The compiler forces a convenience initializer to call a non-convenience initializer (directly or indirectly)
    convenience init(transfer: NewStudent) {
        self.init(firstName: transfer.firstName, lastName: transfer.lastName)
    }
    
    func recordGrade(_ grade: Grade) {
        grades.append(grade)
    }
}

class NewStudentAthlete: NewStudent {
    var sports: [String]
    
    required init(firstName: String, lastName: String) {
        self.sports = []
        super.init(firstName: firstName, lastName: lastName)
    }
    
    // Initializers in subclasses are required to call super.init
    init(firstName: String, lastName: String, sports: [String]) {
        self.sports = sports
        super.init(firstName: firstName, lastName: lastName)
        
        let passGrade = Grade(letter: "P", points: 0.0, credits: 0.0)
        recordGrade(passGrade)
    }
}

class Team {
    var players: [StudentAthlete] = []
    
    var isEligible: Bool {
        for player in players {
            if !player.isEligible {
                return false
            }
        }
        return true
    }
}

class Button {
    func press() {}
}

class Image {}

class ImageButton: Button {
    var image: Image
    
    init(image: Image) {
        self.image = image
    }
}

class TextButton: Button {
    var text: String
    
    init(text: String) {
        self.text = text
    }
}

// 引用计数
// automatic reference counting or ARC
// While some older languages require you to increment and decrement reference counts in your code, the Swift compiler adds these calls automatically at compile time.

// Weak references must be declared as optional types so that when the object that they are referencing is released, it automatically becomes nil.

class A {
    required init() {
        print("I'm <A>!")
    }
    
    deinit {
        print("Deinit A!")
    }
}

class B: A {
    required init() {
        print("I'm <B>!")
        super.init()
        print("I'm <B> later!")
    }
    
    deinit {
        print("Deinit B!")
    }
}

class C: B {
    required init() {
        print("I'm <C>!")
        super.init()
        print("I'm <C> later!")
    }
    
    deinit {
        print("Deinit C!")
    }
}

var c: C? = C()
c = nil

let anotherC = C()
let castA = anotherC as A

let a = A()
let castC = a as? C

struct Location {
    let x: Int
    let y: Int
}

class StudentBaseballPlayer: StudentAthlete {
    var position: Location = Location(x: 0, y: 0)
    var number: Int = 0
    var battingAverage: Double = 0.0
}
