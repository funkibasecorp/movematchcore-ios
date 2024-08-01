//
//  Exercise.swift
//  spotmatch
//
//  Created by Chris Jones on 6/12/24.
//

import Foundation


struct Exercise: Identifiable, Codable, Equatable {
    var id = UUID()
    var name: String
    var duration: TimeInterval
    let oneRM: String
    let reps: String
    let rest: String
    let type: ExerciseType
    let creator: User
    
    static func == (lhs: Exercise, rhs: Exercise) -> Bool {
        return lhs.id == rhs.id &&
               lhs.name == rhs.name &&
               lhs.duration == rhs.duration
    }
}

enum ExerciseType: Int, Codable, Identifiable, Hashable {
    case cardio
    case strength
    case flexibility
    case balance
    case mobility
    
    var id: Int { return self.rawValue }
}

let mockExerciseData: [Exercise] = [
        Exercise(
            name: "Running",
            duration: 30.0,
            oneRM: "N/A",
            reps: "N/A",
            rest: "1 minute",
            type: .cardio,
            creator: sampleUsers[0]
        ),
        Exercise(
            name: "Bench Press",
            duration: 15.0,
            oneRM: "100kg",
            reps: "5",
            rest: "2 minutes",
            type: .strength,
            creator: sampleUsers[1]
        ),
        Exercise(
            name: "Yoga",
            duration: 45.0,
            oneRM: "N/A",
            reps: "N/A",
            rest: "30 seconds",
            type: .flexibility,
            creator: sampleUsers[1]
        ),
        Exercise(
            name: "Plank",
            duration: 60.0,
            oneRM: "N/A",
            reps: "1",
            rest: "1 minute",
            type: .balance,
            creator: sampleUsers[1]
        ),
        Exercise(
            name: "Foam Rolling",
            duration: 10.0,
            oneRM: "N/A",
            reps: "N/A",
            rest: "N/A",
            type: .mobility,
            creator: sampleUsers[1]
        )
    ]
