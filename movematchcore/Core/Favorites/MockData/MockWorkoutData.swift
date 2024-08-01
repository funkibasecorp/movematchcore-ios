//
//  MockFavoritesData.swift
//  spotmatch
//
//  Created by Chris Jones on 5/17/24.
//

import Foundation

struct MockWorkoutData {
    static let collections: [WorkoutCollection] = [
        WorkoutCollection(
            title: "My Workouts",
            workouts: [
                Workout(
                    name: "Workout 1",
                    exercises: [
                        Exercise(name: "HIGH KNEES", duration: 20, oneRM: "N/A", reps: "10-12", rest: "20 sec.", type: .cardio, creator: sampleUsers[0]),
                        Exercise(name: "SQUATS", duration: 45, oneRM: "100 kg", reps: "8-10", rest: "30 sec.", type: .strength, creator: sampleUsers[0]),
                        Exercise(name: "PLANK", duration: 60, oneRM: "N/A", reps: "N/A", rest: "60 sec.", type: .flexibility, creator: sampleUsers[0])
                    ],
                    duration: 25.0,
                    intensity: .medium,
                    muscle: "Full Body"
                ),
                Workout(
                    name: "Workout 2",
                    exercises: [
                        Exercise(name: "HIGH KNEES", duration: 20, oneRM: "N/A", reps: "10-12", rest: "20 sec.", type: .cardio, creator: sampleUsers[0]),
                        Exercise(name: "SQUATS", duration: 45, oneRM: "100 kg", reps: "8-10", rest: "30 sec.", type: .strength, creator: sampleUsers[0]),
                        Exercise(name: "PLANK", duration: 60, oneRM: "N/A", reps: "N/A", rest: "60 sec.", type: .flexibility, creator: sampleUsers[0])
                    ],
                    duration: 25.0,
                    intensity: .medium,
                    muscle: "Full Body"
                )
            ],
            emoji: "❤️",
            color: .red
        ),
        WorkoutCollection(
            title: "Tim's Workouts",
            workouts: [],
            emoji: "😐",
            color: .orange
        ),
        WorkoutCollection(
            title: "Cardio",
            workouts: [
                Workout(
                    name: "Cardio 1",
                    exercises: [
                        Exercise(name: "HIGH KNEES", duration: 20, oneRM: "N/A", reps: "10-12", rest: "20 sec.", type: .cardio, creator: sampleUsers[0]),
                        Exercise(name: "SQUATS", duration: 45, oneRM: "100 kg", reps: "8-10", rest: "30 sec.", type: .strength, creator: sampleUsers[0]),
                        Exercise(name: "PLANK", duration: 60, oneRM: "N/A", reps: "N/A", rest: "60 sec.", type: .flexibility, creator: sampleUsers[0])
                    ],
                    duration: 15.0,
                    intensity: .high,
                    muscle: "Cardiovascular"
                )
            ],
            emoji: "🏃",
            color: .green
        ),
        WorkoutCollection(
            title: "Back",
            workouts: [
                Workout(
                    name: "Back 1",
                    exercises: [
                        Exercise(name: "HIGH KNEES", duration: 20, oneRM: "N/A", reps: "10-12", rest: "20 sec.", type: .cardio, creator: sampleUsers[0]),
                        Exercise(name: "SQUATS", duration: 45, oneRM: "100 kg", reps: "8-10", rest: "30 sec.", type: .strength, creator: sampleUsers[0]),
                        Exercise(name: "PLANK", duration: 60, oneRM: "N/A", reps: "N/A", rest: "60 sec.", type: .flexibility, creator: sampleUsers[0])
                    ],
                    duration: 15.0,
                    intensity: .high,
                    muscle: "Back"
                ),
                Workout(
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
            ],
            emoji: "🏋️‍♂️",
            color: .blue
        ),
        WorkoutCollection(
            title: "Yoga",
            workouts: [
                Workout(
                    name: "Yoga 1",
                    exercises: [
                        Exercise(name: "HIGH KNEES", duration: 20, oneRM: "N/A", reps: "10-12", rest: "20 sec.", type: .cardio, creator: sampleUsers[0]),
                        Exercise(name: "SQUATS", duration: 45, oneRM: "100 kg", reps: "8-10", rest: "30 sec.", type: .strength, creator: sampleUsers[0]),
                        Exercise(name: "PLANK", duration: 60, oneRM: "N/A", reps: "N/A", rest: "60 sec.", type: .flexibility, creator: sampleUsers[0])
                    ],
                    duration: 10.0,
                    intensity: .low,
                    muscle: "Full Body"
                )
            ],
            emoji: "🧘‍♀️",
            color: .purple
        ),
        WorkoutCollection(
            title: "Premium workouts",
            workouts: [],
            emoji: "👑",
            color: .yellow
        )
    ]
}
