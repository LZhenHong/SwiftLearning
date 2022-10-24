import Cocoa

var str = "Hello, playground"
var playgroundGreeting = str
playgroundGreeting += "! How are you today?"
str

class Employee {
    var id: Int = 0
}

let anika = Employee()
let theBoss = anika
anika.id = 16
anika.id
theBoss.id

// avoid using reference type properties inside value types.
struct Company {
    var boss: Employee
}

let acme = Company(boss: anika)
acme.boss.id
let widgetCo = acme
anika.id = 15
widgetCo.boss.id

let mel = Employee()
mel.id = 86
mel.id

// Swift 都是浅拷贝
let juampa = Employee()
let employees = [anika, mel, juampa]
let partyGoers = employees
employees.last?.id = 4
employees
partyGoers

acme.boss === anika

let joe = Employee()
let sam = Employee()
joe === sam
