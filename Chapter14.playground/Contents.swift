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
}

class Student: Person {
    var grades: [Grade] = []
    
    func recordGrade(_ grade: Grade) {
        grades.append(grade)
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

class NewStudent: Student {}

class NewStudentAthlete: NewStudent {
    var sports: [String]
    
    // Initializers in subclasses are required to call super.init
    init(firstName: String, lastName: String, sports: [String]) {
        self.sports = sports
        super.init(firstName: firstName, lastName: lastName)
        
        let passGrade = Grade(letter: "P", points: 0.0, credits: 0.0)
        recordGrade(passGrade)
    }
}
