//
//  ExercisesListView.swift
//  spotmatch
//
//  Created by Chris Jones on 5/17/24.
//

import SwiftUI

struct ExercisesListView: View {
    let collection: ExerciseCollection
    
    var body: some View {
        List {
            ForEach(collection.exercises) { exercise in
                ExerciseItemView(exercise: exercise)
            }
        }
        .navigationTitle(collection.title)
        .listStyle(.plain)
        .background(Color.white)
    }
}

#Preview {
    ExercisesListView(collection: MockExerciseData.collections.first!)
}
