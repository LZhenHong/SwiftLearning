import Cocoa

protocol Exercise: CustomStringConvertible {
    var caloriesBurned: Double { get set }
    var minutes: Double { get set }
    var title: String { get }
}

// default implementation for protocol
extension Exercise {
    var description: String {
        return "Exercise(\(Self.self), burned \(caloriesBurned) calories in \(minutes) minutes)"
    }
}

extension Exercise {
    var caloriesBurnedPerMinute: Double {
        return caloriesBurned / minutes
    }
}

extension Exercise {
    var title: String {
        return "\(Self.self) - \(minutes) minutes"
    }
}

extension Exercise {
    func adding(calories: Double) -> Self {
        var dupe = self
        dupe.caloriesBurned += calories
        return dupe
    }
}

struct EllipticalWorkout: Exercise {
    var caloriesBurned: Double
    var minutes: Double
}

let ellipticalWorkout = EllipticalWorkout(caloriesBurned: 335, minutes: 30)
print(ellipticalWorkout.caloriesBurnedPerMinute)
print(ellipticalWorkout)

struct RunningWorkout: Exercise {
    let title = "Gotta go fast!"
    var caloriesBurned: Double
    var minutes: Double
    var meters: Double
    
    var description: String {
        return "RunningWorkout(\(caloriesBurned) calories and \(meters)m in \(minutes) minutes)"
    }
}

let runningWorkout = RunningWorkout(caloriesBurned: 350, minutes: 25, meters: 5000)
print(runningWorkout.caloriesBurnedPerMinute)
print(runningWorkout)

let runningCopy = runningWorkout.adding(calories: 100)

let tenKRun: RunningWorkout = RunningWorkout(caloriesBurned: 750, minutes: 60, meters: 10000)
let workout: Exercise = tenKRun
print(tenKRun.title)
print(workout.title)

// MARK: - where Clauses
extension Sequence where Element == Exercise {
    func totalCaloriesBurned() -> Double {
        var total: Double = 0
        for exercise in self {
            total += exercise.caloriesBurned
        }
        return total
    }
}

extension Collection where Element == Exercise {
    func count(where predicate: (Element) -> Bool) -> Int {
        var total: Int = 0
        for exercise in self where predicate(exercise) {
            total += 1
        }
        return total
    }
}
let workouts: [Exercise] = [ellipticalWorkout, runningWorkout, tenKRun]
let hardWorkoutCount = workouts.count(where: { $0.caloriesBurned >= 500})
print(hardWorkoutCount)

extension Sequence where Element == Int {
    var sum: Int {
        var total = 0
        for item in self {
            total += item
        }
        return total
    }
}
