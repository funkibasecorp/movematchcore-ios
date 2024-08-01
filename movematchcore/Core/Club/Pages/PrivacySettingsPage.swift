//
//  PrivacySettingsPage.swift
//  SpotMatch
//
//  Created by Jake Sax on 7/22/24.
//

import SwiftUI

struct PrivacySettingsPage: View {
    
    // MARK: Data
    @Bindable var group: FitnessGroup
    
    // MARK: UI
    @Binding var isPresented: Bool
    @State private var groupPrivacy: FitnessGroup.Privacy = .public
    @State private var locationPrivacy: FitnessGroup.LocationPrivacy = .global
    
    var body: some View {
        VStack {
            PageHeaderView(title: "Privacy Settings", isPresented: $isPresented)
            VStack(spacing: 32) {
                settingSelectorView(
                    title: "Privacy Type",
                    selection: $groupPrivacy,
                    description: "The group will be published in the app and made available for all users"
                )
                settingSelectorView(
                    title: "Location",
                    selection: $locationPrivacy,
                    description: "Local groups are geographically specific, encourages in-person activities. Global focuses on shared interests, enables global virtual connections."
                )
                
                Spacer()
                
                TextButton("Save", action: saveSettingsWasPressed)
            }
            .padding(16)
            .padding(.top, 20)
        }.navigationBarBackButtonHidden()
            .onAppear {
                groupPrivacy = group.privacy
                locationPrivacy = group.locationPrivacy
            }
    }
    
    func settingSelectorView<Selection: PickerControllable>(
        title: String,
        selection: Binding<Selection>,
        description: String
    ) -> some View {
        VStack(spacing: 12) {
            Text(title)
                .font(.subheadline.bold())
                .foregroundColor(brand: .darkGray)
                .frame(maxWidth: .infinity, alignment: .leading)
            SegmentedPicker(selection: selection)
            
            Text(description)
                .font(.caption)
                .foregroundColor(brand: .gray)
                .multilineTextAlignment(.leading)
                .frame(maxWidth: .infinity, alignment: .leading)
        }
    }
    
    // MARK: Methods
    func saveSettingsWasPressed() {
        Haptics.triggerGentleInteractionHaptic()
        group.privacy = groupPrivacy
        group.locationPrivacy = locationPrivacy
        isPresented = false
    }
    
}

// MARK: Previews
extension PrivacySettingsPage {
    struct _Preview: View {
        
        @State private var group: FitnessGroup = .testGroupAtlantaRunners
        
        @State private var isPresented: Bool = true
        
        var body: some View {
            PrivacySettingsPage(group: group, isPresented: $isPresented)
        }
    }
}


#Preview {
    PrivacySettingsPage._Preview()
}
