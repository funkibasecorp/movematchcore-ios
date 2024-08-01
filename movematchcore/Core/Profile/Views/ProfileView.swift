//
//  ProfileView.swift
//  spotmatch
//
//  Created by Chris Jones on 5/14/24.
//

import SwiftUI

struct ProfileView: View {
    @State private var pinLockEnabled = true
    @State private var appleHealthEnabled = true
    @State private var darkModeEnabled = false
    @Environment(\.colorScheme) var colorScheme
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack(spacing: 20) {
                    // Profile Header
                    VStack(spacing: 10) {
                        Image(systemName: "person.crop.circle.fill")
                            .resizable()
                            .frame(width: 100, height: 100)
                            .overlay(Circle().stroke(Color.white, lineWidth: 4))
                            .shadow(radius: 10)
                        
                        Text("Chris Jones")
                            .font(.title)
                            .fontWeight(.bold)
                            .foregroundColor(.purple)
                        
                        NavigationLink(destination: UserProfileView()) {
                            Text("See public view")
                                .font(.subheadline)
                                .foregroundColor(.gray)
                        }
                    }
                    .padding(.top, 40)
                    
                    // Workout Buddies and Fitness Age
                    HStack(spacing: 15) {
                        NavigationLink(destination: WorkoutBuddiesView()) {
                            ProfileInfoCard(icon: "person.3.fill", title: "Workout buddies", subtitle: "8+")
                        }
                        NavigationLink(destination: FitnessAgeView()) {
                            ProfileInfoCard(icon: "figure.walk.circle.fill", title: "My Fitness Age", subtitle: "28", detail: "Result expires in 2 days")
                        }
                    }
                    .padding(.horizontal)
                    
                    // Activity Status, Workout History, My QR Code
                    VStack(spacing: 10) {
                        NavigationLink(destination: ActivityStatusView()) {
                            ProfileListItem(title: "Activity Status", value: "Active", textColor: colorScheme == .dark ? .white : .black)
                        }
                        NavigationLink(destination: WorkoutHistoryView()) {
                            ProfileListItem(title: "Workout history", value: "", textColor: colorScheme == .dark ? .white : .black)
                        }
                        NavigationLink(destination: QRCodeView()) {
                            ProfileListItem(title: "My QR code", value: "", textColor: colorScheme == .dark ? .white : .black)
                        }
                    }
                    .padding(.horizontal)
                    
                    // Settings Section
                    VStack(alignment: .leading, spacing: 10) {
                        Text("Settings")
                            .font(.headline)
                            .padding(.horizontal)
                        
                        NavigationLink(destination: AccountView()) {
                            ProfileListItem(title: "Account", value: "", textColor: colorScheme == .dark ? .white : .black)
                        }
                        NavigationLink(destination: PreferenceView()) {
                            ProfileListItem(title: "Preference", value: "", textColor: colorScheme == .dark ? .white : .black)
                        }
                        
                        Toggle(isOn: $pinLockEnabled) {
                            Text("Pin lock")
                        }
                        .padding(.horizontal)
                        
                        Toggle(isOn: $appleHealthEnabled) {
                            Text("Apple Health")
                        }
                        .padding(.horizontal)
                        
                        Toggle(isOn: $darkModeEnabled) {
                            darkModeEnabled ? Text("Light Mode") : Text("Dark Mode")
                        }
                        .padding(.horizontal)
                        .onChange(of: darkModeEnabled) { value in
                            if value {
                                UIApplication.shared.windows.first?.overrideUserInterfaceStyle = .dark
                            } else {
                                UIApplication.shared.windows.first?.overrideUserInterfaceStyle = .light
                            }
                        }
                        
                        NavigationLink(destination: ModeView()) {
                            ProfileListItem(title: "Mode", value: "Light Mode", textColor: colorScheme == .dark ? .white : .black)
                        }
                        NavigationLink(destination: ContactSupportView()) {
                            ProfileListItem(title: "Contact Support", value: "", textColor: colorScheme == .dark ? .white : .black)
                        }
                        NavigationLink(destination: LogoutView()) {
                            ProfileListItem(title: "Logout", value: "", textColor: colorScheme == .dark ? .white : .black)
                        }
                    }
                    .padding(.horizontal)
                    
                    Spacer()
                }
            }
            .background(colorScheme == .dark ? Color.black : Color(.systemGray6)).edgesIgnoringSafeArea(.all)
            .navigationBarTitle("", displayMode: .inline)
            .navigationBarHidden(true)
        }
    }
}

struct ProfileInfoCard: View {
    var icon: String
    var title: String
    var subtitle: String
    var detail: String? = nil
    
    @Environment(\.colorScheme) var colorScheme
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Image(systemName: icon)
                    .resizable()
                    .frame(width: 30, height: 30)
                    .foregroundColor(.purple)
                
                VStack(alignment: .leading) {
                    Text(title)
                        .font(.headline)
                    Text(subtitle)
                        .font(.title)
                        .fontWeight(.bold)
                        .foregroundColor(.purple)
                }
                Spacer()
            }
            if let detail = detail {
                Text(detail)
                    .font(.caption)
                    .foregroundColor(.yellow)
                    .padding(.top, 5)
            }
        }
        .padding()
        .background(colorScheme == .dark ? Color.gray.opacity(0.2) : Color.white)
        .cornerRadius(15)
        .shadow(color: Color.gray.opacity(0.2), radius: 5, x: 0, y: 2)
    }
}

struct ProfileListItem: View {
    var title: String
    var value: String
    var textColor: Color
    
    @Environment(\.colorScheme) var colorScheme
    
    var body: some View {
        HStack {
            Text(title)
                .font(.headline)
                .foregroundColor(textColor)
            Spacer()
            if !value.isEmpty {
                Text(value)
                    .foregroundColor(.gray)
            }
        }
        .padding()
        .background(colorScheme == .dark ? Color.gray.opacity(0.2) : Color.white)
        .cornerRadius(10)
        .shadow(color: Color.gray.opacity(0.2), radius: 5, x: 0, y: 2)
    }
}

struct UserProfileView: View {
    var body: some View {
        ScrollView {
            VStack(spacing: 20) {
                // Profile Header
                ZStack {
                    Color.black
                        .ignoresSafeArea()
                    
                    VStack(spacing: 10) {
                        HStack {
                            Spacer()
                            Image(systemName: "gearshape.fill")
                                .foregroundColor(.white)
                                .padding()
                        }
                        
                        Image(systemName: "person.crop.circle.fill")
                            .resizable()
                            .frame(width: 100, height: 100)
                            .overlay(Circle().stroke(Color.white, lineWidth: 4))
                            .shadow(radius: 10)
                        
                        Text("Pauladx")
                            .font(.title)
                            .fontWeight(.bold)
                            .foregroundColor(.white)
                        
                        HStack(spacing: 15) {
                            Label("Male", systemImage: "figure.stand")
                                .font(.subheadline)
                                .foregroundColor(.white)
                            
                            Label("New York, NY", systemImage: "mappin.and.ellipse")
                                .font(.subheadline)
                                .foregroundColor(.white)
                            
                            Label("32 yo.", systemImage: "calendar")
                                .font(.subheadline)
                                .foregroundColor(.white)
                        }
                        
                        HStack(spacing: 20) {
                            Image(systemName: "link")
                            Image(systemName: "globe")
                            Image(systemName: "envelope")
                            Image(systemName: "photo")
                            Image(systemName: "camera")
                        }
                        .foregroundColor(.white)
                        .font(.title3)
                        
                        Text("Last active: 4 hours ago")
                            .font(.caption)
                            .foregroundColor(.yellow)
                            .padding(.top, 5)
                    }
                    .padding(.top, 40)
                    .background(Color.purple)
                    .cornerRadius(15)
                }
                
                // Personal Info
                PageDetailView()
                
                // Talk to me about
                VStack(alignment: .leading, spacing: 10) {
                    Text("Talk to me about")
                        .font(.headline)
                    
                    HStack {
                        TagView(tag: "Hiking")
                        TagView(tag: "Surfing")
                        TagView(tag: "Technology")
                        TagView(tag: "Dogs")
                    }
                }
                .padding()
                .background(Color.white)
                .cornerRadius(15)
                .shadow(color: Color.gray.opacity(0.2), radius: 5, x: 0, y: 2)
                .padding(.horizontal)
                
                // Statistics
                VStack(alignment: .leading, spacing: 10) {
                    Text("Statistics")
                        .font(.headline)
                    
                    HStack(spacing: 15) {
                        StatisticCard(icon: "chart.bar.fill", title: "Training Level", value: "Advanced")
                        StatisticCard(icon: "star.fill", title: "Rating", value: "4.92")
                    }
                    
                    HStack(spacing: 15) {
                        StatisticCard(icon: "figure.walk.circle.fill", title: "Public Workouts", value: "10")
                        StatisticCard(icon: "calendar", title: "Events", value: "9")
                    }
                    
                    HStack(spacing: 15) {
                        StatisticCard(icon: "person.3.fill", title: "Workout Buddies", value: "32")
                    }
                }.frame(maxWidth: .infinity)
            }
        }
        .background(Color(.systemGray6).edgesIgnoringSafeArea(.all))
        .navigationBarBackButtonHidden(true)
    }
}

struct ProfileDetailRow: View {
    var title: String
    var value: String
    
    var body: some View {
        HStack {
            Text(title)
                .font(.subheadline)
                .foregroundColor(.gray)
            Spacer()
            Text(value)
                .font(.subheadline)
                .foregroundColor(.black)
        }
        .padding(.vertical, 5)
    }
}

struct TagView: View {
    var tag: String
    
    var body: some View {
        Text(tag)
            .font(.subheadline)
            .padding(.horizontal, 15)
            .padding(.vertical, 8)
            .background(Color.purple.opacity(0.1))
            .foregroundColor(.purple)
            .cornerRadius(20)
    }
}

struct StatisticCard: View {
    var icon: String
    var title: String
    var value: String
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Image(systemName: icon)
                    .foregroundColor(.purple)
                Spacer()
            }
            Spacer()
            Text(value)
                .font(.headline)
                .fontWeight(.bold)
                .foregroundColor(.purple)
            Text(title)
                .font(.subheadline)
                .foregroundColor(.gray)
        }
        .padding()
        .frame(width: 150, height: 100)
        .background(Color.white)
        .cornerRadius(15)
        .shadow(color: Color.gray.opacity(0.2), radius: 5, x: 0, y: 2)
    }
}

struct WorkoutBuddiesView: View { var body: some View { Text("Workout Buddies View") } }
struct FitnessAgeView: View { var body: some View { Text("Fitness Age View") } }
struct ActivityStatusView: View { var body: some View { Text("Activity Status View") } }
struct WorkoutHistoryView: View { var body: some View { Text("Workout History View") } }
struct QRCodeView: View { var body: some View { Text("QR Code View") } }
struct AccountView: View { var body: some View { Text("Account View") } }
struct PreferenceView: View { var body: some View { Text("Preference View") } }
struct ModeView: View { var body: some View { Text("Mode View") } }
struct ContactSupportView: View { var body: some View { Text("Contact Support View") } }
struct LogoutView: View { var body: some View { Text("Logout View") } }

#Preview {
    ProfileView()
}

struct PageDetailView: View {
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text("Personal")
                .font(.headline)
            
            ProfileDetailRow(title: "Languages", value: "English")
            Divider()
            ProfileDetailRow(title: "Exercise Time", value: "Mornings, evenings")
            Divider()
            ProfileDetailRow(title: "Accessibility Needs", value: "None")
            Divider()
            ProfileDetailRow(title: "Goal", value: "Gain muscle mass")
            Divider()
            ProfileDetailRow(title: "Member Since", value: "6 months")
        }
        .padding()
        .background(Color.white)
        .cornerRadius(15)
        .shadow(color: Color.gray.opacity(0.2), radius: 5, x: 0, y: 2)
        .padding(.horizontal)
    }
}
