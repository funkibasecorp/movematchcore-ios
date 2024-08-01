import SwiftUI

struct WorkoutBuilderView: View {
    @State private var workoutItems: [WorkoutItem] = []
    @State private var isSideMenuPresented = false
    @State private var isExerciseLibraryPresented = false
    @State private var isCreateExercisePresented = false
    @State private var isMyWorkoutsPresented = false
    @State private var isEditMode = false
    @State private var selectedExercises: [Exercise] = []
    
    let workoutName: String
    let workoutDescription: String
    let isPrivate: Bool
    let selectedCategories: [String]
    let selectedLevel: String
    let selectedGoal: String
    
    private func addNewGroup() {
        workoutItems.append(.group(ExerciseGroup(title: "New Group", items: [], restBreak: 60, groupType: .general)))
    }
    
    
    private func addRestBreak() {
        workoutItems.append(.restBreak(RestBreak(duration: 60)))
    }
    
    private func deleteItem(_ item: WorkoutItem) {
        workoutItems.removeAll { $0.id == item.id }
    }
    
    var body: some View {
        NavigationView {
            ZStack {
                VStack {
                    headerView
                    
                    if workoutItems.isEmpty {
                        emptyStateView
                    } else {
                        workoutItemListView
                    }
                    
                    continueButton
                }
                
                if isSideMenuPresented {
                    SideMenu(isPresented: $isSideMenuPresented,
                             workoutItems: $workoutItems,
                             isExerciseLibraryPresented: $isExerciseLibraryPresented,
                             isCreateExercisePresented: $isCreateExercisePresented,
                             isMyWorkoutsPresented: $isMyWorkoutsPresented)
                }
            }
            .navigationBarHidden(true)
            .sheet(isPresented: $isExerciseLibraryPresented) {
                ExerciseLibraryView(isPresented: $isExerciseLibraryPresented, selectedExercises: $selectedExercises)
            }
            .sheet(isPresented: $isCreateExercisePresented) {
                CreateExerciseView()
            }
            .sheet(isPresented: $isMyWorkoutsPresented) {
                MyWorkoutsGroupView(isPresented: $isMyWorkoutsPresented)
            }
        }
    }
    
    private var headerView: some View {
        HStack {
            Spacer()
            Text("Workout Builder")
                .font(.largeTitle)
                .fontWeight(.bold)
            Spacer()
            Button(action: {
                isSideMenuPresented.toggle()
            }) {
                Image(systemName: "plus")
                    .font(.title)
                    .foregroundColor(.blue)
            }
            Button(action: { isEditMode.toggle() }) {
                Text(isEditMode ? "Done" : "Edit")
                    .font(.headline)
                    .foregroundColor(.blue)
            }
        }
        .padding()
    }
    
    private var workoutItemListView: some View {
        ScrollView {
            LazyVStack(spacing: 20) {
                ForEach(workoutItems.indices, id: \.self) { index in
                    VStack {
                        WorkoutItemViews(item: $workoutItems[index], isEditMode: $isEditMode, onDelete: { deleteItem(workoutItems[index]) })
                        if index < workoutItems.count - 1 {
                            AddButtonBetweenItems(workoutItems: $workoutItems, index: index)
                        }
                    }
                }
            }
            .padding()
        }
    }
    
    private var emptyStateView: some View {
        VStack {
            Spacer()
            Image(systemName: "flag")
                .padding()
                .background(Circle().foregroundColor(.gray))
            Text("Nothing Here... yet")
            addGroupButton
            Spacer()
        }
    }

    private var addGroupButton: some View {
        Button(action: { addNewGroup() }) {
            Text("Add Group")
                .frame(maxWidth: .infinity)
                .padding()
                .background(Color.blue)
                .foregroundColor(.white)
                .cornerRadius(10)
                .font(.headline)
        }
        .padding()
    }

    private var continueButton: some View {
        Button(action: {
            // Proceed to the next step
        }) {
            Text("Continue")
                .frame(maxWidth: .infinity)
                .padding()
                .background(Color.blue)
                .foregroundColor(.white)
                .cornerRadius(10)
                .font(.headline)
        }
        .disabled(workoutItems.isEmpty)
        .padding()
    }
}


struct WorkoutItemViews: View {
    @Binding var item: WorkoutItem
    @Binding var isEditMode: Bool
    let onDelete: () -> Void

    var body: some View {
        HStack {
            switch item {
            case .exercise(let exercise):
                ExerciseView(exercise: exercise)
            case .restBreak(let restBreak):
                RestBreakView(restBreak: Binding(
                    get: { restBreak },
                    set: { newValue in
                        if case .restBreak = item {
                            item = .restBreak(newValue)
                        }
                    }
                ))
            case .group(let group):
                GroupView(group: Binding(
                    get: { group },
                    set: { newValue in
                        if case .group = item {
                            item = .group(newValue)
                        }
                    }
                ), isEditMode: $isEditMode, onDelete: onDelete)
            }
            
            if isEditMode {
                Spacer()
                Button(action: onDelete) {
                    Image(systemName: "trash")
                        .foregroundColor(.red)
                }
            }
        }
    }
}

struct AddButtonBetweenItems: View {
    @Binding var workoutItems: [WorkoutItem]
    let index: Int
    @State private var isAddMenuPresented = false

    var body: some View {
        Button(action: { isAddMenuPresented = true }) {
            Image(systemName: "plus.circle.fill")
                .foregroundColor(.blue)
                .font(.title2)
        }
        .actionSheet(isPresented: $isAddMenuPresented) {
            ActionSheet(title: Text("Add"), buttons: [
                .default(Text("Rest Break")) { addRestBreak() },
                .default(Text("Exercise")) { addExercise() },
                .default(Text("Group")) { addGroup() },
                .cancel()
            ])
        }
    }

    private func addRestBreak() {
        workoutItems.insert(.restBreak(RestBreak(duration: 60)), at: index + 1)
    }

    private func addExercise() {
        let newExercise = Exercise(
            name: "New Exercise",
            duration: 30.0,
            oneRM: "N/A",
            reps: "N/A",
            rest: "1 minute",
            type: .cardio,
            creator: sampleUsers[0]
        )
        workoutItems.insert(.exercise(newExercise), at: index + 1)
    }

    private func addGroup() {
        let newGroup = ExerciseGroup(
            title: "New Group",
            items: [],
            restBreak: 60,
            groupType: .general
        )
        workoutItems.insert(.group(newGroup), at: index + 1)
    }
}

struct GroupView: View {
    @Binding var group: ExerciseGroup
    @Binding var isEditMode: Bool
    let onDelete: () -> Void
    @State private var isAddMenuPresented = false
    @State private var selectedExercises: [Exercise] = []
    
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            HStack {
                TextField("Group Title", text: $group.title)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                if isEditMode {
                    Button(action: onDelete) {
                        Image(systemName: "trash")
                            .foregroundColor(.red)
                    }
                }
                Button(action: { isAddMenuPresented = true }) {
                    Image(systemName: "plus")
                        .foregroundColor(.blue)
                }
                .actionSheet(isPresented: $isAddMenuPresented) {
                    ActionSheet(title: Text("Add to Group"), buttons: [
                        .default(Text("Add Exercise")) { addExercise() },
                        .default(Text("Add Rest Break")) { addRestBreak() },
                        .cancel()
                    ])
                }
            }
            
            HStack {
                Text("Rest Break:")
                TextField("Seconds", value: $group.restBreak, formatter: NumberFormatter())
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .frame(width: 100)
                Text("seconds")
            }
            
            Picker("Group Type", selection: $group.groupType) {
                ForEach(GroupType.allCases, id: \.self) { type in
                    Text(type.rawValue).tag(type)
                }
            }
            .pickerStyle(MenuPickerStyle())
            
            ForEach(group.items.indices, id: \.self) { index in
                ItemView(item: $group.items[index])
            }
        }
        .padding()
        .background(group.groupType.color.opacity(0.1))
        .cornerRadius(10)
    }
    
    private func addExercise() {
        let newExercise = Exercise(
            name: "New Exercise",
            duration: 30.0,
            oneRM: "N/A",
            reps: "N/A",
            rest: "1 minute",
            type: .cardio,
            creator: sampleUsers[0]
        )
        group.items.append(.exercise(newExercise))
    }
    
    private func addRestBreak() {
        group.items.append(.restBreak(RestBreak(duration: 60)))
    }
}

struct ItemView: View {
    @Binding var item: ExerciseItem
    
    var body: some View {
        switch item {
        case .exercise(let exercise):
            ExerciseView(exercise: exercise)
        case .restBreak(let restBreak):
            RestBreakView(restBreak: Binding(
                get: { restBreak },
                set: { newValue in
                    if case .restBreak = item {
                        item = .restBreak(newValue)
                    }
                }
            ))
        }
    }
}

enum WorkoutItem: Identifiable {
    case exercise(Exercise)
    case restBreak(RestBreak)
    case group(ExerciseGroup)
    
    var id: UUID {
        switch self {
        case .exercise(let exercise):
            return exercise.id
        case .restBreak(let restBreak):
            return restBreak.id
        case .group(let group):
            return group.id
        }
    }
}

struct RestBreakView: View {
    @Binding var restBreak: RestBreak
    
    var body: some View {
        HStack {
            Text("Rest Break")
            Spacer()
            TextField("Duration", value: $restBreak.duration, formatter: NumberFormatter())
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .frame(width: 10)
            Text("seconds")
        }
        .padding()
        .background(Color.white)
        .cornerRadius(8)
    }
}

enum ExerciseItem: Identifiable {
    case exercise(Exercise)
    case restBreak(RestBreak)
    
    var id: UUID {
        switch self {
        case .exercise(let exercise):
            return exercise.id
        case .restBreak(let restBreak):
            return restBreak.id
        }
    }
}

struct ExerciseGroup: Identifiable {
    var id = UUID()
    var title: String
    var items: [ExerciseItem]
    var restBreak: Int = 60 // Default rest break of 60 seconds
    var groupType: GroupType = .general // Default group type
}

enum GroupType: String, CaseIterable {
    case general = "General"
    case dropSets = "Drop Sets"
    case superSets = "Super Sets"
    case pyramidSets = "Pyramid Sets"
    case circuitTraining = "Circuit Training"
    case giantSets = "Giant Sets"
    case restPauseSets = "Rest-Pause Sets"
    case forcedReps = "Forced Reps"
    case negativeReps = "Negative Reps"
    case clusterSets = "Cluster Sets"
    case triSets = "Tri-Sets"
    
    var color: Color {
        switch self {
        case .general: return .blue
        case .dropSets: return .red
        case .superSets: return .green
        case .pyramidSets: return .orange
        case .circuitTraining: return .purple
        case .giantSets: return .pink
        case .restPauseSets: return .yellow
        case .forcedReps: return .cyan
        case .negativeReps: return .indigo
        case .clusterSets: return .mint
        case .triSets: return .teal
        }
    }
}

struct RestBreak: Identifiable {
    var id = UUID()
    var duration: Int
}

struct SideMenu: View {
    @Binding var isPresented: Bool
    @Binding var workoutItems: [WorkoutItem]
    @Binding var isExerciseLibraryPresented: Bool
    @Binding var isCreateExercisePresented: Bool
    @Binding var isMyWorkoutsPresented: Bool
    
    var body: some View {
        VStack(spacing: 20) {
            Button("Add Exercise Group") {
                workoutItems.append(.group(ExerciseGroup(title: "New Group", items: [])))
                isPresented = false
            }
            
            Button("Create Exercise") {
                isCreateExercisePresented = true
                isPresented = false
            }
            
            Button("Exercise Library") {
                isExerciseLibraryPresented = true
                isPresented = false
            }
            
            Button("My Workouts") {
                isMyWorkoutsPresented = true
                isPresented = false
            }
            
            Button("Add Rest Break") {
                workoutItems.append(.restBreak(RestBreak(duration: 60)))
                isPresented = false
            }
        }
        .padding()
        .background(Color.white)
        .cornerRadius(10)
        .shadow(radius: 10)
    }
}

struct MyWorkoutsGroupView: View {
    @Binding var isPresented: Bool
    
    var body: some View {
        Text("My Workouts Group View")
    }
}

#Preview {
    WorkoutBuilderView(
        workoutName: "Sample Workout",
        workoutDescription: "This is a sample workout description.",
        isPrivate: false,
        selectedCategories: ["Strength", "Cardio"],
        selectedLevel: "Intermediate",
        selectedGoal: "Muscle Gain"
    )
}
