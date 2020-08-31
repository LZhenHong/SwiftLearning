import Foundation

enum GameCharacterType {
    case elf
    case giant
    case wizard
}

protocol GameCharacter: class {
    var name: String { get }
    var hitPoints: Int { get }
    var attackPoints: Int { get }
}

class Elf: GameCharacter {
    let name = "Elf"
    var hitPoints = 3
    let attackPoints = 10
}

class Giant: GameCharacter {
    let name = "Giant"
    var hitPoints = 10
    let attackPoints = 3
}

class Wizard: GameCharacter {
    let name = "Wizard"
    var hitPoints = 5
    let attackPoints = 5
}

struct GameCharacterFactory {
    static func make(ofType: GameCharacterType) -> GameCharacter {
        switch ofType {
        case .elf:
            return Elf()
        case .giant:
            return Giant()
        case .wizard:
            return Wizard()
        }
    }
}

func battle(_ firstCharacter: GameCharacter, vs secondCharacter: GameCharacter) {
    secondCharacter.hitPoints -= firstCharacter.attackPoints
    
    if secondCharacter.hitPoints <= 0 {
        print("\(secondCharacter.name) defeated!")
    }
    
    firstCharacter.hitPoints -= secondCharacter.attackPoints
    if firstCharacter.hitPoints <= 0 {
        print("\(firstCharacter.name) defeated!")
    } else {
        print("Both players still active!")
    }
}
