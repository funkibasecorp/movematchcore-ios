import SwiftUI
import MapKit


struct EventDetailView: View {
    let event: Event
    @State private var cameraPosition = MapCameraPosition.region(
        MKCoordinateRegion(
            center: CLLocationCoordinate2D(latitude: 40.6892, longitude: -74.0445),
            span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01)
        )
    )

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 16) {
                // Header Image
                Image(systemName: "figure.walk")
                    .resizable()
                    .scaledToFill()
                    .frame(height: 300)
                    .foregroundColor(.blue)
                    .clipped()
                    .cornerRadius(10)
                    .padding(.horizontal)
                    .padding(.top)
                    .shadow(radius: 10)

                VStack(alignment: .leading, spacing: 16) {
                    Text("FitFest in the Park")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .padding(.horizontal)

                    Text("Join our exciting fitness festival, where we'll gather outdoors for a day of activity, health, and fun! Experienced instructors will lead dynamic outdoor workouts.")
                        .font(.body)
                        .foregroundColor(.gray)
                        .padding(.horizontal)

                    // Event Details
                    HStack {
                        EventDetailItem(label: "Location", icon: "location.fill", value: "Los Angeles Park")
                        Spacer()
                        EventDetailItem(label: "Duration", icon: "timer", value: "45 minutes")
                        Spacer()
                        EventDetailItem(label: "Date", icon: "calendar", value: "6 June, 18:00")
                    }
                    .padding(.horizontal)

                    // Participants
                    NavigationLink(destination: MembersView()) {
                        HStack {
                            ForEach(0..<5) { index in
                                Image(systemName: "person.crop.circle.fill")
                                    .resizable()
                                    .frame(width: 30, height: 30)
                                    .clipShape(Circle())
                                    .overlay(Circle().stroke(Color.white, lineWidth: 2))
                                    .offset(x: CGFloat(index * -10))
                            }
                            Text("Juliet, Jami, Parry, Allis, Garri and 16 others")
                                .font(.body)
                                .foregroundColor(.blue)
                        }
                        .padding(.horizontal)
                    }

                    // Workout Details
                    NavigationLink(destination: WorkoutPageView()) {
                        HStack {
                            Image(systemName: "figure.walk")
                                .foregroundColor(.white)
                                .padding()
                                .background(Color.purple)
                                .clipShape(Circle())
                            VStack(alignment: .leading) {
                                Text("Bicep Building Blast")
                                    .font(.headline)
                                HStack {
                                    Text("Intermediate")
                                        .font(.caption)
                                        .padding(5)
                                        .background(Color.gray.opacity(0.2))
                                        .cornerRadius(5)
                                    Text("Muscle Gain")
                                        .font(.caption)
                                        .padding(5)
                                        .background(Color.gray.opacity(0.2))
                                        .cornerRadius(5)
                                }
                            }
                            Spacer()
                        }
                        .padding()
                        .background(Color.purple.opacity(0.1))
                        .cornerRadius(10)
                        .padding(.horizontal)
                    }

                    // Organizer Profile
                    NavigationLink(destination: OrganizerProfileView(name: "Chris")) {
                        HStack {
                            Image(systemName: "person.crop.circle")
                                .resizable()
                                .frame(width: 50, height: 50)
                                .clipShape(Circle())
                            VStack(alignment: .leading) {
                                Text("Event Organizer")
                                    .font(.headline)
                                Text("Irvin Jonason")
                                    .font(.body)
                                    .foregroundColor(.blue)
                            }
                            Spacer()
                        }
                        .padding(.horizontal)
                    }

                    // Map
                    VStack(alignment: .leading) {
                        Text("Location Map")
                            .font(.headline)
                            .padding(.horizontal)

                        Map(position: $cameraPosition) {
                            Marker("Event Location", coordinate: CLLocationCoordinate2D(latitude: 40.6892, longitude: -74.0445))
                        }
                        .frame(height: 200)
                        .cornerRadius(10)
                        .padding(.horizontal)
                    }

                    // Additional Details
                    AdditionalDetailSection(title: "What the host will bring", items: ["Bottled Water", "Yoga Mats"])
                    AdditionalDetailSection(title: "What to bring", items: ["Running Shoes", "Towels"])

                    // Worked Muscles
                    VStack(alignment: .leading, spacing: 8) {
                        Text("Worked Muscles")
                            .font(.headline)
                            .padding(.horizontal)
                        HStack {
                            WorkedMuscleItem(muscle: "Abs")
                            WorkedMuscleItem(muscle: "Chest")
                        }
                        .padding(.horizontal)
                    }
                }

                // Register Button
                Button(action: {
                    // Register action
                }) {
                    Text("Register")
                        .font(.headline)
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.purple)
                        .cornerRadius(10)
                        .shadow(radius: 10)
                        .padding()
                }
            }
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

struct MembersView: View {
    var body: some View {
        Text("Members View")
    }
}

struct WorkoutPageView: View {
    var body: some View {
        Text("Workout Page View")
    }
}

struct EventDetailItem: View {
    let label: String
    let icon: String
    let value: String

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Label(label, systemImage: icon)
                .font(.headline)
            Text(value)
                .font(.body)
        }
    }
}

struct AdditionalDetailSection: View {
    let title: String
    let items: [String]

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(title)
                .font(.headline)
                .padding(.horizontal)
            WrapHStack(items: items)
                .padding(.horizontal)
        }
    }
}

struct WorkedMuscleItem: View {
    let muscle: String

    var body: some View {
        VStack {
            Image(systemName: "figure.walk")
                .resizable()
                .frame(width: 50, height: 50)
                .background(Color.gray.opacity(0.2))
                .cornerRadius(10)
            Text(muscle)
                .font(.body)
        }
    }
}

struct HighlightBadge: View {
    let text: String
    let color: Color

    var body: some View {
        Text(text)
            .font(.caption)
            .padding(8)
            .background(color.opacity(0.2))
            .foregroundColor(color)
            .cornerRadius(10)
    }
}

struct WrapHStack: View {
    let items: [String]

    var body: some View {
        VStack(alignment: .leading) {
            ForEach(Array(items.chunked(into: 3)), id: \.self) { rowItems in
                HStack {
                    ForEach(rowItems, id: \.self) { item in
                        Text(item)
                            .font(.caption)
                            .padding(8)
                            .background(Color.gray.opacity(0.2))
                            .cornerRadius(10)
                    }
                }
            }
        }
    }
}

struct AnnotationItem: Identifiable {
    let id = UUID()
    var coordinate: CLLocationCoordinate2D
}

extension Array {
    func chunked(into size: Int) -> [[Element]] {
        stride(from: 0, to: count, by: size).map {
            Array(self[$0..<Swift.min($0 + size, count)])
        }
    }
}

#Preview {
    NavigationStack{
        EventDetailView(event: sampleEvent)
    }
}
