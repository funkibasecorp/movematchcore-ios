import SwiftUI
import MapKit

struct CreateEventView: View {
    @State private var eventName: String = ""
    @State private var workoutDescription: String = ""
    @State private var selectedWorkout: String = ""
    @State private var selectedIntensity: String = ""
    @State private var selectedGoal: String = ""
    @State private var selectedType: String = ""
    @State private var selectedPrivacyType: String = ""
    @State private var itemsToBring: String = ""
    @State private var itemsAttendeesWillBring: String = ""
    @State private var showImagePicker: Bool = false
    @State private var selectedImage: UIImage? = nil
    @State private var showModal: Bool = false
    @State private var modalType: String = ""
    @State private var showWorkoutSelection: Bool = false
    @State private var showDurationPicker: Bool = false
    @State private var numberOfAttendees: Int = 0

    var body: some View {
        VStack {
            ProgressView(value: 0.2)
                .padding()
            
            Form {
                Section(header: Text("Basic Info")) {
                    TextField("Name", text: $eventName)
                    TextField("Workout description", text: $workoutDescription)
                }
                Section(header: Text("Photo")) {
                    Button(action: {
                        self.showImagePicker = true
                    }) {
                        if let image = selectedImage {
                            Image(uiImage: image)
                                .resizable()
                                .scaledToFit()
                                .frame(width: 100, height: 100)
                                .clipShape(Circle())
                                .overlay(Circle().stroke(Color.gray, lineWidth: 1))
                                .shadow(radius: 5)
                        } else {
                            Image(systemName: "camera")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 100, height: 100)
                                .foregroundColor(.gray)
                        }
                    }
                    .sheet(isPresented: $showImagePicker) {
                        ImagePicker(selectedImage: self.$selectedImage)
                    }
                }
                
                Section(header: Text("Workout")) {
                    NavigationLink(destination: SelectWorkoutCollectionView(selectedWorkout: $selectedWorkout, showWorkoutSelection: $showWorkoutSelection), isActive: $showWorkoutSelection) {
                        HStack {
                            Text(selectedWorkout.isEmpty ? "Select workout" : selectedWorkout)
                                .foregroundColor(selectedWorkout.isEmpty ? .gray : .primary)
                            Spacer()
                            Image(systemName: "chevron.right")
                                .foregroundColor(.gray)
                        }
                    }
                }
                
                Section(header: Text("Property")) {
                    Button(action: {
                        self.modalType = "Intensity"
                        self.showModal = true
                    }) {
                        HStack {
                            Text(selectedIntensity.isEmpty ? "Select Intensity" : selectedIntensity)
                                .foregroundColor(selectedIntensity.isEmpty ? .gray : .primary)
                            Spacer()
                            Image(systemName: "chevron.right")
                                .foregroundColor(.gray)
                        }
                    }
                    
                    Button(action: {
                        self.modalType = "Goal"
                        self.showModal = true
                    }) {
                        HStack {
                            Text(selectedGoal.isEmpty ? "Select Goal" : selectedGoal)
                                .foregroundColor(selectedGoal.isEmpty ? .gray : .primary)
                            Spacer()
                            Image(systemName: "chevron.right")
                                .foregroundColor(.gray)
                        }
                    }
                    
                    Button(action: {
                        self.modalType = "Type"
                        self.showModal = true
                    }) {
                        HStack {
                            Text(selectedType.isEmpty ? "Select Type" : selectedType)
                                .foregroundColor(selectedType.isEmpty ? .gray : .primary)
                            Spacer()
                            Image(systemName: "chevron.right")
                                .foregroundColor(.gray)
                        }
                    }
                    
                    if selectedType == "Coach" {
                        Stepper(value: $numberOfAttendees, in: 1...100) {
                            Text("Number of Attendees: \(numberOfAttendees)")
                                .foregroundColor(selectedType.isEmpty ? .gray : .primary)
                        }
                    }
                    
                    Button(action: {
                        self.modalType = "PrivacyType"
                        self.showModal = true
                    }) {
                        HStack {
                            Text(selectedPrivacyType.isEmpty ? "Select Privacy Type" : selectedPrivacyType)
                                .foregroundColor(selectedPrivacyType.isEmpty ? .gray : .primary)
                            Spacer()
                            Image(systemName: "chevron.right")
                                .foregroundColor(.gray)
                        }
                    }
                }
                
                Section(header: Text("What You Will Bring")) {
                    TextField("Enter items to bring to event", text: $itemsToBring)
                }
                
                Section(header: Text("What Attendees Will Bring")) {
                    TextField("Enter items to bring to event", text: $itemsAttendeesWillBring)
                }
            }
            
            NavigationLink(destination: CreateEventView2(eventName: eventName, workoutDescription: workoutDescription, selectedWorkout: selectedWorkout, selectedIntensity: selectedIntensity, selectedGoal: selectedGoal, selectedType: selectedType, selectedPrivacyType: selectedPrivacyType, itemsToBring: itemsToBring, itemsAttendeesWillBring: itemsAttendeesWillBring, selectedImage: selectedImage)) {
                Text("Continue")
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(isFormComplete ? Color.blue : Color.gray)
                    .foregroundColor(.white)
                    .cornerRadius(8)
            }
            .padding()
            .disabled(!isFormComplete)
        }
        .navigationBarTitle("New Event", displayMode: .inline)
        .sheet(isPresented: $showModal) {
            ModalView(modalType: self.modalType, selectedOption: self.getSelectedOption(), showModal: $showModal)
        }
    }
    
    var isFormComplete: Bool {
        !eventName.isEmpty &&
        !workoutDescription.isEmpty &&
        !selectedWorkout.isEmpty &&
        !selectedIntensity.isEmpty &&
        !selectedGoal.isEmpty &&
        !selectedType.isEmpty &&
        !selectedPrivacyType.isEmpty &&
        !itemsToBring.isEmpty &&
        !itemsAttendeesWillBring.isEmpty
    }
    
    private func getSelectedOption() -> Binding<String> {
        switch modalType {
        case "Intensity":
            return $selectedIntensity
        case "Goal":
            return $selectedGoal
        case "Type":
            return $selectedType
        case "PrivacyType":
            return $selectedPrivacyType
        default:
            return $selectedWorkout
        }
    }
}

struct CreateEventView2: View {
    let eventName: String
    let workoutDescription: String
    let selectedWorkout: String
    let selectedIntensity: String
    let selectedGoal: String
    let selectedType: String
    let selectedPrivacyType: String
    let itemsToBring: String
    let itemsAttendeesWillBring: String
    let selectedImage: UIImage?

    @State private var eventDate: Date = Date()
    @State private var eventTime: Date = Date()
    @State private var eventDuration: TimeInterval = 900 // Default 15 minutes
    @State private var isRecurring: Bool = false
    @State private var selectedDays: [Int] = []
    @State private var numberOfWeeks: Int = 0
    @State private var reminderTime: String = "At time of event"
    @State private var showDurationPicker: Bool = false

    var body: some View {
        VStack {
            ProgressView(value: 0.4)
                .padding()

            Form {
                Section(header: Text("Schedule Event")) {
                    DatePicker("Select Date", selection: $eventDate, displayedComponents: .date)
                    DatePicker("Select Time", selection: $eventTime, displayedComponents: .hourAndMinute)
                    Button(action: {
                        showDurationPicker = true
                    }) {
                        Text("Select Duration")
                    }
                    .sheet(isPresented: $showDurationPicker) {
                        DurationPicker(eventDuration: $eventDuration)
                    }
                }
                
                Section(header: Text("Recurring Weekly")) {
                    Toggle(isOn: $isRecurring) {
                        Text("Recurring Weekly")
                    }
                    
                    if isRecurring {
                        HStack(alignment: .center, spacing: 0) {
                            ForEach(1...7, id: \.self) { day in
                                Button(action: {
                                    if selectedDays.contains(day) {
                                        selectedDays.removeAll(where: { $0 == day })
                                    } else {
                                        selectedDays.append(day)
                                    }
                                }) {
                                    ZStack {
                                        Circle()
                                            .stroke(selectedDays.contains(day) ? Color.purple : Color.gray, lineWidth: 2)
                                            .background(selectedDays.contains(day) ? Circle().fill(Color.purple) : Circle().fill(Color.clear))
                                            .frame(width: 40, height: 40)
                                        Text(dayAbbreviation(day))
                                            .foregroundColor(selectedDays.contains(day) ? .white : .black)
                                    }
                                }
                                .buttonStyle(PlainButtonStyle())
                                
                                if day != 7 {
                                    Spacer(minLength: 0)
                                }
                            }
                        }
                        .padding(.horizontal, 16)
                        
                        Stepper(value: $numberOfWeeks, in: 1...52) {
                            Text("For \(numberOfWeeks) weeks")
                        }
                    }
                }
                
                Section(header: Text("Reminder")) {
                    Picker("Reminder", selection: $reminderTime) {
                        Text("At time of event").tag("At time of event")
                        Text("5 minutes before").tag("5 minutes before")
                        Text("10 minutes before").tag("10 minutes before")
                        Text("15 minutes before").tag("15 minutes before")
                        Text("30 minutes before").tag("30 minutes before")
                    }
                    .pickerStyle(MenuPickerStyle())
                }
            }
            
            NavigationLink(destination: CreateEventView3(eventName: eventName, workoutDescription: workoutDescription, selectedWorkout: selectedWorkout, selectedIntensity: selectedIntensity, selectedGoal: selectedGoal, selectedType: selectedType, selectedPrivacyType: selectedPrivacyType, itemsToBring: itemsToBring, itemsAttendeesWillBring: itemsAttendeesWillBring, selectedImage: selectedImage, eventDate: eventDate, eventTime: eventTime, eventDuration: eventDuration, isRecurring: isRecurring, selectedDays: selectedDays, numberOfWeeks: numberOfWeeks, reminderTime: reminderTime)) {
                Text("Next")
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(isFormComplete ? Color.purple : Color.gray)
                    .foregroundColor(.white)
                    .cornerRadius(8)
            }
            .padding()
            .disabled(!isFormComplete)
        }
        .navigationBarTitle("Schedule Event", displayMode: .inline)
    }
    
    var isFormComplete: Bool {
        true
    }

    private func dayAbbreviation(_ day: Int) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "E"
        return dateFormatter.shortWeekdaySymbols[(day - 1) % 7]
    }
}

struct DurationPicker: View {
    @Binding var eventDuration: TimeInterval
    @Environment(\.presentationMode) var presentationMode

    var body: some View {
        VStack {
            Text("Select Duration")
                .font(.title)
                .padding()
            
            Stepper(value: $eventDuration, in: 900...86400, step: 900) {
                Text("\(eventDuration / 60) minutes")
            }
            .padding()
            
            Button(action: {
                presentationMode.wrappedValue.dismiss()
            }) {
                Text("Done")
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color.purple)
                    .foregroundColor(.white)
                    .cornerRadius(8)
            }
            .padding()
        }
    }
}


struct LocationCoordinate: Identifiable {
    let id = UUID()
    let coordinate: CLLocationCoordinate2D
}

extension CLLocationCoordinate2D: Equatable {
    public static func == (lhs: CLLocationCoordinate2D, rhs: CLLocationCoordinate2D) -> Bool {
        return lhs.latitude == rhs.latitude && lhs.longitude == rhs.longitude
    }
}

struct DraggableMapPin: View {
    @Binding var coordinate: CLLocationCoordinate2D
    let tint: Color

    var body: some View {
        VStack(spacing: 0) {
            Image(systemName: "mappin.circle.fill")
                .font(.title)
                .foregroundColor(.white)
                .background(tint)
                .clipShape(Circle())
            Image(systemName: "arrowtriangle.down.fill")
                .font(.caption)
                .foregroundColor(tint)
                .offset(x: 0, y: -5)
        }
        .gesture(
            DragGesture().onChanged { value in
                self.coordinate = CLLocationCoordinate2D(latitude: value.location.y, longitude: value.location.x)
            }
        )
    }
}

struct CreateEventView3: View {
    let eventName: String
    let workoutDescription: String
    let selectedWorkout: String
    let selectedIntensity: String
    let selectedGoal: String
    let selectedType: String
    let selectedPrivacyType: String
    let itemsToBring: String
    let itemsAttendeesWillBring: String
    let selectedImage: UIImage?
    let eventDate: Date
    let eventTime: Date
    let eventDuration: TimeInterval
    let isRecurring: Bool
    let selectedDays: [Int]
    let numberOfWeeks: Int
    let reminderTime: String

    @State private var eventLocation: CLLocationCoordinate2D?
    @State private var parkingLocation: CLLocationCoordinate2D?
    @State private var region = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 37.7749, longitude: -122.4194), span: MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05))
    @State private var searchText = ""
    @State private var searchResults: [MKMapItem] = []

    var body: some View {
        VStack {
            HStack {
                TextField("Search Location", text: $searchText)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding()
                Button(action: {
                    searchLocation()
                }) {
                    Image(systemName: "magnifyingglass")
                        .padding(.trailing, 10)
                }
            }
            Map(coordinateRegion: $region, annotationItems: [eventLocation, parkingLocation].compactMap { $0 }.map { LocationCoordinate(coordinate: $0) }) { location in
                MapAnnotation(coordinate: location.coordinate) {
                    DraggableMapPin(coordinate: .constant(location.coordinate), tint: location.coordinate == eventLocation ? .red : .blue)
                }
            }
            .edgesIgnoringSafeArea(.all)

            if eventLocation != nil || parkingLocation != nil {
                VStack(alignment: .leading) {
                    if let eventLocation = eventLocation {
                        Text("Event Location: \(eventLocation.latitude), \(eventLocation.longitude)")
                    }
                    if let parkingLocation = parkingLocation {
                        Text("Parking Location: \(parkingLocation.latitude), \(parkingLocation.longitude)")
                    }
                }
                .padding()
            }

            Button(action: {
                saveLocations()
            }) {
                Text("Confirm Locations")
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color.purple)
                    .foregroundColor(.white)
                    .cornerRadius(8)
            }
            .padding()
            .disabled(eventLocation == nil || parkingLocation == nil)
        }
        .navigationBarTitle("Select Event and Parking Location", displayMode: .inline)
    }

    private func searchLocation() {
        let request = MKLocalSearch.Request()
        request.naturalLanguageQuery = searchText
        request.region = region

        let search = MKLocalSearch(request: request)
        search.start { response, error in
            guard let response = response else {
                print("Error: \(error?.localizedDescription ?? "Unknown error")")
                return
            }
            searchResults = response.mapItems
            if let firstItem = searchResults.first {
                region.center = firstItem.placemark.coordinate
            }
        }
    }

    private func saveLocations() {
        // Save the eventLocation and parkingLocation to your data model or backend
        print("Event Location: \(eventLocation?.latitude ?? 0), \(eventLocation?.longitude ?? 0)")
        print("Parking Location: \(parkingLocation?.latitude ?? 0), \(parkingLocation?.longitude ?? 0)")
    }
}
struct CreateEventView4: View {
    let eventName: String
    let workoutDescription: String
    let selectedWorkout: String
    let selectedIntensity: String
    let selectedGoal: String
    let selectedType: String
    let selectedPrivacyType: String
    let itemsToBring: String
    let itemsAttendeesWillBring: String
    let selectedImage: UIImage?
    let eventDate: Date
    let eventTime: Date
    let eventDuration: TimeInterval
    let isRecurring: Bool
    let selectedDays: [Int]
    let numberOfWeeks: Int
    let reminderTime: String
    let eventLocation: EventLocation?
    let parkingLocation: EventLocation?

    @State private var shareWithOthers: Bool = false
    @State private var showShareSheet: Bool = false
    @State private var friends: [Friend] = [
        Friend(name: "Alice"),
        Friend(name: "Bob"),
        Friend(name: "Charlie")
    ]
    @State private var selectedFriends: [Friend] = []

    var body: some View {
        VStack(alignment: .leading, spacing: 20) {
            ProgressView(value: 0.8)
                .padding(.top)

            Form {
                Section(header: Text("Share Event").font(.headline)) {
                    Toggle(isOn: $shareWithOthers.animation()) {
                        Text("Share with others")
                            .font(.body)
                    }

                    if shareWithOthers {
                        VStack(alignment: .leading, spacing: 10) {
                            Text("Select Friends")
                                .font(.subheadline)
                                .foregroundColor(.gray)

                            ForEach(friends) { friend in
                                Button(action: {
                                    if selectedFriends.contains(where: { $0.id == friend.id }) {
                                        selectedFriends.removeAll(where: { $0.id == friend.id })
                                    } else {
                                        selectedFriends.append(friend)
                                    }
                                }) {
                                    HStack {
                                        Text(friend.name)
                                            .font(.body)
                                        Spacer()
                                        if selectedFriends.contains(where: { $0.id == friend.id }) {
                                            Image(systemName: "checkmark.circle.fill")
                                                .foregroundColor(.blue)
                                        } else {
                                            Image(systemName: "circle")
                                                .foregroundColor(.gray)
                                        }
                                    }
                                }
                                .buttonStyle(PlainButtonStyle())
                            }
                        }

                        Button(action: {
                            showShareSheet = true
                        }) {
                            HStack {
                                Image(systemName: "square.and.arrow.up")
                                Text("Share via...")
                            }
                            .padding()
                            .background(Color.blue)
                            .foregroundColor(.white)
                            .cornerRadius(8)
                        }
                    }
                }
            }
            .listStyle(GroupedListStyle())

            NavigationLink(destination: EventSummaryView(eventName: eventName, workoutDescription: workoutDescription, selectedWorkout: selectedWorkout, selectedIntensity: selectedIntensity, selectedGoal: selectedGoal, selectedType: selectedType, selectedPrivacyType: selectedPrivacyType, itemsToBring: itemsToBring, itemsAttendeesWillBring: itemsAttendeesWillBring, selectedImage: selectedImage, eventDate: eventDate, eventTime: eventTime, eventDuration: eventDuration, eventLocation: eventLocation, parkingLocation: parkingLocation, isRecurring: isRecurring, selectedDays: selectedDays, numberOfWeeks: numberOfWeeks, reminderTime: reminderTime, shareWithOthers: shareWithOthers)) {
                Text("Next")
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(8)
            }
            .padding(.bottom)
        }
        .navigationBarTitle("Share Event", displayMode: .inline)
        .sheet(isPresented: $showShareSheet) {
            ShareSheet(activityItems: [eventName, eventDate])
        }
    }
}

struct Friend: Identifiable {
    let id = UUID()
    let name: String
}

struct ShareSheet: UIViewControllerRepresentable {
    var activityItems: [Any]
    var applicationActivities: [UIActivity]? = nil

    func makeUIViewController(context: UIViewControllerRepresentableContext<ShareSheet>) -> UIActivityViewController {
        let controller = UIActivityViewController(activityItems: activityItems, applicationActivities: applicationActivities)
        return controller
    }

    func updateUIViewController(_ uiViewController: UIActivityViewController, context: UIViewControllerRepresentableContext<ShareSheet>) {}
}
struct EventSummaryView: View {
    let eventName: String
    let workoutDescription: String
    let selectedWorkout: String
    let selectedIntensity: String
    let selectedGoal: String
    let selectedType: String
    let selectedPrivacyType: String
    let itemsToBring: String
    let itemsAttendeesWillBring: String
    let selectedImage: UIImage?
    let eventDate: Date
    let eventTime: Date
    let eventDuration: TimeInterval
    let eventLocation: EventLocation?
    let parkingLocation: EventLocation?
    let isRecurring: Bool
    let selectedDays: [Int]
    let numberOfWeeks: Int
    let reminderTime: String
    let shareWithOthers: Bool

    var body: some View {
        ScrollView {
            VStack(alignment: .leading) {
                ProgressView(value: 1.0)
                    .padding()

                if let image = selectedImage {
                    Image(uiImage: image)
                        .resizable()
                        .scaledToFit()
                        .frame(width: 100, height: 100)
                        .clipShape(Circle())
                        .overlay(Circle().stroke(Color.gray, lineWidth: 1))
                        .shadow(radius: 5)
                } else {
                    Image(systemName: "camera")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 100, height: 100)
                        .foregroundColor(.gray)
                }
                
                Text("Event Name: \(eventName) ")
                Text("Workout Description: \(workoutDescription)")
                Text("Selected Workout: \(selectedWorkout)")
                Text("Selected Intensity: \(selectedIntensity)")
                Text("Selected Goal: \(selectedGoal)")
                Text("Selected Type: \(selectedType)")
                Text("Selected Privacy Type: \(selectedPrivacyType)")
                Text("Items to Bring: \(itemsToBring)")
                Text("Items Attendees Will Bring: \(itemsAttendeesWillBring)")
                Text("Event Date: \(eventDate.formatted(date: .long, time: .omitted))")
                Text("Event Time: \(eventTime.formatted(date: .omitted, time: .shortened))")
                Text("Event Duration: \(Int(eventDuration) / 60) minutes")
                if let eventloc = eventLocation {
                    Text("Location: \(eventloc.name), \(eventloc.city), \(eventloc.state ?? ""), \(eventloc.country) (\(eventloc.latitude), \(eventloc.longitude))")
                }
                if let parkloc = parkingLocation {
                    Text("Location: \(parkloc.name), \(parkloc.city), \(parkloc.state ?? ""), \(parkloc.country) (\(parkloc.latitude), \(parkloc.longitude))")
                }
                Text("Recurring: \(isRecurring ? "Yes" : "No")")
                if isRecurring {
                    Text("Weekly Days: \(getRecurringDays())")
                    Text("Number of Weeks: \(numberOfWeeks)")
                }
                Text("Reminder Time: \(reminderTime)")
                Text("Share with Others: \(shareWithOthers ? "Yes" : "No")")
                
                Spacer()
                
                Button(action: {
                    // Code to create event goes here
                }) {
                    Text("Complete")
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.purple)
                        .foregroundColor(.white)
                        .cornerRadius(8)
                }
                .padding()
            }
            .padding()
        }
        .navigationTitle("Event Summary")
    }
    
    private func getRecurringDays() -> String {
        let days = ["1", "2", "3", "4", "5", "6", "7"]
        var selectedDaysText = [String]()
        for day in selectedDays {
            selectedDaysText.append(days[day - 1])
        }
        return selectedDaysText.joined(separator: ", ")
    }
}

// ImagePicker
struct ImagePicker: UIViewControllerRepresentable {
    @Binding var selectedImage: UIImage?

    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }

    func makeUIViewController(context: Context) -> UIImagePickerController {
        let picker = UIImagePickerController()
        picker.delegate = context.coordinator
        return picker
    }

    func updateUIViewController(_ uiViewController: UIImagePickerController, context: Context) {}

    class Coordinator: NSObject, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
        let parent: ImagePicker

        init(_ parent: ImagePicker) {
            self.parent = parent
        }

        func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
            if let image = info[.originalImage] as? UIImage {
                parent.selectedImage = image
            }

            picker.dismiss(animated: true)
        }

        func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
            picker.dismiss(animated: true)
        }
    }
}

// ModalView
struct ModalView: View {
    let modalType: String
    @Binding var selectedOption: String
    @Binding var showModal: Bool
    
    var body: some View {
        VStack {
            Text("Select \(modalType)")
                .font(.headline)
            List {
                ForEach(getOptions(), id: \.self) { option in
                    Button(action: {
                        self.selectedOption = option
                        self.showModal = false
                    }) {
                        VStack(alignment: .leading) {
                            Text(option)
                                .font(.headline)
                            Text(getDescription(for: option))
                                .font(.subheadline)
                                .foregroundColor(.gray)
                        }
                    }
                }
            }
        }
    }
    
    private func getOptions() -> [String] {
        switch modalType {
        case "Intensity":
            return ["Low", "Medium", "High"]
        case "Goal":
            return ["Strength", "Aerobics", "Mobility", "Flexibility"]
        case "Type":
            return ["Solo", "Coach"]
        case "PrivacyType":
            return ["Public", "Private"]
        default:
            return []
        }
    }

    private func getDescription(for option: String) -> String {
        switch option {
        case "Low":
            return "Suitable for beginners or those looking for a light workout."
        case "Medium":
            return "A moderate level of intensity suitable for most people."
        case "High":
            return "High intensity for those seeking a challenging workout."
        case "Strength":
            return "Focus on building muscle and increasing strength."
        case "Aerobics":
            return "Improves cardiovascular health and increases endurance."
        case "Mobility":
            return "Enhances range of motion and flexibility."
        case "Flexibility":
            return "Improves the ability to move joints effectively."
        case "Coach":
            return "A person who doesn't participate in the workout and instructs or trains a group or individual."
        case "Spotter":
            return "A person who participates in the workout and assists with the safe performance of exercises."
        case "Solo":
            return "An event for a single participant."
        case "Public":
            return "An event open to everyone."
        case "Private":
            return "An event open only to selected participants."
        default:
            return ""
        }
    }
}

// SelectWorkoutCollectionView and related views
struct SelectWorkoutCollectionView: View {
    @Binding var selectedWorkout: String
    @Binding var showWorkoutSelection: Bool
    @State private var collections: [WorkoutCollections] = MockWorkoutDatas.collections
    
    var body: some View {
        List {
            ForEach(collections) { collection in
                NavigationLink(destination: SelectWorkoutListView(collection: collection, selectedWorkout: $selectedWorkout, showWorkoutSelection: $showWorkoutSelection)) {
                    SelectWorkoutCollectionItemView(collection: collection)
                }
            }
        }
        .navigationBarTitle("Select Workout Collection", displayMode: .inline)
    }
}

struct SelectWorkoutListView: View {
    let collection: WorkoutCollections
    @Binding var selectedWorkout: String
    @Binding var showWorkoutSelection: Bool
    
    var body: some View {
        List {
            ForEach(collection.workouts) { workout in
                Button(action: {
                    self.selectedWorkout = workout.title
                    self.showWorkoutSelection = false
                }) {
                    Text(workout.title)
                }
            }
        }
        .navigationBarTitle("Select Workout", displayMode: .inline)
    }
}

struct SelectWorkoutCollectionItemView: View {
    let collection: WorkoutCollections
    
    var body: some View {
        HStack {
            Text(collection.emoji)
            Text(collection.title)
                .font(.headline)
            Spacer()
            Image(systemName: "chevron.right")
                .foregroundColor(.gray)
        }
    }
}

// Data Models
struct WorkoutCollections: Identifiable {
    let id: UUID = UUID()
    let title: String
    let workouts: [Workouts]
    let emoji: String
    let color: Color
    let type: String = "workout"
}

struct Workouts: Identifiable {
    let id: UUID = UUID()
    let title: String
}

// Mock data
struct MockWorkoutDatas {
    static let collections: [WorkoutCollections] = [
        WorkoutCollections(
            title: "Strength Training",
            workouts: [
                Workouts(title: "Push Ups"),
                Workouts(title: "Pull Ups"),
                Workouts(title: "Deadlift")
            ],
            emoji: "💪",
            color: .red
        ),
        WorkoutCollections(
            title: "Cardio",
            workouts: [
                Workouts(title: "Running"),
                Workouts(title: "Cycling"),
                Workouts(title: "Swimming")
            ],
            emoji: "🏃‍♂️",
            color: .blue
        ),
        WorkoutCollections(
            title: "Flexibility",
            workouts: [
                Workouts(title: "Yoga"),
                Workouts(title: "Stretching"),
                Workouts(title: "Pilates")
            ],
            emoji: "🧘‍♀️",
            color: .green
        )
    ]
}

#Preview {
    CreateEventView()
}
