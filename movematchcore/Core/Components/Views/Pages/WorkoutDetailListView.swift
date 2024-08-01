//
//  WorkoutDetailListView.swift
//  spotmatch
//
//  Created by Chris Jones on 6/16/24.
//
import SwiftUI

struct WorkoutDetailListView: View {
    let exercises: [Exercise]
    
    var body: some View {
        VStack(alignment: .leading) {
            Text("Exercises")
                .font(.title2)
                .bold()
                .padding(.leading)
                .padding(.top)
            
            ScrollView {
                VStack(spacing: 16) {
                    ForEach(exercises) { exercise in
                        ExerciseView(exercise: exercise)
                    }
                }
                .padding()
            }
        }
        .background(Color(.systemGray6))
        .cornerRadius(20)
        .padding()
    }
}

struct ExerciseView: View {
    let exercise: Exercise
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(exercise.name)
                .font(.headline)
                .foregroundColor(.black)
            
            HStack {
                VStack(alignment: .leading, spacing: 4) {
                    Text(exercise.oneRM)
                        .font(.body)
                        .foregroundColor(.black)
                    Text("1RM")
                        .font(.caption)
                        .foregroundColor(.gray)
                }
                
                Spacer()
                
                VStack(alignment: .leading, spacing: 4) {
                    Text(exercise.reps)
                        .font(.body)
                        .foregroundColor(.black)
                    Text("Reps")
                        .font(.caption)
                        .foregroundColor(.gray)
                }
                
                Spacer()
                
                VStack(alignment: .leading, spacing: 4) {
                    Text(exercise.rest)
                        .font(.body)
                        .foregroundColor(.black)
                    Text("Rest")
                        .font(.caption)
                        .foregroundColor(.gray)
                }
            }
            
            HStack {
                Text("Type: \(exercise.type)")
                    .font(.caption)
                    .foregroundColor(.gray)
                Spacer()
                Text("Creator: \(exercise.creator.name)")
                    .font(.caption)
                    .foregroundColor(.gray)
            }
        }
        .padding()
        .background(Color.white)
        .cornerRadius(12)
        .shadow(color: Color.gray.opacity(0.3), radius: 5, x: 0, y: 2)
    }
}


#Preview {
    WorkoutDetailListView(exercises: [
        Exercise(name: "HIGH KNEES", duration: 20, oneRM: "N/A", reps: "10-12", rest: "20 sec.", type: .cardio, creator: sampleUsers[0]),
        Exercise(name: "SQUATS", duration: 45, oneRM: "100 kg", reps: "8-10", rest: "30 sec.", type: .strength, creator: sampleUsers[1]),
        Exercise(name: "PLANK", duration: 60, oneRM: "N/A", reps: "N/A", rest: "60 sec.", type: .flexibility, creator: sampleUsers[2])
    ])
}
