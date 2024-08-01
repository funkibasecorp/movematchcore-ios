import SwiftUI
import ElegantEmojiPicker

struct FavoritesView: View {
    @State private var selectedTab: Int = 0
    @State private var showFilterModal: Bool = false
    @State private var showCreateCollectionModal: Bool = false
    @State private var navigateToWorkout: Bool = false
    @State private var navigateToExercise: Bool = false
    @State private var workoutCollections: [WorkoutCollection] = MockWorkoutData.collections
    @State private var exerciseCollections: [ExerciseCollection] = MockExerciseData.collections

    var body: some View {
        NavigationStack {
            VStack {
                // Header
                SBModalHeaderView(
                    title: "Favorites",
                    modalView: FavoritesActionModalView(
                        navigateToWorkout: { navigateToWorkout = true },
                        navigateToExercise: { navigateToExercise = true },
                        navigateToCollection: { showCreateCollectionModal = true },
                        dismissModal: { showFilterModal = false }
                    ),
                    firstButtonContent: Button(action: {
                        showFilterModal.toggle()
                    }) {
                        Image(systemName: "plus")
                            .resizable()
                            .frame(width: 20, height: 20)
                    }
                )
                
                Divider()
                
                // Custom Segmented Control
                SegmentedControlView(
                    selectedTab: $selectedTab,
                    titles: ["Workouts", "Exercises"],
                    backgroundColor: .purple
                ).padding(.top, 15)
                
                // Content
                if selectedTab == 0 {
                    WorkoutCollectionsListView(collections: $workoutCollections)
                } else {
                    ExerciseCollectionsListView(collections: $exerciseCollections)
                }
                
                Spacer()
            }
            .navigationBarHidden(true)
            .background(Color.white.edgesIgnoringSafeArea(.all))
            .sheet(isPresented: $showFilterModal) {
                FavoritesActionModalView(
                    navigateToWorkout: { navigateToWorkout = true },
                    navigateToExercise: { navigateToExercise = true },
                    navigateToCollection: { showCreateCollectionModal = true },
                    dismissModal: { showFilterModal = false }
                )
            }
            .sheet(isPresented: $showCreateCollectionModal) {
                CreateCollectionModalView { newCollection in
                    if selectedTab == 0 {
                        workoutCollections.append(newCollection as! WorkoutCollection)
                    } else {
                        exerciseCollections.append(newCollection as! ExerciseCollection)
                    }
                    showCreateCollectionModal = false
                }
            }
            .navigationDestination(isPresented: $navigateToWorkout) {
                CreateWorkoutView()
            }
            .navigationDestination(isPresented: $navigateToExercise) {
                CreateExerciseView()
            }
        }
    }
}

enum FavoritesTab: String, CaseIterable {
    case workouts = "Workouts"
    case exercises = "Exercises"
}

struct WorkoutCollectionItemView: View {
    let collection: WorkoutCollection
    
    var body: some View {
        HStack {
            Rectangle()
                .fill(collection.color)
                .frame(width: 50, height: 50)
                .overlay(Text(collection.emoji).foregroundColor(.white))
                .cornerRadius(20)
                .padding(.trailing, 10)
            
            VStack(alignment: .leading) {
                Text(collection.title)
                    .font(.headline)
                Text("\(collection.workouts.count) workouts")
                    .font(.subheadline)
                    .foregroundColor(.gray)
            }
            Spacer()
        }
        .padding(.vertical, 10)
    }
}

struct ExerciseCollectionItemView: View {
    let collection: ExerciseCollection
    
    var body: some View {
        HStack {
            Rectangle()
                .fill(collection.color)
                .frame(width: 50, height: 50)
                .overlay(Text(collection.emoji).foregroundColor(.white))
                .cornerRadius(20)
                .padding(.trailing, 10)
            
            VStack(alignment: .leading) {
                Text(collection.title)
                    .font(.headline)
                Text("\(collection.exercises.count) exercises")
                    .font(.subheadline)
                    .foregroundColor(.gray)
            }
            Spacer()
        }
        .padding(.vertical, 10)
    }
}


#Preview {
    FavoritesView()
}
