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

protocol Tieable {
    var ties: Int { get }
}

extension TeamRecord where Self: Tieable {
    var winningPercentage: Double  {
        Double(wins) / Double(wins + ties + losses)
    }
}

struct HockeyRecord: TeamRecord, Tieable {
    var wins: Int
    var losses: Int
    var ties: Int
}

let chicagoOptionals = BaseballRecord(wins: 10, losses: 6)
chicagoOptionals.winningPercentage
let phoenixStridables = HockeyRecord(wins: 8, losses: 7, ties: 1)
phoenixStridables.winningPercentage

struct RugbyRecord: TeamRecord, Tieable {
    var wins: Int
    var losses: Int
    var ties: Int
}

let rugbyRecord = RugbyRecord(wins: 8, losses: 7, ties: 1)
rugbyRecord.winningPercentage

extension CustomStringConvertible {
    var description: String {
        "Remember to implement CustomStringConvertible!"
    }
}

extension CustomStringConvertible where Self: TeamRecord {
    var description: String {
        "\(wins) - \(losses)"
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

protocol PostSeasonEligible {
    var minimumWinsForPlayoffs: Int { get }
}

extension TeamRecord where Self: PostSeasonEligible {
    var isPlayoffEligible: Bool {
        wins > minimumWinsForPlayoffs
    }
}

protocol TieableRecord {
    var ties: Int { get }
}

protocol DivisionalRecord {
    var divisionalWins: Int { get }
    var divisionalLosses: Int { get }
}

protocol ScoreableRecord {
    var totalPoints: Int { get }
}

extension ScoreableRecord where Self: TieableRecord, Self: TeamRecord {
    var totalPoints: Int {
        (2 * wins) + (1 * ties)
    }
}

struct NewHockeyRecord: TeamRecord, TieableRecord, DivisionalRecord, CustomStringConvertible, Equatable {
    var wins: Int
    var losses: Int
    var ties: Int
    var divisionalWins: Int
    var divisionalLosses: Int
    
    var description: String {
        "\(wins) - \(losses) - \(ties)"
    }
}

protocol Item: CustomStringConvertible {
    var name: String { get }
    var clearance: Bool { get }
    var msrp: Double { get }
    var totalPrice: Double { get }
}

protocol Taxable: Item {
    var taxPercentage: Double { get }
}

protocol Discountable: Item {
    var adjustedMsrp: Double { get }
}

extension Item {
    var description: String {
        name
    }
}

extension Item {
    var totalPrice: Double {
        msrp
    }
}

extension Item where Self: Taxable {
    var totalPrice: Double {
        msrp * (1 + taxPercentage)
    }
}

extension Item where Self: Discountable {
    var totalPrice: Double {
        adjustedMsrp
    }
}

extension Item where Self: Taxable & Discountable {
    var totalPrice: Double {
        adjustedMsrp * (1 + taxPercentage)
    }
}

struct Clothing: Discountable {
    let name: String
    var msrp: Double
    var clearance: Bool
    
    var adjustedMsrp: Double {
        msrp * (clearance ? 0.75 : 1.0)
    }
}

struct Electronics: Taxable, Discountable {
    let name: String
    var msrp: Double
    var clearance: Bool
    
    let taxPercentage: Double = 0.075
    
    var adjustedMsrp: Double {
        msrp * (clearance ? 0.95 : 1.0)
    }
}

struct Food: Taxable, Discountable {
    let name: String
    var msrp: Double
    var clearance: Bool
    
    let expirationDate: (month: Int, year: Int)
    
    let taxPercentage: Double = 0.075
    
    var adjustedMsrp: Double {
        msrp * (clearance ? 0.50 : 1.0)
    }
    
    var description: String {
        "\(name) - expires \(expirationDate.month)/\(expirationDate.year)"
    }
}

Food(name: "Bread", msrp: 2.99, clearance: false, expirationDate: (11, 2016)).totalPrice
Clothing(name: "Shirt", msrp: 12.99, clearance: true).totalPrice
Clothing(name: "Last season shirt", msrp: 12.99, clearance: false).totalPrice
Electronics(name: "Apple TV", msrp: 139.99, clearance: false).totalPrice
Electronics(name: "Apple TV 3rd gen", msrp: 99.99, clearance: true).totalPrice

// Custom string convertible demonstration
Food(name: "Bread", msrp: 2.99, clearance: false, expirationDate: (11, 2016))
Electronics(name: "Apple TV 3rd gen", msrp: 99.99, clearance: true)

extension Sequence where Element: Numeric {
    func double() -> [Element] {
        self.map { $0 * 2 }
    }
}
