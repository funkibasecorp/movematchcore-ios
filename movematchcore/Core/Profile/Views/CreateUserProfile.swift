//
//  CreateUserProfile.swift
//  spotmatch
//
//  Created by Chris Jones on 6/6/24.
//

import SwiftUI

class ProfileViewModel: ObservableObject {
    @Published var progress: Double = 0.0
    @Published var name: String = ""
    @Published var userName: String = ""
    @Published var gender: String = ""
    @Published var age: Date = Date()
    @Published var height: String = ""
    @Published var email: String = ""
    @Published var location: String = ""
    @Published var ethnicity: String = ""
    @Published var showGenderPicker: Bool = false
    @Published var showAgePicker: Bool = false
    @Published var showEthnicityPicker: Bool = false
    
    func incrementProgress() {
        if progress >= 0.0 {
            progress += 1.0 / 12.0
        }
    }
}


struct CreateUserProfile: View {
    @StateObject private var viewModel = ProfileViewModel()
    
    var body: some View {
        VStack {
            // Progress Bar
            ProgressView(value: viewModel.progress)
                .progressViewStyle(LinearProgressViewStyle(tint: Color.purple))
                .padding()
            
            Text("Personal details")
                .font(.headline)
                .padding(.top, 20)
            
            Text("Great! Let's get to know each other better.")
                .font(.title2)
                .fontWeight(.bold)
                .padding(.top, 20)
            
            Form {
                TextField("Name", text: $viewModel.name)
                TextField("User name", text: $viewModel.userName)
                Button(action: {
                    viewModel.showGenderPicker.toggle()
                }) {
                    HStack {
                        Text("Gender")
                        Spacer()
                        Text(viewModel.gender.isEmpty ? "Select" : viewModel.gender)
                        Image(systemName: "chevron.right")
                    }
                }
                Button(action: {
                    viewModel.showAgePicker.toggle()
                }) {
                    HStack {
                        Text("Age")
                        Spacer()
                        Text(viewModel.age == Date() ? "Select" : "\(viewModel.age, formatter: DateFormatter.shortDateFormatter)")
                        Image(systemName: "chevron.right")
                    }
                }
                TextField("Height", text: $viewModel.height)
                TextField("Email", text: $viewModel.email)
                TextField("Location", text: $viewModel.location)
                Button(action: {
                    viewModel.showEthnicityPicker.toggle()
                }) {
                    HStack {
                        Text("Ethnicity")
                        Spacer()
                        Text(viewModel.ethnicity.isEmpty ? "Select" : viewModel.ethnicity)
                        Image(systemName: "chevron.right")
                    }
                }
            }
            .padding(.top, 20)
            
            Spacer()
            
            Button(action: {
                viewModel.incrementProgress()
            }) {
                Text("Next")
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color.gray.opacity(0.2))
                    .cornerRadius(10)
                    .padding(.horizontal, 20)
            }
            .disabled(viewModel.progress >= 1.0)
            .padding(.bottom, 20)
        }
        .sheet(isPresented: $viewModel.showGenderPicker) {
            GenderPicker(selectedGender: $viewModel.gender)
        }
        .sheet(isPresented: $viewModel.showAgePicker) {
            AgePicker(selectedDate: $viewModel.age)
        }
        .sheet(isPresented: $viewModel.showEthnicityPicker) {
            EthnicityPicker(selectedEthnicity: $viewModel.ethnicity)
        }
    }
}

extension DateFormatter {
    static var shortDateFormatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateStyle = .short
        return formatter
    }
}

struct GenderPicker: View {
    @Binding var selectedGender: String
    
    var body: some View {
        NavigationView {
            List {
                ForEach(["Male", "Female", "Non-binary"], id: \.self) { gender in
                    Button(action: {
                        selectedGender = gender
                    }) {
                        Text(gender)
                    }
                }
            }
            .navigationTitle("Select Gender")
        }
    }
}

struct AgePicker: View {
    @Environment(\.dismiss) private var dismiss
    @Binding var selectedDate: Date
    
    var body: some View {
        NavigationView {
            VStack {
                DatePicker("Select Age", selection: $selectedDate, displayedComponents: .date)
                    .datePickerStyle(WheelDatePickerStyle())
                    .labelsHidden()
                Spacer()
            }
            .navigationTitle("Select Age")
            .navigationBarItems(trailing: Button("Done") {
                dismiss()
            })
        }
    }
}

struct EthnicityPicker: View {
    @Binding var selectedEthnicity: String
    
    var body: some View {
        NavigationView {
            List {
                ForEach(["Ethnicity 1", "Ethnicity 2", "Ethnicity 3"], id: \.self) { ethnicity in
                    Button(action: {
                        selectedEthnicity = ethnicity
                    }) {
                        Text(ethnicity)
                    }
                }
            }
            .navigationTitle("Select Ethnicity")
        }
    }
}


#Preview {
    CreateUserProfile()
}
