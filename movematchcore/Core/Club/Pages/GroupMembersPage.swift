//
//  GroupMembersPage.swift
//  SpotMatch
//
//  Created by Jake Sax on 7/22/24.
//

import SwiftUI

struct GroupMembersPage: View {
    
    // MARK: Data
    @Bindable var group: FitnessGroup
    @State private var admins: [User] = []
    @State private var members: [User] = []
    private var searchResults: [User] {
        searchText.isEmpty ? members : members.filter { $0.name.contains(searchText) }
    }
    private var sortedUsers: [String: [User]] {
        Dictionary(
            grouping: searchResults.sorted(by: { $0.name < $1.name })
        ) {
            String($0.name.prefix(1)).uppercased()
        }
      }
    
    // MARK: UI
    @Binding var navigation: NavigationPath
    @State private var presentedUser: User? = nil
    @State private var isPresentingUserSheet: Bool = false
    @State private var searchText: String = ""
    private let letters = Array("ABCDEFGHIJKLMNOPQRSTUVWXYZ").map { String($0) }
    @State private var letterScrubbedTo: String? = nil
    @FocusState private var isSearching: Bool
    
    var body: some View {
        VStack(spacing: 16) {
            
            PageHeaderView(title: "Members", navigation: $navigation) {
                Button(action: inviteWasPressed) {
                    Text("Invite")
                        .font(.subheadline)
                        .foregroundColor(brand: .darkGray)
                        .padding(16)
                        .frame(height: 56)
                        .background {
                            RoundedRectangle(cornerRadius: 16)
                                .stroke(Color.brand(.lightGray))
                            
                        }
                }
            }
            
            HStack(spacing: 0) {
                Button(action: { isSearching = true }) {
                    Icon(.search, size: 24)
                        .foregroundColor(brand: .gray)
                        .padding(.trailing, 6)
                }
                TextField("Search", text: $searchText, prompt: Text("Search"))
                    .focused($isSearching)
                    .textFieldStyle(.plain)
            }
            .padding(12)
            .background {
                RoundedRectangle(cornerRadius: 100)
                    .stroke(Color.brand(.lightGray))
            }
            .padding(.horizontal, 20)
            
            Divider()
            
            ScrollViewReader { proxy in
                ScrollView {
                    membersListView
                        .padding(.trailing, 12)
                }
                .scrollIndicators(.hidden)
                .frame(width: UIScreen.deviceWidth)
                .overlay(alignment: .trailing) {
                    LetterIndexSidebar(selectedLetter: $letterScrubbedTo)
                        .frame(height: 500, alignment: .trailing)
                }
                .overlay {
                    if let letterScrubbedTo {
                        Text(letterScrubbedTo)
                            .font(.largeTitle).bold()
                            .scaleEffect(2)
                            .allowsHitTesting(false)
                    }
                }
                .onChange(of: letterScrubbedTo) {
                    if let letterScrubbedTo {
                        withAnimation(.snappy(duration: 0.3)) {
                            proxy.scrollTo(letterScrubbedTo, anchor: .top)
                        }
                    }
                }
            }
        }
        .navigationBarBackButtonHidden()
        .adaptiveSheet(isPresented: $isPresentingUserSheet, onDismiss: { presentedUser = nil }) {
            if let user = presentedUser {
                UserSheetContent(
                    user: user,
                    addUserAsAdmin: { admin in
                        admins.append(admin)
                        group.admins.append(admin.id)
                    },
                    removeUserFromGroup: { user in
                        members.removeAll(where: {$0 == user})
                        group.members.removeAll(where: {$0 == user.id})
                    },
                    isPresented: $isPresentingUserSheet,
                    navigation: $navigation
                )
            }
        }
        .onChange(of: presentedUser) {} // this fixes a UI bug
        .mockTask {
            self.members = User.testMockUserList
            self.admins = [.testUserKaisla, .testUserJohn, .testUserChris]
        }
    }
    
    var membersListView: some View {
        VStack(spacing: 16) {
            ForEach(letters, id: \.self) { letter in
                Group {
                    ForEach(sortedUsers[letter] ?? []) { member in
                        Button(action: { memberWasPressed(member) } ) {
                            
                            HStack(spacing: 12) {
                                ProfilePhotoView(
                                    url: URL(string: member.avatarURL ?? ""),
                                    size: 56,
                                    cornerRadius: 20
                                )
                                VStack(alignment: .leading, spacing: 6) {
                                    HStack(spacing: 6) {
                                        Text(member.name)
                                            .font(.subheadline).bold()
                                        
                                        if admins.contains(member) {
                                            HStack(spacing: 4) {
                                                Icon(.checkmarkSealFill, size: 14)
                                                    .foregroundColor(brand: .primaryBlue)
                                                Text("Admin")
                                            }
                                        }
                                        
                                    }.foregroundColor(brand: .black)
                                    
                                    Text(member.location.description)
                                        .foregroundColor(brand: .gray)
                                    
                                }.frame(maxWidth: .infinity, alignment: .leading)
                                    .font(.caption)
                                
                                Icon(.chevronRight, size: 20)
                                    .foregroundColor(brand: .darkGray)
                            }.padding(.horizontal, 20)
                        }
                    }
                }.id(letter)
            }
        }
    }
    
    // MARK: Methods
    func inviteWasPressed() {
        Haptics.triggerGentleInteractionHaptic()
    }
    
    func memberWasPressed(_ member: User) {
        Haptics.triggerGentleInteractionHaptic()
        presentedUser = member
        isPresentingUserSheet = true
    }
    
    // MARK: Data Structures
    struct NavRequest: Hashable {
        var group: FitnessGroup
    }
}

extension GroupMembersPage {
    struct _Preview: View {
        
        @State private var admins: [User] = [.testUserJohn]
        @State private var members: [User] = [User.testUserJohn] + User.testMockUserList
        
        @State private var navigation: NavigationPath = .init()
        
        var body: some View {
            GroupMembersPage(
                group: FitnessGroup.testGroupAtlantaRunners,
                navigation: $navigation
            )
        }
    }
}


#Preview {
    GroupMembersPage._Preview()
}
