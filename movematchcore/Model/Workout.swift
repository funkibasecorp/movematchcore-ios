//
//  Workout.swift
//  spotmatch
//
//  Created by Chris Jones on 6/12/24.
//

import Foundation

struct Workout: Identifiable, Codable {
    let id = UUID()
    let name: String
    let exercises: [Exercise]
    let duration: Double
    let intensity: IntensityLevel
    var muscle: String
}

enum IntensityLevel: Int, Codable, Identifiable, Hashable {
    case low
    case medium
    case high
    
    var id: Int { return self.rawValue }
}

extension Workout {
    static var testWorkout1 = Workout(
        name: "Back 2",
        exercises: [
            Exercise(name: "HIGH KNEES", duration: 20, oneRM: "N/A", reps: "10-12", rest: "20 sec.", type: .cardio, creator:sampleUsers[0]),
            Exercise(name: "SQUATS", duration: 45, oneRM: "100 kg", reps: "8-10", rest: "30 sec.", type: .strength, creator:sampleUsers[0]),
            Exercise(name: "PLANK", duration: 60, oneRM: "N/A", reps: "N/A", rest: "60 sec.", type: .flexibility, creator: sampleUsers[0])
        ],
        duration: 15.0,
        intensity: .medium,
        muscle: "Back"
    )
}
