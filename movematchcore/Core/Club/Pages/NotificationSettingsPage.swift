//
//  NotificationSettingsPage.swift
//  SpotMatch
//
//  Created by Jake Sax on 7/22/24.
//

import SwiftUI

struct NotificationSettingsPage: View {
    
    // MARK: Data
    var groupID: FitnessGroup.ID
    @State private var allowsNotifications: Bool = true
    @State private var allowsMentions: Bool = true
    @State private var allowsLeaderboardUpdates: Bool = true
    @State private var allowsNewChallenges: Bool = true
    @Environment(User.self) private var user
    
    // MARK: UI
    @Binding var isPresented: Bool
    
    var body: some View {
        VStack(spacing: 24) {
            PageHeaderView(title: "Notification Settings", isPresented: $isPresented)
            VStack(alignment: .leading, spacing: 24) {
                HStack {
                    Toggle(isOn: $allowsNotifications) {
                        Text("Allow Notifications")
                            .font(.subheadline.bold())
                    }
                }
                
                Text("Accept Notifications Of")
                    .font(.subheadline.bold())
                
                Group {
                    notificationToggle("Mentions", isOn: $allowsMentions)
                    notificationToggle("Leaderboard updates", isOn: $allowsLeaderboardUpdates)
                    notificationToggle("New challenges", isOn: $allowsNewChallenges)
                }.disabled(!allowsNotifications)
                    .opacity(allowsNotifications ? 1 : 0.5)
                
            }.padding(.horizontal, 16)
            
            Spacer()
            
            TextButton("Save", action: saveWasPressed)
                .padding(20)
            
        }.navigationBarBackButtonHidden()
            .onAppear {
                let existingSettings = user.notificationSettings[groupID]
                allowsNotifications = existingSettings?.allowsNotifications ?? true
                allowsMentions = existingSettings?.allowsMentions ?? true
                allowsLeaderboardUpdates = existingSettings?.allowsLeaderboardUpdates ?? true
                allowsNewChallenges = existingSettings?.allowsNewChallenges ?? true
            }
    }
    
    func notificationToggle(_ title: String, isOn: Binding<Bool>) -> some View {
        HStack {
            Button(action: {
                Haptics.triggerGentleInteractionHaptic()
                isOn.wrappedValue.toggle()
            }) {
                CheckmarkToggle(isOn: isOn)
                Text(title)
                    .font(.subheadline)
                    .foregroundColor(brand: .darkGray)
            }
        }
    }
    
    // MARK: Methods
    func saveWasPressed() {
        Haptics.triggerGentleInteractionHaptic()
        user.notificationSettings[groupID] = .init(
            allowsNotifications: allowsNotifications,
            allowsMentions: allowsMentions,
            allowsLeaderboardUpdates: allowsLeaderboardUpdates,
            allowsNewChallenges: allowsNewChallenges
        )
        isPresented = false
    }
}

extension NotificationSettingsPage {
    struct _Preview: View {
        
        @State private var isPresented: Bool = true
        
        var body: some View {
            NotificationSettingsPage(
                groupID: FitnessGroup.testGroupAtlantaRunners.id,
                isPresented: $isPresented
            )
        }
    }
}

#Preview {
    NotificationSettingsPage._Preview()
        .environment(User.testUserJohn)
}
