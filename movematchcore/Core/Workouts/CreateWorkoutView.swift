//
//  CreateWorkoutView.swift
//  movematchcore
//
//  Created by Chris Jones on 8/1/24.
//


import SwiftUI

struct CreateWorkoutView: View {
    @State private var workoutName = ""
    @State private var workoutDescription = ""
    @State private var isPrivate = false
    @State private var selectedCategories: [String] = []
    @State private var selectedLevel = ""
    @State private var selectedGoal = ""
    @State private var isContinueActive = false
    
    var isContinueEnabled: Bool {
        !workoutName.isEmpty && !selectedCategories.isEmpty && !selectedLevel.isEmpty && !selectedGoal.isEmpty
    }
    
    var body: some View {
        NavigationView {
            VStack(alignment: .leading, spacing: 20) {
                HStack {
                    Spacer()
                    Text("New Workout")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                    Spacer()
                }
                
                VStack(alignment: .leading) {
                    Text("Workout Name")
                        .font(.headline)
                    TextField("Name", text: $workoutName)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                }
                
                VStack(alignment: .leading) {
                    Text("Description")
                        .font(.headline)
                    TextField("Enter workout description", text: $workoutDescription)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                }
                
                VStack(alignment: .leading) {
                    Text("Privacy")
                        .font(.headline)
                    Toggle(isOn: $isPrivate) {
                        Text(isPrivate ? "Private" : "Public")
                    }
                }
                
                VStack(alignment: .leading) {
                    Text("Categories")
                        .font(.headline)
                    NavigationLink(destination: SelectCategoryModal(selectedCategories: $selectedCategories)) {
                        HStack {
                            Text(selectedCategories.isEmpty ? "Select Category" : selectedCategories.joined(separator: ", "))
                            Spacer()
                            Image(systemName: "chevron.right")
                        }
                    }
                }
                
                VStack(alignment: .leading) {
                    Text("Level")
                        .font(.headline)
                    NavigationLink(destination: SelectLevelModal(selectedLevel: $selectedLevel)) {
                        HStack {
                            Text(selectedLevel.isEmpty ? "Select Level" : selectedLevel)
                            Spacer()
                            Image(systemName: "chevron.right")
                        }
                    }
                }
                
                VStack(alignment: .leading) {
                    Text("Goal")
                        .font(.headline)
                    NavigationLink(destination: SelectGoalModal(selectedGoal: $selectedGoal)) {
                        HStack {
                            Text(selectedGoal.isEmpty ? "Select Goal" : selectedGoal)
                            Spacer()
                            Image(systemName: "chevron.right")
                        }
                    }
                }
                
                Spacer()
                
                Button(action: {
                    isContinueActive = true
                }) {
                    Text("Continue")
                        .frame(minWidth: 0, maxWidth: .infinity)
                        .padding()
                        .background(isContinueEnabled ? Color.purple : Color.gray)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                        .font(.headline)
                }
                .disabled(!isContinueEnabled)
                
                NavigationLink(destination: WorkoutBuilderView(workoutName: workoutName, workoutDescription: workoutDescription, isPrivate: isPrivate, selectedCategories: selectedCategories, selectedLevel: selectedLevel, selectedGoal: selectedGoal), isActive: $isContinueActive) {
                    EmptyView()
                }
                .hidden()
            }
            .padding()
            .navigationBarHidden(true)
        }
    }
}

struct SelectCategoryModal: View {
    @Binding var selectedCategories: [String]
    @Environment(\.presentationMode) var presentationMode
    
    let categories = ["Functional", "Crossfit", "Cycling", "Gym", "HIIT", "Meditation", "Pilates", "Squash", "Stretching", "TRX", "Yoga"]
    
    var body: some View {
        VStack {
            HStack {
                Spacer()
                Button(action: {
                    presentationMode.wrappedValue.dismiss()
                }) {
                    Image(systemName: "xmark")
                        .font(.title)
                        .foregroundColor(.purple)
                }
            }
            .padding()
            
            Text("Select Categories")
                .font(.largeTitle)
                .fontWeight(.bold)
            
            ScrollView {
                LazyVGrid(columns: [GridItem(.adaptive(minimum: 100))]) {
                    ForEach(categories, id: \.self) { category in
                        Button(action: {
                            if selectedCategories.contains(category) {
                                selectedCategories.removeAll { $0 == category }
                            } else {
                                selectedCategories.append(category)
                            }
                        }) {
                            VStack {
                                Text(category)
                                    .font(.headline)
                                if selectedCategories.contains(category) {
                                    Image(systemName: "checkmark")
                                        .foregroundColor(.purple)
                                }
                            }
                        }
                    }
                }
                .padding()
            }
            
            Button(action: {
                presentationMode.wrappedValue.dismiss()
            }) {
                Text("Close")
                    .frame(minWidth: 0, maxWidth: .infinity)
                    .padding()
                    .background(Color.purple)
                    .foregroundColor(.white)
                    .cornerRadius(10)
                    .font(.headline)
            }
            .padding()
        }
    }
}

struct SelectLevelModal: View {
    @Binding var selectedLevel: String
    @Environment(\.presentationMode) var presentationMode
    
    let levels = ["Beginner", "Intermediate", "Advanced"]
    
    var body: some View {
        VStack {
            HStack {
                Spacer()
                Text("Select Level")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                Spacer()
            }
            .padding()
            
            List(levels, id: \.self) { level in
                Button(action: {
                    selectedLevel = level
                }) {
                    HStack {
                        Text(level)
                            .font(.headline)
                        Spacer()
                        if selectedLevel == level {
                            Image(systemName: "checkmark")
                                .foregroundColor(.purple)
                        }
                    }
                }
            }
            
            Button(action: {
                presentationMode.wrappedValue.dismiss()
            }) {
                Text("Save")
                    .frame(minWidth: 0, maxWidth: .infinity)
                    .padding()
                    .background(Color.purple)
                    .foregroundColor(.white)
                    .cornerRadius(10)
                    .font(.headline)
            }
            .padding()
        }
    }
}

struct SelectGoalModal: View {
    @Binding var selectedGoal: String
    @Environment(\.presentationMode) var presentationMode
    
    let goals = ["Weight Loss", "Muscle Gain", "General Fitness", "Flexibility", "Endurance", "Stress Relief"]
    
    var body: some View {
        VStack {
            HStack {
                Spacer()
                Text("Select Goal")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                Spacer()
            }
            .padding()
            
            List(goals, id: \.self) { goal in
                Button(action: {
                    selectedGoal = goal
                }) {
                    HStack {
                        Text(goal)
                            .font(.headline)
                        Spacer()
                        if selectedGoal == goal {
                            Image(systemName: "checkmark")
                                .foregroundColor(.purple)
                        }
                    }
                }
            }
            
            Button(action: {
                presentationMode.wrappedValue.dismiss()
            }) {
                Text("Save")
                    .frame(minWidth: 0, maxWidth: .infinity)
                    .padding()
                    .background(Color.purple)
                    .foregroundColor(.white)
                    .cornerRadius(10)
                    .font(.headline)
            }
            .padding()
        }
    }
}


#Preview {
    CreateWorkoutView()
}
