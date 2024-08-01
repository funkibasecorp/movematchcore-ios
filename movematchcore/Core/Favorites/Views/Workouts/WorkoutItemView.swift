//
//  WorkoutItemView.swift
//  spotmatch
//
//  Created by Chris Jones on 5/17/24.
//

import SwiftUI

struct WorkoutItemView: View {
    let workout: Workout
    
    var body: some View {
        HStack {
            Circle()
                .fill(Color.green)
                .frame(width: 40, height: 40)
                .overlay(Text(workout.name.prefix(1)).foregroundColor(.white))
            
            Text(workout.name)
                .font(.headline)
            Spacer()
        }
        .padding(.vertical, 10)
    }
}


#Preview {
    WorkoutItemView(workout: MockWorkoutData.collections.first!.workouts.first!)
}
