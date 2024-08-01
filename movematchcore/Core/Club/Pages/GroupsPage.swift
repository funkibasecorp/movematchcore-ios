//
//  GroupsPage.swift
//  SpotMatch
//
//  Created by Jake Sax on 7/23/24.
//

import SwiftUI

struct GroupsPage: View {

    @State private var groupList: GroupList = .myGroups
    @State private var myGroups: [FitnessGroup] = []
    @State private var joinedGroups: [FitnessGroup] = []
    @Environment(User.self) private var user
    
    
    // MARK: UI
    @Binding var navigation: NavigationPath
    
    enum GroupList: String, PickerControllable {
        
        case myGroups, joinedGroups
        
        var pickerTitle: String {
            switch self {
            case .myGroups: "My Groups"
            case .joinedGroups: "Joined Groups"
            }
        }
    }
    
    var body: some View {
        VStack {
            HeaderView(title: "Groups", icon: .plus) {
                print("create group")
            }
            
            Divider()
            
            SegmentedPicker(selection: $groupList)
                .padding(.horizontal, 20)
            
            ScrollView {
                switch groupList {
                case .myGroups:
                    GroupListView(
                        groups: $myGroups,
                        isAdmin: true,
                        user: user,
                        navigation: $navigation
                    )
                case .joinedGroups:
                    GroupListView(
                        groups: $joinedGroups,
                        isAdmin: false,
                        user: user,
                        navigation: $navigation
                    )
                }
            }
            
        }
        .onAppear {
            withAnimation {
                myGroups = FitnessGroup.testGroups.filter {
                    $0.createdBy == user.id
                }
                joinedGroups = FitnessGroup.testGroups.filter {
                    $0.createdBy != user.id
                }.map {
                    $0.members.append(user.id)
                    return $0
                }
            }
        }
    }
    
    struct GroupListView: View {
        
        // MARK: Data
        @Binding var groups: [FitnessGroup]
        var isAdmin: Bool
        let user: User
        
        // MARK: UI
        @Binding var navigation: NavigationPath
        
        var body: some View {
            VStack(spacing: 12) {
                ForEach(groups) { group in
                    Button(action: {
                        Haptics.triggerGentleInteractionHaptic()
                        navigation.append(group)
                    }) {                    
                        GroupCardView(
                            group: group,
                            groups: $groups,
                            isAdmin: isAdmin,
                            user: user,
                            navigation: $navigation
                        )
                    }
                }
            }.padding(.top, 8)
        }
        
        struct GroupCardView: View {
            
            // MARK: Data
            let group: FitnessGroup
            @Binding var groups: [FitnessGroup]
            let isAdmin: Bool
            let user: User
            
            // MARK: UI
            @Binding var navigation: NavigationPath
            @State private var isPresentingActionSheet: Bool = false
            
            var body: some View {
                VStack {
                    HStack {
                        // Group Card Emblem
                        Rectangle()
                            .fill(Color.purple.opacity(0.3))
                            .frame(width: 50, height: 50)
                            .overlay(Text("🤝").font(.title))
                            .cornerRadius(20)
                        
                        VStack(alignment: .leading) {
                            Text(group.name)
                                .font(.headline)
                                .foregroundColor(.black)
                            Text("Local Group")
                                .font(.subheadline)
                                .foregroundColor(.gray)
                        }
                        Spacer()
                        
                        Button(action: {
                            isPresentingActionSheet.toggle()
                        }) {
                            Image(systemName: "ellipsis")
                                .resizable()
                                .frame(width: 20, height: 5)
                                .foregroundColor(.black)
                                .padding(10)
                        }
                    }
                    .padding()
                    
                    HStack {
                        HStack(spacing: 5) {
                            Image(systemName: "person.2.fill")
                            Text("3M")
                        }
                        HStack(spacing: 5) {
                            Image(systemName: group.isPublic ? "lock.open.fill" : "lock.fill")
                            Text(group.isPublicText)
                        }
                        HStack(spacing: 5) {
                            Image(systemName: "message.fill")
                            Text("50k")
                        }
                        Spacer()
                    }
                    .padding()
                    .font(.caption)
                    .foregroundColor(.gray)
                }
                .background(Color.white)
                .cornerRadius(20)
                .overlay(
                    RoundedRectangle(cornerRadius: 20)
                        .stroke(Color.gray, lineWidth: 1)
                )
                .padding(.horizontal)
                .groupActionSheet(
                    group: group,
                    isMember: group.members.contains(user.id),
                    isAdmin: isAdmin,
                    groupWasJoined: { _ in },
                    groupWasLeft: { leftGroup in
                        withAnimation {
                            groups.removeAll(where: {$0 == leftGroup})
                        }
                    },
                    groupWasDeleted: { groupToDelete in
                        withAnimation {
                            groups.removeAll(where: {$0 == groupToDelete})
                        }
                    },
                    isPresentingActionSheet: $isPresentingActionSheet,
                    navigation: $navigation
                )

            }
            
        }
        
    }
}

extension GroupsPage {
    struct _Preview: View {
        @State private var navigation: NavigationPath = .init()
        var body: some View {
            NavigationStack(path: $navigation) {
                GroupsPage(navigation: $navigation)
                    .navigationDestination(
                        for: GroupSettingsPage.NavRequest.self
                    ) { request in
                        GroupSettingsPage(
                            group: request.group,
                            navigation: $navigation
                        )
                    }
                    .navigationDestination(
                        for: FitnessGroup.self
                    ) { group in
                        GroupDetailPage(
                            group: group,
                            navigation: $navigation
                        )
                    }
            }
        }
    }
}

#Preview {
    GroupsPage._Preview()
        .environment(User.testUserChris)
}
