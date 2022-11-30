import UIKit

protocol TeamRecord {
    var wins: Int { get }
    var losses: Int { get }
    var winningPercentage: Double { get }
}

extension TeamRecord {
    var gamesPlayed: Int {
        wins + losses
    }
}

extension TeamRecord {
    var winningPercentage: Double {
        Double(wins) / Double(wins + losses)
    }
}

struct BaseballRecord: TeamRecord {
    var wins: Int
    var losses: Int
}

let sanFranciscoSwifts = BaseballRecord(wins: 10, losses: 5)
sanFranciscoSwifts.gamesPlayed

struct BasketballRecord: TeamRecord {
    var wins: Int
    var losses: Int
    let seasonLength = 82
}

let minneapolisFunctors = BaseballRecord(wins: 60, losses: 22)
minneapolisFunctors.winningPercentage

struct HockeyRecord: TeamRecord {
    var wins: Int
    var losses: Int
    var ties: Int
    
    var winningPercentage: Double  {
        Double(wins) / Double(wins + ties + losses)
    }
}

let chicagoOptionals = BaseballRecord(wins: 10, losses: 6)
chicagoOptionals.winningPercentage
let phoenixStridables = HockeyRecord(wins: 8, losses: 7, ties: 1)
phoenixStridables.winningPercentage

extension CustomStringConvertible {
    var description: String {
        "Remember to implement CustomStringConvertible!"
    }
}

protocol WinLoss {
    var wins: Int { get }
    var losses: Int { get }
}

extension WinLoss {
    var winningPercentage: Double {
        Double(wins) / Double(wins + losses)
    }
}

struct CricketRecord: WinLoss {
    var wins: Int
    var losses: Int
    var draws: Int
    
    var winningPercentage: Double {
        Double(wins) / Double(wins + losses + draws)
    }
}

let miamiTuples = CricketRecord(wins: 8, losses: 7, draws: 1)
let winloss: WinLoss = miamiTuples

miamiTuples.winningPercentage
winloss.winningPercentage
