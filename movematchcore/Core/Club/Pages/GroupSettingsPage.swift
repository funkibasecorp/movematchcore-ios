//
//  GroupSettingsPage.swift
//  SpotMatch
//
//  Created by Jake Sax on 7/22/24.
//

import SwiftUI

struct GroupSettingsPage: View {
    
    // MARK: Data
    @Bindable var group: FitnessGroup
    @State private var groupName: String = ""
    @State private var interestTags: String = ""
    @State private var groupDescription: String = ""
    @State private var coverImage: UIImage? = nil
    
    // MARK: UI
    @Binding var navigation: NavigationPath
    @State private var isPresentingPrivacySettings: Bool = false
    
    var body: some View {
        ScrollView {
            VStack(spacing: 40) {
                PageHeaderView(title: "Group Settings", navigation: $navigation)
                VStack(alignment: .leading, spacing: 20) {
                    
                    textField(title: "Group Name", text: $groupName)
                    textField(title: "Interest Tags", text: $interestTags)
                    textField(
                        title: "Description",
                        text: $groupDescription,
                        lineLimit: 5,
                        reservesSpace: true
                    )
                    
                    Text("Cover Image")
                        .bold()
                    
                    Button(action: imageWasPressed) {
                        AsyncImage(url: nil) { image in
                            image.resizable()
                        } placeholder: {
                            Color.brand(.gray)
                        }.aspectRatio(16/9, contentMode: .fit)
                            .clipShape(RoundedRectangle(cornerRadius: 24))
                    }
                    
                    button(text: "Privacy Settings", action: privacySettingsWasPressed)
                    button(text: "Members", action: membersWasPressed)
                    
                    TextButton("Save", action: saveWasPressed)
                    
                }.padding(.horizontal, 20)
                
            }
        }.onAppear {
            groupName = group.name
            groupDescription = group.description
        }
        .navigationDestination(
            isPresented: $isPresentingPrivacySettings
        ) {
            PrivacySettingsPage(group: group, isPresented: $isPresentingPrivacySettings)
        }
        .navigationBarBackButtonHidden()
    }
    
    func textField(
        title: String,
        text: Binding<String>,
        lineLimit: Int = 1,
        reservesSpace: Bool = false
    ) -> some View {
        VStack(alignment: .leading, spacing: 12) {
            Text(title)
                .bold()
            TextField(title, text: text, prompt: Text(title), axis: .vertical)
                .lineLimit(lineLimit, reservesSpace: reservesSpace)
                .padding(20)
                .font(.footnote)
                .background {
                    RoundedRectangle(cornerRadius: 32)
                        .stroke(Color.brand(.lightGray))
                }
        }
    }
    
    func button(text: String, action: @escaping () -> Void) -> some View {
        Button(action: action) {
            HStack {
                Text(text)
                    .bold()
                    .frame(maxWidth: .infinity, alignment: .leading)
                Icon(.chevronRight, size: 16)
            }.padding(20)
                .background {
                    RoundedRectangle(cornerRadius: 100)
                        .stroke(Color.brand(.lightGray))
                }
        }.foregroundColor(brand: .darkGray)
    }
    
    // MARK: Methods
    func imageWasPressed() {
        Haptics.triggerGentleInteractionHaptic()
        
    }
    
    func privacySettingsWasPressed() {
        Haptics.triggerGentleInteractionHaptic()
        isPresentingPrivacySettings = true
    }
    
    func membersWasPressed() {
        Haptics.triggerGentleInteractionHaptic()
        navigation.append(GroupMembersPage.NavRequest(group: group))
    }
    
    func saveWasPressed() {
        Haptics.triggerInteractionHaptic()
        group.name = groupName
        group.description = groupDescription
        navigation.goBack()
    }
    
    // MARK: Data Structures
    struct NavRequest: Hashable {
        var group: FitnessGroup
    }
    
}

extension GroupSettingsPage {
    struct _Preview: View {
        
        @State private var navigation: NavigationPath = .init()
        
        var body: some View {
            NavigationStack(path: $navigation) {
                GroupSettingsPage(
                    group: .testGroupAtlantaRunners,
                    navigation: $navigation
                )
            }
        }
    }
}


#Preview {
    GroupSettingsPage._Preview()
}

