import Cocoa

protocol TabularDataSource {
    var numberOfRows: Int { get }
    var numberOfColumns: Int { get }
    
    func label(forColumn column: Int) -> String;
    func itemFor(row: Int, column: Int) -> String;
}

func printTable(_ dataSource: TabularDataSource & CustomStringConvertible) {
    print("Table: \(dataSource)")

    var headerRow = "|"
    
    var columnWidths = [Int]()
    
    for i in 0..<dataSource.numberOfColumns {
        let columnLabel = dataSource.label(forColumn: i)
        let columnHeader = " \(columnLabel) |"
        headerRow += columnHeader
        columnWidths.append(columnLabel.count)
    }
    print(headerRow)
    
    for i in 0..<dataSource.numberOfRows {
        var out = "|"
        for j in 0..<dataSource.numberOfColumns {
            let item = dataSource.itemFor(row: i, column: j)
            let paddingNeeded = columnWidths[j] - item.count
            let padding = paddingNeeded > 0 ? repeatElement(" ", count: paddingNeeded).joined() : ""
            out += " \(padding)\(item) |"
        }
        print(out)
    }
}

struct Person {
    let name: String
    let age: Int
    let yearsOfExperience: Int
}

struct Department {
    let name: String
    var people: [Person] = []
    
    init(name: String) {
        self.name = name
    }
    
    mutating func add(_ person: Person) {
        people.append(person)
    }
}

extension Department: TabularDataSource, CustomStringConvertible {
    var numberOfRows: Int {
        return people.count
    }
    
    var numberOfColumns: Int {
        return 3
    }
    
    var description: String {
        return "Department: (\(name))"
    }
    
    func label(forColumn column: Int) -> String {
        switch column {
        case 0:
            return "Employee Name"
        case 1:
            return "Age"
        case 2:
            return "Years of Experience"
        default:
            fatalError("Invalid column!")
        }
    }
    
    func itemFor(row: Int, column: Int) -> String {
        let person = people[row]
        switch column {
        case 0:
            return person.name
        case 1:
            return String(person.age)
        case 2:
            return String(person.yearsOfExperience)
        default:
            fatalError("Invalid column!")
        }
    }
}

var department = Department(name: "Engineering")
department.add(Person(name: "Eva", age: 30, yearsOfExperience: 6))
department.add(Person(name: "Saleh", age: 4000, yearsOfExperience: 18))
department.add(Person(name: "Amit", age: 50, yearsOfExperience: 20))
printTable(department)

let engineeringDataSource = department as TabularDataSource

let mikey = Person(name: "Mikey", age: 37, yearsOfExperience: 10)
mikey is TabularDataSource
