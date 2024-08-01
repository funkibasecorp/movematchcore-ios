import SwiftUI
import MapKit

struct EventDetailViews: View {
    let event: Event
    @Environment(\.dismiss) var dismiss
    @State private var cameraPosition: MapCameraPosition
    
    init(event: Event) {
        self.event = event
        
        self._cameraPosition = State(initialValue: .region(MKCoordinateRegion(
            center: CLLocationCoordinate2D(latitude: 40.6892, longitude: -74.0445),
            span: MKCoordinateSpan(latitudeDelta: 0.1, longitudeDelta: 0.1))
        ))
    }
        
    var body: some View {
        ScrollView {
            ZStack(alignment: .topLeading) {
                TabView {
                    ForEach(event.images.indices, id: \.self) { index in
                        Color.gray
                    }
                }
                .frame(height: 320)
                .tabViewStyle(.page(indexDisplayMode: .never))
                
                Image(systemName: "chevron.left")
                    .foregroundColor(.black)
                    .background(
                        Circle()
                            .fill(.white)
                            .frame(width: 32, height: 32)
                    )
                    .onTapGesture {
                        dismiss()
                    }
                .padding(.top, 40)
                .padding(.leading, 32)
            }
            
            VStack(alignment: .leading, spacing: 8) {
                Text(event.title)
                    .font(Font.custom("Gilroy-SemiBoldItalic", size: 30))
                    .fontWeight(.semibold)
                
                DetailsView(title: "Description", description: event.description)
            }
            .padding()
            
            InfoView()
            
            DetailImageView(title: "Organizer", image: Image(systemName: "person.fill"), description: event.organizer.name)
                .frame(width: 400)
            
            DetailsView(title: "What the Host will bring", description: event.description)
            
            DetailsView(title: "What you will bring", description: event.description)
            
            VStack(alignment: .leading, spacing: 16) {
                Text("Where you'll be")
                    .font(.headline)
                    .fontWeight(.semibold)
                
                Map(position: $cameraPosition)
                    .frame(height: 200)
                    .cornerRadius(12)
            }
            .padding()
        }
        .padding(.bottom, 72)
        .overlay(alignment: .bottom, content: {
            VStack {
                Divider()
                    .padding(.bottom)
                HStack {
                    VStack(alignment: .leading) {
                        Text("$500")
                            .font(.subheadline)
                            .fontWeight(.semibold)
                        
                        Text("Total before taxes")
                            .font(.footnote)
                        
                        Text("Oct 15 - 20")
                            .font(.footnote)
                            .fontWeight(.semibold)
                            .underline()
                    }
                    
                    Spacer()
                    
                    Button {
                        print("DEBUG: Reserve event here..")
                    } label: {
                        Text("Reserve")
                            .foregroundColor(.white)
                            .font(.subheadline)
                            .fontWeight(.bold)
                            .frame(width: 200, height: 40)
                            .background(.purple)
                            .cornerRadius(8)
                    }
                }
                .padding(.horizontal, 36)
            }
            .background(.white)
        })
        .toolbar(.hidden, for: .tabBar)
        .ignoresSafeArea(edges: .top)
    }
}

#Preview {
    EventDetailViews(event: sampleEvent)
}

