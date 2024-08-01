import SwiftUI

struct ExerciseLibraryFilterView: View {
    @Binding var isPresented: Bool
    @Binding var filters: Filters
    
    var body: some View {
        VStack {
            HStack {
                Spacer()
                Text("Filters")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                Spacer()
                Button(action: {
                    isPresented = false
                }) {
                    Image(systemName: "xmark")
                        .font(.title)
                        .foregroundColor(.blue)
                }
            }
            .padding()
            
            ScrollView {
                VStack(alignment: .leading, spacing: 20) {
                    // Sort By Section
                    FilterSection(title: "Sort By", options: SortOption.allCases, selectedOption: $filters.sortBy, isMultiSelect: false)
                    
                    // Main Muscle Group Section
                    FilterSection(title: "Main Muscle Group", options: MuscleGroup.allCases, selectedOptions: $filters.mainMuscleGroup, isMultiSelect: true)
                    
                    // Equipment Section
                    FilterSection(title: "Equipment", options: Equipment.allCases, selectedOptions: $filters.equipment, isMultiSelect: true)
                    
                    // Intensity Section
                    FilterSection(title: "Intensity", options: Intensity.allCases, selectedOption: $filters.intensity, isMultiSelect: false)
                    
                    // Fitness Goals Section
                    FilterSection(title: "Fitness Goals", options: FitnessGoal.allCases, selectedOptions: $filters.fitnessGoals, isMultiSelect: true)
                    
                    // Fitness Level Section
                    FilterSection(title: "Fitness Level", options: FitnessLevel.allCases, selectedOption: $filters.fitnessLevel, isMultiSelect: false)
                    
                    // Rating Section
                    FilterSection(title: "Rating", options: Rating.allCases, selectedOption: $filters.rating, isMultiSelect: false)
                    
                    // Duration Section
                    VStack(alignment: .leading) {
                        Text("Duration")
                            .font(.headline)
                        HStack {
                            Text("10 min")
                            Slider(value: $filters.durationRange.lowerBound, in: 10...180, step: 10)
                            Text("3 hours")
                        }
                    }
                }
                .padding(.horizontal)
            }
            
            // Floating Action View
            HStack {
                Button(action: {
                    filters.reset()
                }) {
                    Text("Revert")
                        .padding()
                        .background(Color.gray)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                }
                
                Button(action: {
                    isPresented = false
                }) {
                    Text("Apply")
                        .padding()
                        .background(Color.purple)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                }
            }
            .padding()
            .background(Color.white.opacity(0.8))
            .cornerRadius(15)
            .shadow(radius: 5)
            .padding(.bottom, 10)
        }
        .background(Color.gray.opacity(0.1).edgesIgnoringSafeArea(.all))
    }
}

struct FilterSection<Option: Hashable & CaseIterable & RawRepresentable>: View where Option.RawValue == String {
    let title: String
    let options: [Option]
    @Binding var selectedOption: Option?
    @Binding var selectedOptions: [Option]
    let isMultiSelect: Bool
    
    init(title: String, options: [Option], selectedOption: Binding<Option?>, isMultiSelect: Bool = false) {
        self.title = title
        self.options = options
        self._selectedOption = selectedOption
        self._selectedOptions = Binding.constant([])
        self.isMultiSelect = isMultiSelect
    }
    
    init(title: String, options: [Option], selectedOptions: Binding<[Option]>, isMultiSelect: Bool = true) {
        self.title = title
        self.options = options
        self._selectedOption = Binding.constant(nil)
        self._selectedOptions = selectedOptions
        self.isMultiSelect = isMultiSelect
    }
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(title)
                .font(.headline)
            ScrollView(.horizontal, showsIndicators: false) {
                HStack {
                    ForEach(options, id: \.self) { option in
                        Button(action: {
                            if isMultiSelect {
                                if selectedOptions.contains(option) {
                                    selectedOptions.removeAll { $0 == option }
                                } else {
                                    selectedOptions.append(option)
                                }
                            } else {
                                selectedOption = option
                            }
                        }) {
                            Text(option.rawValue)
                                .padding(.horizontal, 12)
                                .padding(.vertical, 8)
                                .background(isSelected(option) ? Color.blue : Color.gray.opacity(0.2))
                                .foregroundColor(isSelected(option) ? .white : .black)
                                .cornerRadius(20)
                        }
                    }
                }
            }
        }
    }
    
    private func isSelected(_ option: Option) -> Bool {
        if isMultiSelect {
            return selectedOptions.contains(option)
        } else {
            return selectedOption == option
        }
    }
}

struct Filters {
    var sortBy: SortOption? = .popular
    var mainMuscleGroup: [MuscleGroup] = []
    var equipment: [Equipment] = []
    var intensity: Intensity? = .any
    var fitnessGoals: [FitnessGoal] = []
    var fitnessLevel: FitnessLevel? = .beginner
    var rating: Rating? = .over4
    var durationRange: DurationRange = DurationRange(lowerBound: 10, upperBound: 180)
    
    mutating func reset() {
        sortBy = .popular
        mainMuscleGroup = []
        equipment = []
        intensity = .any
        fitnessGoals = []
        fitnessLevel = .beginner
        rating = .over4
        durationRange = DurationRange(lowerBound: 10, upperBound: 180)
    }
}

struct DurationRange {
    var lowerBound: Double
    var upperBound: Double
}

enum SortOption: String, CaseIterable {
    case popular = "Popular"
    case trending = "Trending"
    case aToZ = "A-Z"
    case zToA = "Z-A"
}

enum MuscleGroup: String, CaseIterable {
    case legs = "Legs"
    case chest = "Chest"
    case back = "Back"
    case biceps = "Biceps"
    case triceps = "Triceps"
    case shoulders = "Shoulders"
    case glutes = "Glutes"
    case arms = "Arms"
    case core = "Core"
    case calves = "Calves"
    case forearms = "Forearms"
    case traps = "Traps"
    case hamstrings = "Hamstrings"
    case quads = "Quads"
    case fullBody = "Full Body"
}

enum Equipment: String, CaseIterable {
    case noEquipment = "No equipment"
    case weight = "Weight"
    case resistance = "Resistance"
    case largeEquipment = "Large equipment"
    case yogaEquipment = "Yoga equipment"
    case balanceEquipment = "Balance equipment"
    case jumpRope = "Jump rope"
}

enum Intensity: String, CaseIterable {
    case any = "Any"
    case low = "Low"
    case medium = "Medium"
    case high = "High"
}

enum FitnessGoal: String, CaseIterable {
    case weightLoss = "Weight Loss"
    case muscleGain = "Muscle Gain"
    case generalFitness = "General Fitness"
    case flexibility = "Flexibility"
    case endurance = "Endurance"
    case stressRelief = "Stress Relief"
}

enum FitnessLevel: String, CaseIterable {
    case beginner = "Beginner"
    case intermediate = "Intermediate"
    case advanced = "Advanced"
}

enum Rating: String, CaseIterable {
    case over4 = "Over 4"
    case over3 = "Over 3"
}

#Preview {
    ExerciseLibraryFilterView(
        isPresented: .constant(true),
        filters: .constant(Filters())
    )
}
