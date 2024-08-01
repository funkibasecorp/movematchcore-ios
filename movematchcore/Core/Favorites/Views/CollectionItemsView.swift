//
//  CollectionItemsView.swift
//  spotmatch
//
//  Created by Chris Jones on 5/19/24.
//

import SwiftUI

struct CollectionItemsView: View {
    let collection: Any
    
    var body: some View {
        VStack {
            if let workoutCollection = collection as? WorkoutCollection {
                List {
                    ForEach(workoutCollection.workouts) { workout in
                        WorkoutCardView(workout: workout)
                            .padding(.vertical, 5)
                            .listRowInsets(EdgeInsets())
                    }
                }
                .navigationTitle(workoutCollection.title)
                .listStyle(.plain)
                .background(Color.white)
            } else if let exerciseCollection = collection as? ExerciseCollection {
                List {
                    ForEach(exerciseCollection.exercises) { exercise in
                        ExerciseCardView(exercise: exercise)
                            .padding(.vertical, 5)
                            .listRowInsets(EdgeInsets())
                    }
                }
                .navigationTitle(exerciseCollection.title)
                .listStyle(.plain)
                .background(Color.white)
            }
        }
    }
}

struct WorkoutCardView: View {
    let workout: Workout
    @State private var showActionModal: Bool = false
    
    var body: some View {
        VStack {
            HStack {
                Rectangle()
                    .fill(Color.purple)
                    .frame(width: 50, height: 50)
                    .overlay(Text("🏅").font(.title))
                    .cornerRadius(20)
                
                VStack(alignment: .leading) {
                    Text(workout.name)
                        .font(.headline)
                    Text("Strength • Back")
                        .font(.subheadline)
                        .foregroundColor(.gray)
                }
                Spacer()
                
                Button(action: {
                    showActionModal.toggle()
                }) {
                    Image(systemName: "ellipsis")
                        .resizable()
                        .frame(width: 20, height: 5)
                        .foregroundColor(.black)
                }
                .sheet(isPresented: $showActionModal) {
                    WorkoutActionModalView()
                }
            }
            .padding()
            
            HStack {
                HStack(spacing: 5) {
                    Image(systemName: "clock")
                    Text("45 Min")
                }
                HStack(spacing: 5) {
                    Image(systemName: "chart.bar.fill")
                    Text("Mid")
                }
                HStack(spacing: 5) {
                    Image(systemName: "star.fill")
                    Text("4.5")
                }
                Spacer()
                Button(action: {
                    // Start action
                }) {
                    HStack {
                        Image(systemName: "play.fill")
                        Text("Start")
                    }
                    .padding(.vertical, 5)
                    .padding(.horizontal, 15)
                    .background(Color.green)
                    .foregroundColor(.white)
                    .cornerRadius(10)
                }
            }
            .padding()
            .font(.caption)
            .foregroundColor(.gray)
        }
        .background(Color.white)
        .cornerRadius(20)
        .overlay(
            RoundedRectangle(cornerRadius: 20)
                .stroke(Color.gray, lineWidth: 1)
        )
        .padding(.horizontal)
    }
}

struct ExerciseCardView: View {
    let exercise: Exercise
    @State private var showActionModal: Bool = false
    
    var body: some View {
        VStack {
            HStack {
                Circle()
                    .fill(Color.green.opacity(0.3))
                    .frame(width: 50, height: 50)
                    .overlay(Text("👟").font(.title))
                
                VStack(alignment: .leading) {
                    Text(exercise.name)
                        .font(.headline)
                    Text("Strength • Back • Barbell")
                        .font(.subheadline)
                        .foregroundColor(.gray)
                }
                Spacer()
                
                Button(action: {
                    showActionModal.toggle()
                }) {
                    Image(systemName: "ellipsis")
                        .resizable()
                        .frame(width: 20, height: 5)
                        .foregroundColor(.black)
                }
                .sheet(isPresented: $showActionModal) {
                    ExerciseActionModalView()
                }
            }
            .padding()
            
            HStack {
                HStack(spacing: 5) {
                    Image(systemName: "person.fill")
                    Text("alicstrength")
                }
                HStack(spacing: 5) {
                    Image(systemName: "chart.bar.fill")
                    Text("Mid")
                }
                HStack(spacing: 5) {
                    Image(systemName: "star.fill")
                    Text("4.5")
                }
                Spacer()
            }
            .padding()
            .font(.caption)
            .foregroundColor(.gray)
        }
        .background(Color.white)
        .cornerRadius(20)
        .overlay(
            RoundedRectangle(cornerRadius: 20)
                .stroke(Color.gray, lineWidth: 1)
        )
        .padding(.horizontal)
    }
}

struct WorkoutActionModalView: View {
    var body: some View {
        Text("Workout Action Modal")
            .font(.title)
            .padding()
    }
}

struct ExerciseActionModalView: View {
    var body: some View {
        Text("Exercise Action Modal")
            .font(.title)
            .padding()
    }
}

#Preview {
    NavigationStack {
        CollectionItemsView(collection: MockWorkoutData.collections.first!)
    }
}
