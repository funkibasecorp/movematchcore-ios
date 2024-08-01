////
////  GroupsView.swift
////  spotmatch
////
////  Created by Chris Jones on 5/13/24.
////
//
//import SwiftUI
//
//// Replace "currentUser" with the name of the current user
//let currentUser = sampleUsers[0]
//
//let myGroups = mockGroups.filter { $0.createdBy.id == currentUser.id }
//let joinedGroups = mockGroups.filter { $0.createdBy.id != currentUser.id }
//
//struct GroupsView: View {
//    @State private var selectedTab: Int = 0
//    @State private var showCreateGroupView = false
//
//    var body: some View {
//        NavigationView {
//            VStack {
//                SBPageNavHeaderView(
//                    title: "Groups",
//                    destination: CreateGroupView()
//                )
//                
//                Divider()
//                
//                SegmentedControlView(
//                    selectedTab: $selectedTab,
//                    titles: ["My Groups", "Joined Groups"],
//                    backgroundColor: .purple
//                )
//                
//                ScrollView {
//                    if selectedTab == 0 {
//                        MyGroupsView(groups: myGroups)
//                    } else {
//                        JoinedGroupsView(groups: joinedGroups)
//                    }
//                }
//                
//                Spacer()
//            }
//            .navigationTitle("")
//            .navigationBarHidden(true)
//        }
//    }
//}
//
//struct MyGroupsView: View {
//    let groups: [UserGroup]
//
//    var body: some View {
//        ForEach(groups) { group in
//            NavigationLink(destination: GroupHomeView(group: group)) {
//                GroupCardView(group: group, isAdmin: true)
//            }
//            .padding(.horizontal)
//        }
//    }
//}
//
//struct JoinedGroupsView: View {
//    let groups: [UserGroup]
//
//    var body: some View {
//        ForEach(groups) { group in
//            NavigationLink(destination: GroupHomeView(group: group)) {
//                GroupCardView(group: group, isAdmin: false)
//            }
//            .padding(.horizontal)
//        }
//    }
//}
//
//struct GroupActionModalView: View {
//    var body: some View {
//        Text("Group Action Modal")
//    }
//}
//
//struct GroupMemberActionModalView: View {
//    var body: some View {
//        Text("Group Member Action Modal")
//    }
//}
//
//struct GroupAdminActionModalView: View {
//    var body: some View {
//        Text("Group Admin Action Modal")
//    }
//}
//
//struct GroupCardView: View {
//    let group: UserGroup
//    let isAdmin: Bool
//    @State private var showActionModal: Bool = false
//    
//    var body: some View {
//        VStack {
//            HStack {
//                // Group Card Emblem
//                Rectangle()
//                    .fill(Color.purple.opacity(0.3))
//                    .frame(width: 50, height: 50)
//                    .overlay(Text("🤝").font(.title))
//                    .cornerRadius(20)
//                
//                VStack(alignment: .leading) {
//                    Text(group.name)
//                        .font(.headline)
//                        .foregroundColor(.black)
//                    Text("Local Group")
//                        .font(.subheadline)
//                        .foregroundColor(.gray)
//                }
//                Spacer()
//                
//                Button(action: {
//                    showActionModal.toggle()
//                }) {
//                    Image(systemName: "ellipsis")
//                        .resizable()
//                        .frame(width: 20, height: 5)
//                        .foregroundColor(.black)
//                }
//                .sheet(isPresented: $showActionModal) {
//                    if isAdmin {
//                        GroupAdminActionModalView()
//                    } else {
//                        GroupMemberActionModalView()
//                    }
//                }
//            }
//            .padding()
//            
//            HStack {
//                HStack(spacing: 5) {
//                    Image(systemName: "person.2.fill")
//                    Text("3M")
//                }
//                HStack(spacing: 5) {
//                    Image(systemName: group.isPublic ? "lock.open.fill" : "lock.fill")
//                    Text(group.isPublic ? "Public" : "Private")
//                }
//                HStack(spacing: 5) {
//                    Image(systemName: "message.fill")
//                    Text("50k")
//                }
//                Spacer()
//            }
//            .padding()
//            .font(.caption)
//            .foregroundColor(.gray)
//        }
//        .background(Color.white)
//        .cornerRadius(20)
//        .overlay(
//            RoundedRectangle(cornerRadius: 20)
//                .stroke(Color.gray, lineWidth: 1)
//        )
//        .padding(.horizontal)
//    }
//}
//
//#Preview {
//    GroupsView()
//}
