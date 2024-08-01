//
//  MockExerciseData.swift
//  spotmatch
//
//  Created by Chris Jones on 5/17/24.
//

import SwiftUI

struct MockExerciseData {
    static let collections: [ExerciseCollection] = [
        ExerciseCollection(
            title: "My Exercises",
            exercises: [
                Exercise(name: "HIGH KNEES", duration: 20, oneRM: "N/A", reps: "10-12", rest: "20 sec.", type: .cardio, creator: sampleUsers[0]),
                Exercise(name: "SQUATS", duration: 45, oneRM: "100 kg", reps: "8-10", rest: "30 sec.", type: .strength, creator: sampleUsers[0]),
                Exercise(name: "PLANK", duration: 60, oneRM: "N/A", reps: "N/A", rest: "60 sec.", type: .flexibility, creator: sampleUsers[0])
            ],
            emoji: "❤️",
            color: .red
        ),
        ExerciseCollection(
            title: "Tim’s Exercises",
            exercises: [],
            emoji: "😐",
            color: .orange
        ),
        ExerciseCollection(
            title: "Cardio Exercises",
            exercises: [
                Exercise(name: "HIGH KNEES", duration: 20, oneRM: "N/A", reps: "10-12", rest: "20 sec.", type: .cardio, creator: sampleUsers[0]),
            ],
            emoji: "🏃",
            color: .green
        ),
        ExerciseCollection(
            title: "Back Exercises",
            exercises: [
                Exercise(name: "HIGH KNEES", duration: 20, oneRM: "N/A", reps: "10-12", rest: "20 sec.", type: .cardio, creator: sampleUsers[0]),

            ],
            emoji: "🏋️‍♂️",
            color: .blue
        ),
        ExerciseCollection(
            title: "Yoga Exercises",
            exercises: [
            ],
            emoji: "🧘‍♀️",
            color: .purple
        ),
        ExerciseCollection(
            title: "Premium Exercises",
            exercises: [],
            emoji: "👑",
            color: .yellow
        )
    ]
}
