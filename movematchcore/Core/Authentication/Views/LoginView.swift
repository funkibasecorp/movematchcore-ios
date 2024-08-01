//
//  LoginView.swift
//  spotmatch
//
//  Created by Chris Jones on 5/12/24.
//

import SwiftUI

struct LoginView: View {
    @State private var phoneNumber: String = ""
    @State private var isShowingCountrySelector = false
    @State private var selectedCountryCode: String = "+380"  // Default country code

    var body: some View {
        NavigationView {
            VStack {
                Spacer()
                Image(systemName: "chevron.down")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 120, height: 120)
                    .padding()
                
                HStack {
                    // Country Code Button
                    Button(action: {
                        isShowingCountrySelector = true
                    }) {
                        HStack {
                            Text(selectedCountryCode)
                                .foregroundColor(.black)
                                .font(.caption)
                            Spacer()
                            Image(systemName: "chevron.down")
                                .foregroundColor(.gray)
                        }
                        .frame(height: 24)
                        .modifier(TextFieldModifier())
                    }
                    .sheet(isPresented: $isShowingCountrySelector) {
                        CountrySelectorView(selectedCountryCode: $selectedCountryCode)
                    }
                    
                    // Phone Number Input
                    TextField("Phone number", text: $phoneNumber)
                        .frame(width: 220, height: 24)
                        .modifier(TextFieldModifier())
                }
                .padding(.top, 20)

                Button {

                } label: {
                    Text("Next")
                        .frame(width: 352, height: 44)
                        .modifier(PrimaryButtonModifier())
                }
                
                .padding(.top, 20)
                
                OrSeparator()
                    .padding(.vertical, 20)

                // Social Media Login Buttons
                SocialLoginButtons()

                Spacer()
                
                FooterView()
                    .padding()

            }
            .padding()
            .navigationTitle("Login or Register")
        }
    }
}

struct FooterView: View {
    var body: some View {
        VStack {
            Text("By creating a new account, you agree to the SpotMatch ")
            HStack {
                NavigationLink(destination: PrivacyPolicyView()) {
                    Text("Privacy Policy")
                        .underline()
                        .foregroundColor(.purple)
                        .fontWeight(.semibold)
                }
                Text("and")
                NavigationLink(destination: TermsAndConditionsView()) {
                    Text("Terms & Conditions")
                        .underline()
                        .foregroundColor(.purple)
                        .fontWeight(.semibold)
                }
            }
        }
        .frame(width: 500)
        .multilineTextAlignment(.center)
        .padding()
        .font(.footnote)
    }
}

struct PrivacyPolicyView: View {
    var body: some View {
        Text("Privacy Policy Content Goes Here")
    }
}

struct TermsAndConditionsView: View {
    var body: some View {
        Text("Terms and Conditions Content Goes Here")
    }
}

struct Country: Identifiable {
    let id = UUID()
    let name: String
    let code: String
    let imageName: String
}

// Sample data
let countries = [
    Country(name: "Australia", code: "+61", imageName: "australia"),
    Country(name: "Brazil", code: "+55", imageName: "brazil"),
    Country(name: "Canada", code: "+1", imageName: "canada"),
    Country(name: "China", code: "+86", imageName: "china"),
    Country(name: "France", code: "+33", imageName: "france"),
    Country(name: "Germany", code: "+49", imageName: "germany"),
    Country(name: "India", code: "+91", imageName: "india"),
    Country(name: "Italy", code: "+39", imageName: "italy"),
    Country(name: "Japan", code: "+81", imageName: "japan"),
    Country(name: "Mexico", code: "+52", imageName: "mexico"),
    Country(name: "Netherlands", code: "+31", imageName: "netherlands"),
    Country(name: "Russia", code: "+7", imageName: "russia"),
    Country(name: "South Africa", code: "+27", imageName: "south_africa"),
    Country(name: "South Korea", code: "+82", imageName: "south_korea"),
    Country(name: "Spain", code: "+34", imageName: "spain"),
    Country(name: "United Kingdom", code: "+44", imageName: "united_kingdom"),
    Country(name: "United States", code: "+1", imageName: "united_states")
]

struct CountrySelectorView: View {
    @Binding var selectedCountryCode: String
    @State private var searchText = ""
    @Environment(\.presentationMode) var presentationMode
    let sortedCountries = countries.sorted { $0.name < $1.name }

    var body: some View {
        NavigationView {
            VStack {
                TextField("Search", text: $searchText)
                    .padding(.vertical, 12)
                    .padding(.horizontal)
                    .background(Color.white)
                    .cornerRadius(30)
                    .shadow(radius: 1)
                    .frame(height: 48)
                    .padding(.horizontal)
                    .onChange(of: searchText, initial: false) { _, newSearchText in
                        // Optionally implement reactive search filtering here
                    }

                List {
                    Section(header: Text("Countries")) {
                        ForEach(filteredCountries(sortedCountries)) { country in
                            countryRow(country)
                        }
                    }
                }
                .listStyle(PlainListStyle())  // Ensures full white background for the list
            }
            .background(Color.white)  // Ensure the background of the VStack is white
            .navigationTitle("Select a Country")
            .padding(.vertical, 12)
            .toolbar {
                Button("Close") {
                    presentationMode.wrappedValue.dismiss()
                }
            }
        }
        .background(Color.black.opacity(0.6))  // Dimming effect for modal background
    }

    private func countryRow(_ country: Country) -> some View {
        HStack {
            Image(country.imageName) // Ensure images are added to your assets
                .resizable()
                .scaledToFit()
                .frame(width: 30, height: 20)
            Text("\(country.name) \(country.code)")
        }
        .onTapGesture {
            selectedCountryCode = country.code
            presentationMode.wrappedValue.dismiss()  // Close the view upon selection
        }
    }

    private func filteredCountries(_ countries: [Country]) -> [Country] {
        if searchText.isEmpty {
            return countries
        } else {
            return countries.filter {
                $0.name.lowercased().contains(searchText.lowercased()) ||
                $0.code.contains(searchText)
            }
        }
    }
}

struct SocialLoginButtons: View {
    var body: some View {
        VStack(spacing: 10) {
            // Apple Sign-In Button
            Button(action: {}) {
                HStack {
                    Image(systemName: "applelogo")
                        .foregroundColor(.black)
                    Text("Continue with Apple")
                        .foregroundColor(.black)
                        .fontWeight(.semibold)
                }
                .modifier(SocialLoginButtonModifier())
            }

            // Google Sign-In Button
            Button(action: {}) {
                HStack {
                    Image(systemName: "applelogo")
                        .foregroundColor(.black)
                    Text("Sign up with Google")
                        .foregroundColor(.black)
                        .fontWeight(.semibold)
                }
                .modifier(SocialLoginButtonModifier())
            }
        }
        .padding(.horizontal)
        .padding(.top, 20)
    }
}

struct OrSeparator: View {
    var body: some View {
        HStack {
            line
            Text("or")
                .font(.caption)
                .foregroundColor(.gray)
                .padding(.horizontal, 8)
            line
        }
    }
    
    private var line: some View {
        Rectangle()
            .frame(height: 1)
            .foregroundColor(.gray)
            .opacity(0.5)
    }
}


#Preview {
    LoginView()
}
