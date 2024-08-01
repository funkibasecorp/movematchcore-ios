import SwiftUI

struct ExerciseLibraryView: View {
    @Binding var isPresented: Bool
    @Binding var selectedExercises: [Exercise]
    @State private var filters = Filters()
    @State private var isFilterPresented = false
    @State private var isCreateExercisePresented = false
    @State private var searchText = ""
    
    var body: some View {
        NavigationView {
            VStack {
                HStack {
                    Button(action: {
                        isPresented = false
                    }) {
                        Image(systemName: "chevron.left")
                            .font(.title)
                            .foregroundColor(.blue)
                    }
                    Spacer()
                    Text("All Exercises")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                    Spacer()
                    Button(action: {
                        isFilterPresented = true
                    }) {
                        Image(systemName: "slider.horizontal.3")
                            .font(.title)
                            .foregroundColor(.blue)
                    }
                    Button(action: {
                        isCreateExercisePresented = true
                    }) {
                        Image(systemName: "plus")
                            .font(.title)
                            .foregroundColor(.blue)
                    }
                }
                .padding()
                
                TextField("Search", text: $searchText)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding()
                
                List {
                    ForEach(filteredExercises) { exercise in
                        HStack {
                            Image(systemName: "checkmark")
                                .opacity(selectedExercises.contains(where: { $0.id == exercise.id }) ? 1 : 0)
                            Text(exercise.name)
                        }
                        .onTapGesture {
                            toggleExerciseSelection(exercise)
                        }
                    }
                }
                
                Button(action: {
                    isPresented = false
                }) {
                    Text("Continue")
                        .frame(minWidth: 0, maxWidth: .infinity)
                        .padding()
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                        .font(.headline)
                }
                .disabled(selectedExercises.isEmpty)
                .padding()
            }
            .background(
                NavigationLink(
                    destination: ExerciseLibraryFilterView(isPresented: $isFilterPresented, filters: $filters),
                    isActive: $isFilterPresented
                ) {
                    EmptyView()
                }
                .hidden()
            )
            .sheet(isPresented: $isCreateExercisePresented) {
                CreateExerciseView()
            }
        }
    }
    
    var filteredExercises: [Exercise] {
        mockExerciseData.filter { exercise in
            let nameMatch = searchText.isEmpty || exercise.name.lowercased().contains(searchText.lowercased())
            // Apply additional filters here
            return nameMatch // && other filter conditions
        }
    }
    
    private func toggleExerciseSelection(_ exercise: Exercise) {
        if let index = selectedExercises.firstIndex(where: { $0.id == exercise.id }) {
            selectedExercises.remove(at: index)
        } else {
            selectedExercises.append(exercise)
        }
    }
}

#Preview {
    ExerciseLibraryView(
        isPresented: .constant(true),
        selectedExercises: .constant([])
    )
}
