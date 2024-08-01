//
//  ExerciseItemView.swift
//  spotmatch
//
//  Created by Chris Jones on 5/17/24.
//

import SwiftUI

struct ExerciseItemView: View {
    let exercise: Exercise
    
    var body: some View {
        HStack {
            Rectangle()
                .fill(Color.blue)
                .frame(width: 40, height: 40)
                .overlay(Text(exercise.name.prefix(1)).foregroundColor(.white))
            
            Text(exercise.name)
                .font(.headline)
            Spacer()
        }
        .padding(.vertical, 10)
    }
}

#Preview {
    ExerciseItemView(exercise: MockExerciseData.collections.first!.exercises.first!)
}
