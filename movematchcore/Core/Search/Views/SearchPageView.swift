import SwiftUI
import MapKit

struct SearchPageView: View {
    @State private var query: String = ""
    @State private var selectedDetent: PresentationDetent = .fraction(0.15)
    @StateObject private var locationManager = LocationManager.shared
    @State private var position: MapCameraPosition = .userLocation(fallback: .automatic)
    @State private var isPresentingModal = true
    @State private var selectedSearchType: SearchType?
    @State private var selectedEvent: Event?
    @State private var navigateToEventDetail = false
    @State private var events = sampleEvents

    var body: some View {
        NavigationView {
            ZStack {
                Map(position: $position) {
                    UserAnnotation()
                    ForEach(events) { event in
                        Annotation("Event", coordinate: CLLocationCoordinate2D(latitude: event.location.latitude, longitude: event.location.longitude)) {
                            VStack {
                                Text(event.title)
                                    .font(.caption)
                                Text(event.time)
                                    .font(.caption)
                            }
                            .padding(5)
                            .background(Color.purple.opacity(0.8))
                            .cornerRadius(5)
                            .onTapGesture {
                                selectedEvent = event
                            }
                        }
                    }
                }
                .onChange(of: locationManager.region) { newRegion in
                    withAnimation {
                        position = .region(newRegion)
                    }
                }
                
                if let event = selectedEvent {
                    EventDetailCard(event: event) {
                        selectedEvent = nil
                    } onRegister: {
                        // Handle registration logic here
                    } onMoreDetails: {
                        navigateToEventDetail = true
                    }
                }
                
                VStack {
                    HStack {
                        Button(action: {
                            // Navigate back home
                        }) {
                            Image(systemName: "house.fill")
                                .font(.title)
                                .padding()
                                .background(Color.blue)
                                .foregroundColor(.white)
                                .clipShape(Circle())
                        }
                        Spacer()
                    }

                    HStack {
                        Button(action: {
                            // Navigate back home
                        }) {
                            Image(systemName: "house.fill")
                                .font(.title)
                                .padding()
                                .background(Color.blue)
                                .foregroundColor(.white)
                                .clipShape(Circle())
                        }
                        Spacer()
                    }

                    Spacer()
                    
                }
                
                NavigationLink(
                    destination: EventDetailView(event: selectedEvent ?? sampleEvent),
                    isActive: $navigateToEventDetail
                ) {
                    EmptyView()
                }
                
                NavigationLink(
                    destination: getSearchView(for: selectedSearchType ?? .events)
                        .onDisappear {
                            DispatchQueue.main.async {
                                isPresentingModal = true
                            }
                        },
                    isActive: Binding<Bool>(
                        get: { selectedSearchType != nil },
                        set: { if !$0 { selectedSearchType = nil } }
                    )
                ) {
                    EmptyView()
                }
            }
            .sheet(isPresented: $isPresentingModal) {
                VStack {
                    TextField("Search", text: $query)
                        .textFieldStyle(.roundedBorder)
                        .padding()
                    
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack {
                            ForEach(SearchType.allCases, id: \.self) { type in
                                Button(action: {
                                    selectedSearchType = type
                                    isPresentingModal = false
                                }) {
                                    ButtonView(title: type.rawValue)
                                }
                            }
                        }.padding(.horizontal, 20)
                    }
                    
                    Spacer()
                }
                .presentationDetents([.fraction(0.15), .medium, .large], selection: $selectedDetent)
                .presentationDragIndicator(.visible)
                .interactiveDismissDisabled()
                .presentationBackgroundInteraction(.enabled(upThrough: .medium))
            }
        }
    }
    
    @ViewBuilder
    private func getSearchView(for searchType: SearchType) -> some View {
        switch searchType {
        case .events:
            EventsSearchView()
        case .groups:
            GroupsSearchView()
        case .users:
            UsersSearchView()
        case .equipment:
            EquipSearchView()
        case .exercises:
            ExercisesSearchView()
        case .workouts:
            WorkoutsSearchView()
        }
    }
}

struct ButtonView: View {
    let title: String

    var body: some View {
        Text(title)
            .font(.headline)
            .frame(width: 100, height: 40)
            .background(.purple)
            .foregroundColor(.white)
            .cornerRadius(10)
    }
}

enum SearchType: String, CaseIterable {
    case events = "Events"
    case groups = "Groups"
    case users = "Users"
    case equipment = "Equipment"
    case exercises = "Exercises"
    case workouts = "Workouts"
}

struct EventDetailCard: View {
    let event: Event
    let onClose: () -> Void
    let onRegister: () -> Void
    let onMoreDetails: () -> Void
    
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            HStack {
                Text(event.title)
                    .font(.title)
                    .fontWeight(.bold)
                Spacer()
                Button(action: onClose) {
                    Image(systemName: "xmark.circle.fill")
                        .font(.title)
                        .foregroundColor(.gray)
                }
            }
            Text(event.time)
                .font(.subheadline)
                .foregroundColor(.secondary)
            Text(event.location.name)
                .font(.headline)
            Text(event.description)
                .font(.body)
                .lineLimit(3)
                .foregroundColor(.secondary)
            HStack {
                Button("Register") {
                    onRegister()
                }
                .padding()
                .background(Color.green)
                .foregroundColor(.white)
                .cornerRadius(10)
                Button("More Details") {
                    onMoreDetails()
                }
                .padding()
                .background(Color.blue)
                .foregroundColor(.white)
                .cornerRadius(10)
            }
        }
        .padding()
        .background(Color.white)
        .cornerRadius(15)
        .shadow(radius: 10)
        .padding()
        .transition(.move(edge: .bottom))
    }
}

struct GroupsSearchView: View {
    var body: some View {
        VStack {
            Text("Search for Groups")
                .font(.largeTitle)
                .padding()
            
            // Your search UI here
            
            Spacer()
        }
        .background(Color.blue)
        .navigationTitle("Groups")
    }
}

struct UsersSearchView: View {
    var body: some View {
        VStack {
            Text("Search for Users")
                .font(.largeTitle)
                .padding()
            
            // Your search UI here
            
            Spacer()
        }
        .background(Color.green)
        .navigationTitle("Users")
    }
}

struct EventsSearchView: View {
    var body: some View {
        VStack {
            Text("Search for Users")
                .font(.largeTitle)
                .padding()
            
            // Your search UI here
            
            Spacer()
        }
        .background(Color.green)
        .navigationTitle("Users")
    }
}


struct EquipSearchView: View {
    var body: some View {
        VStack {
            Text("Search for Equipment")
                .font(.largeTitle)
                .padding()
            
            // Your search UI here
            
            Spacer()
        }
        .background(Color.yellow)
        .navigationTitle("Equipment")
    }
}

struct ExercisesSearchView: View {
    var body: some View {
        VStack {
            Text("Search for Exercises")
                .font(.largeTitle)
                .padding()
            
            // Your search UI here
            
            Spacer()
        }
        .background(Color.orange)
        .navigationTitle("Exercises")
    }
}

struct WorkoutsSearchView: View {
    var body: some View {
        VStack {
            Text("Search for Workouts")
                .font(.largeTitle)
                .padding()
            
            // Your search UI here
            
            Spacer()
        }
        .background(Color.purple)
        .navigationTitle("Workouts")
    }
}


#Preview {
    SearchPageView()
}
