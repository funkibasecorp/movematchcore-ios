//
//  CreateGroupView.swift
//  spotmatch
//
//  Created by Chris Jones on 6/20/24.
//

import SwiftUI

// TagSelectionView
struct TagSelectionView: View {
    @Environment(\.presentationMode) var presentationMode
    @Binding var selectedTags: [String]

    let tagCategories = [
        "Gender": ["Male", "Female", "Non-binary", "Other"],
        "Ethnicity": ["Asian", "Black", "Hispanic", "White", "Other"],
        "Sexual Orientation": ["Straight", "Gay", "Lesbian", "Bisexual", "Other"],
        "Interests": ["Yoga", "Running", "Cycling", "Swimming", "Weightlifting", "Pilates", "HIIT", "CrossFit", "Dance", "Hiking"],
        "Activities": ["Gym", "Home Workout", "Outdoor", "Group Classes", "Personal Training"],
        "Age": ["Under 18", "18-24", "25-34", "35-44", "45-54", "55-64", "65+"]
    ]
    
    var body: some View {
        NavigationView {
            List {
                ForEach(tagCategories.keys.sorted(), id: \.self) { category in
                    Section(header: Text(category)) {
                        ForEach(tagCategories[category]!, id: \.self) { tag in
                            MultipleSelectionRow(tag: tag, isSelected: self.selectedTags.contains(tag)) {
                                if self.selectedTags.contains(tag) {
                                    self.selectedTags.removeAll { $0 == tag }
                                } else {
                                    self.selectedTags.append(tag)
                                }
                            }
                        }
                    }
                }
            }
            .navigationBarTitle("Select Tags", displayMode: .inline)
            .navigationBarItems(trailing: Button("Done") {
                self.presentationMode.wrappedValue.dismiss()
            })
        }
    }
}

struct MultipleSelectionRow: View {
    var tag: String
    var isSelected: Bool
    var action: () -> Void

    var body: some View {
        Button(action: self.action) {
            HStack {
                Text(self.tag)
                if self.isSelected {
                    Spacer()
                    Image(systemName: "checkmark")
                }
            }
        }
    }
}

// GroupSummaryView
struct GroupSummaryView: View {
    @Binding var group: UserGroup
    
    var body: some View {
        Form {
            Section(header: Text("Group Information")) {
                Text("Name: \(group.name)")
                Text("Description: \(group.description)")
            }
            
            Section(header: Text("Cover Image")) {
                if let coverImageData = group.coverImage, let uiImage = UIImage(data: coverImageData) {
                    Image(uiImage: uiImage)
                        .resizable()
                        .scaledToFit()
                        .frame(height: 200)
                } else {
                    Text("No cover image")
                }
            }

            Section(header: Text("Privacy Type")) {
                Text(group.isPublic ? "Public" : "Private")
            }

            Section(header: Text("Location Type")) {
                Text(group.isLocal ? "Local" : "Global")
                if group.isLocal, let location = group.location as? Location {
                    Text("City: \(location.city)")
                    Text("State: \(location.state ?? "")")
                    Text("Country: \(location.country)")
                }
            }
        }
        .navigationBarTitle("Group Summary", displayMode: .inline)
    }
}

struct CreateGroupView: View {
    @State private var groupName = ""
    @State private var interestTags = [String]()
    @State private var description = ""
    @State private var coverImage: Image?
    @State private var isPrivate = true
    @State private var isLocal = true
    @State private var city = ""
    @State private var state = ""
    @State private var country = ""
    @State private var showingImagePicker = false
    @State private var showingTagSelection = false
    @State private var showingSummary = false
    @State private var inputImage: UIImage?
    
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Group Information")) {
                    TextField("Name", text: $groupName)
                    Button(action: {
                        showingTagSelection = true
                    }) {
                        Text("Select Tags")
                    }
                    .sheet(isPresented: $showingTagSelection) {
                        TagSelectionView(selectedTags: $interestTags)
                    }
                    TextEditor(text: $description)
                        .frame(height: 100)
                        .foregroundColor(Color.gray)
                }
                
                Section(header: Text("Cover Image")) {
                    if let coverImage = coverImage {
                        coverImage
                            .resizable()
                            .scaledToFit()
                            .frame(height: 200)
                            .onTapGesture {
                                showingImagePicker = true
                            }
                    } else {
                        Button(action: {
                            showingImagePicker = true
                        }) {
                            Text("Add photo")
                        }
                    }
                }

                Section(header: Text("Privacy Type")) {
                    Picker("Privacy", selection: $isPrivate) {
                        Text("Private").tag(true)
                        Text("Public").tag(false)
                    }
                    .pickerStyle(SegmentedPickerStyle())
                }

                Section(header: Text("Location Type")) {
                    Picker("Location", selection: $isLocal) {
                        Text("Local").tag(true)
                        Text("Global").tag(false)
                    }
                    .pickerStyle(SegmentedPickerStyle())

                    if isLocal {
                        TextField("City", text: $city)
                        TextField("State", text: $state)
                        TextField("Country", text: $country)
                    }
                }

                NavigationLink(destination: GroupSummaryView(group: .constant(UserGroup(
                    id: UUID(),
                    name: groupName,
                    description: description,
                    members: [],
                    admins: [],
                    isPublic: !isPrivate,
                    createdDate: Date().description,
                    location: isLocal ? sampleLocation : sampleGlobalLocation ,
                    activities: [],
                    currentChallenge: Challenge(id: UUID(), title: "Default Challenge", description: "Default Description"),
                    leaderboard: [],
                    coverImage: inputImage?.jpegData(compressionQuality: 1.0),
                    isLocal: isLocal,
                    createdBy: sampleUsers[1]
                )))) {
                    Text("Continue")
                        .frame(maxWidth: .infinity, maxHeight: 50)
                        .foregroundColor(.white)
                        .background(Color.blue)
                        .cornerRadius(10)
                }
                .disabled(groupName.isEmpty || interestTags.isEmpty || description.isEmpty || (isLocal && (city.isEmpty || state.isEmpty || country.isEmpty)))
            }
            .navigationBarTitle("New Circle", displayMode: .inline)
            .sheet(isPresented: $showingImagePicker, onDismiss: loadImage) {
                ImagePicker(selectedImage: $inputImage)
            }
        }
    }

    func loadImage() {
        guard let inputImage = inputImage else { return }
        coverImage = Image(uiImage: inputImage)
    }
}
#Preview {
    CreateGroupView()
}
