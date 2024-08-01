//
//  GroupDetailPage.swift
//  SpotMatch
//
//  Created by Jake Sax on 7/22/24.
//

import SwiftUI

struct GroupDetailPage: View {
    
    // MARK: Data
    var group: FitnessGroup
    @State private var members: [User] = []
    @State private var admins: [User] = []
    @Environment(User.self) private var user
    
    // MARK: UI
    @Binding var navigation: NavigationPath
    @State private var isPresentingActionSheet: Bool = false
    @State private var isPresentingShareSheet: Bool = false
    
    var body: some View {
        ScrollView {
            VStack {
                topToolbar
                
                VStack(spacing: 24) {
                    groupTitle
                    
                    AboutSection(
                        group: group,
                        members: members,
                        admins: admins,
                        navigation: $navigation
                    )
                    .sectionBKGD()
                    
                    GroupLeaderboardsSection(group: group)
                        .sectionBKGD()
                    
                    TextButton("Join Group", action: joinGroupWasPressed)
                    
                }.padding(.horizontal, 20)
                    .padding(.top, 120)
            }
        }.background(Color.blue, ignoresSafeAreaEdges: .all)
            .navigationBarBackButtonHidden()
            .adaptiveSheet(isPresented: $isPresentingShareSheet) {
                ShareGroupSheetContent(isPresented: $isPresentingShareSheet)
            }
            .groupActionSheet(
                group: group,
                isMember: members.contains(user),
                isAdmin: admins.contains(user),
                groupWasJoined: { _ in
                    if !members.contains(user) {
                        withAnimation {
                            members.append(user)
                        }
                    }
                },
                groupWasLeft: { _ in
                    withAnimation {
                        members.removeAll(where: {$0.id == user.id})
                        admins.removeAll(where: {$0.id == user.id})
                    }
                }, groupWasDeleted: { _ in
                    navigation.goBack()
                },
                isPresentingActionSheet: $isPresentingActionSheet,
                navigation: $navigation
            )
            .mockTask {
                self.members = User.testMockUserList
                self.admins = [.testUserKaisla, .testUserJohn, .testUserChris]
            }
          
    }
    
    var topToolbar: some View {
        TopToolbar(
            leadingButtons: [
                .init(
                    icon: .chevronLeft,
                    action: { navigation.goBack() }
                )
            ],
            trailingButtons:  [
                .init(
                    icon: .share,
                    yOffset: -2,
                    action: shareGroupWasPressed
                ),
                .init(icon: .ellipsis, action: groupSettingsWasPressed)
            ]
        )
    }
    
    var groupTitle: some View {
        Text(group.name)
            .font(.title).bold()
            .foregroundStyle(.white)
            .frame(maxWidth: .infinity, alignment: .leading)
    }
    
    // MARK: Methods
    func joinGroupWasPressed() {
        Haptics.triggerInteractionHaptic()
        
    }
    
    func shareGroupWasPressed() {
        Haptics.triggerGentleInteractionHaptic()
        isPresentingShareSheet = true
    }
    
    func groupSettingsWasPressed() {
        Haptics.triggerGentleInteractionHaptic()
        isPresentingActionSheet = true
    }
}

extension GroupDetailPage {
    
    // MARK: Supporting Views
    static func sectionTitle(_ title: String) -> some View {
        Text(title)
            .font(.title2).bold()
            .foregroundColor(brand: .black)
            .frame(maxWidth: .infinity, alignment: .leading)
    }
    
    struct AboutSection: View {
        
        // MARK: Data
        var group: FitnessGroup
        @State private var latestActivity: (any AnyActivity)? = nil
        @State private var activeGroupChallenge: Challenge? = nil
        var members: [User] = []
        var admins: [User] = []
        private var memberPhotoURLs: [String?] {
            members.map(\.avatarURL)
        }
        private var adminPhotoURLs: [String?] {
            admins.map(\.avatarURL)
        }
        
        // MARK: UI
        @Binding var navigation: NavigationPath
        
        var body: some View {
            VStack(alignment: .leading, spacing: 12) {
                GroupDetailPage.sectionTitle("About")
                
                VStack(alignment: .leading, spacing: 12) {
                    Text(group.description)
                        .font(.subheadline)
                    
                    VStack(alignment: .leading, spacing: 8) {
                        
                        HStack {
                            Icon(.infoCircleFill, size: 16)
                            Text("Created \(group.creationDate.formatAsFullDate()) • \(group.isPublicText)")
                        }
                        
                        HStack {
                            Icon(.mapPinCircleFill, size: 16)
                            Text("Local - \(group.location)")
                        }
                    }
                    .font(.caption2)
                    .lineLimit(1)
                    .foregroundColor(brand: .gray)
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .subsectionBKGD()
                
                HStack(spacing: 12) {
                    Button(action: membersWasPressed) {
                        subsection("Members") {
                            profilePhotoStack(urls: memberPhotoURLs)
                        }
                    }
                    
                    Button(action: membersWasPressed) {
                        subsection("Admins") {
                            profilePhotoStack(urls: adminPhotoURLs)
                        }
                    }
                }
                
                Button {
                    navigation.append(GroupActivityFeedPage.NavRequest(group: group))
                } label: {
                    subsection("Activity Feed") {
                        if let latestActivity {
                            HStack(alignment: .top) {
                                Circle()
                                    .frame(width: 32, height: 32)
                                    .foregroundStyle(.pink)
                                    .overlay {
                                        Icon(.personFill, size: 24)
                                            .foregroundColor(brand: .black)
                                    }
                                VStack(alignment: .leading, spacing: 0) {
                                    HStack {
                                        Text(latestActivity.user.name)
                                        Text("•")
                                        Text(latestActivity.date.formatAsTimeAgo())
                                    }.foregroundColor(brand: .gray)
                                        .font(.caption)
                                    Text(latestActivity.text)
                                        .font(.footnote)
                                        .foregroundColor(brand: .darkGray)
                                        .lineLimit(2)
                                }
                            }
                        }
                    }
                }
                
                subsection("Group Challenge") {
                    if let activeGroupChallenge {
                        Button {
                            navigation.append(activeGroupChallenge)
                        } label: {
                            HStack {
                                Circle()
                                    .frame(width: 32, height: 32)
                                    .foregroundStyle(.purple)
                                    .overlay {
                                        Icon(.medalFill, size: 24)
                                            .foregroundColor(brand: .black)
                                    }
                                Text(activeGroupChallenge.title)
                                    .font(.subheadline)
                                    .foregroundColor(brand: .darkGray)
                            }.frame(maxWidth: .infinity, alignment: .leading)
                        }
                    }
                }
            }
            .mockTask {
                self.latestActivity = Post.testPost1
            }
            .mockTask {
                self.activeGroupChallenge = Challenge.testChallenge1
            }
        }
        
        @ViewBuilder func subsection<Content: View>(
            _ title: String,
            @ViewBuilder content: () -> Content
        ) -> some View {
            VStack(spacing: 12) {
                Text(title)
                    .font(.subheadline).bold()
                    .foregroundColor(brand: .darkGray)
                    .frame(maxWidth: .infinity, alignment: .leading)

                content()
            }.subsectionBKGD()
        }
        
        func profilePhotoStack(urls: [String?]) -> some View {
            PhotoHStack(
                urls: urls,
                size: 32,
                maxThumbnails: 5,
                backgroundColor: .brand(.white),
                exceededMaxThumbnailFont: .footnote.bold(),
                placeholder: {
                    Circle()
                        .fill(Color.brand(.gray))
                        .stroke(Color.brand(.white), lineWidth: 1)
                        
                }
            ).frame(maxWidth: .infinity, alignment: .leading)
        }
        
        // MARK: Methods
        func membersWasPressed() {
            Haptics.triggerGentleInteractionHaptic()
            navigation.append(GroupMembersPage.NavRequest(group: group))
        }
        
    }
    
  
    struct GroupLeaderboardsSection: View {
        
        var group: FitnessGroup
        @State private var ranking: [LeaderboardRanking]? = nil
        
        var body: some View {
            VStack {
                header
                rankingList
            }.mockTask {
                ranking = [
                    .init(user: .testUserJohn, place: 1, challengeCount: 11),
                    .init(user: .testUserAbramGeorge, place: 2, challengeCount: 9),
                    .init(user: .testUserKaisla, place: 3, challengeCount: 5)
                ]
            }
        }
        
        var header: some View {
            HStack(alignment: .top) {
                
                VStack(alignment: .leading, spacing: 0) {
                    GroupDetailPage.sectionTitle("Group")
                    GroupDetailPage.sectionTitle("Leaderboards")
                }
                
                Button(action: trophyButtonWasPressed) {
                    HStack {
                        Icon(.trophy, size: 20)
                        Text("64")
                            .font(.subheadline).bold()
                    }
                    .foregroundColor(brand: .darkGray)
                    .padding(.horizontal, 12)
                    .padding(.vertical, 8)
                    .background {
                        RoundedRectangle(cornerRadius: 32)
                            .foregroundColor(brand: .secondaryNeonGreen)
                    }
                }
                
            }
        }
        
        var rankingList: some View {
            VStack(spacing: 10) {
                if let ranking {
                    ForEach(ranking, id: \.user.id) { rankingItem in
                        HStack(spacing: 8) {
                            ProfilePhotoView(url: nil, size: 48, cornerRadius: 12)
                                .overlay(alignment: .bottomTrailing) {
                                    Group {
                                        Circle()
                                            .frame(width: 16, height: 16)
                                            .foregroundColor(brand: .secondaryNeonGreen)
                                            .overlay {
                                                Text(rankingItem.place.description)
                                                    .font(.caption2.bold())
                                                    .foregroundColor(brand: .darkGray)
                                            }
                                    }.offset(x: 4, y: 4)
                                }
                            Text(rankingItem.user.name)
                                .frame(maxWidth: .infinity, alignment: .leading)
                            
                            Text(rankingItem.challengeCount.description)
                                .multilineTextAlignment(.trailing)
                        }.font(.subheadline.bold())
                            .lineLimit(1)
                            .foregroundColor(brand: .darkGray)
                            .padding(.trailing, 16)
                            .padding(4)
                            .background {
                                RoundedRectangle(cornerRadius: 16)
                                    .foregroundColor(brand: .white)
                            }
                    }
                }
            }
        }
        
        // MARK: Methods
        func trophyButtonWasPressed() {
            Haptics.triggerGentleInteractionHaptic()
            print("trophy pressed")
        }
        
        // MARK: Data Structures
        struct LeaderboardRanking: Codable {
            var user: User
            var place: Int
            var challengeCount: Int
        }
        
    }
}

fileprivate extension View {
    func sectionBKGD() -> some View {
        self
            .padding(16)
            .background {
                RoundedRectangle(cornerRadius: 24)
                    .foregroundColor(brand: .lightGray)
            }
    }
    
    func subsectionBKGD() -> some View {
        self
            .padding(16)
            .background {
                RoundedRectangle(cornerRadius: 20)
                    .foregroundColor(brand: .white)
            }
    }
}

extension GroupDetailPage {
    struct _Preview: View {
        
        @State private var navigation: NavigationPath = .init()
        @State private var group: FitnessGroup = .testGroupAtlantaRunners
        
        var body: some View {
            NavigationStack(path: $navigation) {
                GroupDetailPage(
                    group: group,
                    navigation: $navigation
                )
                .navigationDestination(
                    for: GroupActivityFeedPage.NavRequest.self
                ) { navRequest in
                    GroupActivityFeedPage(
                        group: navRequest.group,
                        navigation: $navigation
                    )
                }
                .navigationDestination(
                    for: Challenge.self
                ) { challenge in
                    GroupChallengeDetailPage(
                        challenge: challenge,
                        navigation: $navigation
                    )
                }
                .navigationDestination(for: GroupMembersPage.NavRequest.self) { request in
                    GroupMembersPage(
                        group: request.group,
                        navigation: $navigation
                    )
                }
                .navigationDestination(
                    for: GroupSettingsPage.NavRequest.self
                ) { request in
                    GroupSettingsPage(
                        group: request.group,
                        navigation: $navigation
                    )
                }
            }
        }
    }
}


#Preview {
    GroupDetailPage._Preview()
        .environment(User.testUserAbramGeorge)
}
