//
//  TabBarView.swift
//  spotmatch
//
//  Created by Chris Jones on 5/12/24.
//

import SwiftUI

class TabBarVisibility: ObservableObject {
    @Published var isTabBarVisible: Bool = true
}

struct TabBarView: View {
    @StateObject private var tabBarVisibility = TabBarVisibility()
    @State private var navigation: NavigationPath = .init() 
    @State private var selection = 0

    var body: some View {
        ZStack(alignment: .bottom) {
            // Display content based on selection
            Group {
                switch selection {
                case 0:
                    HomeView()
                case 1:
                    EventsView()
                case 2:
                    FavoritesView()
                case 3:
                    SearchPageView()
                case 4:
                    NavigationStack(path: $navigation) {
                        GroupsPage(navigation: $navigation)
                            .navigationDestination(
                                for: FitnessGroup.self
                            ) { group in
                                GroupDetailPage(
                                    group: group,
                                    navigation: $navigation
                                )
                            }
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
                    .environment(User.testUserChris)
                default:
                    HomeView()
                }
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .edgesIgnoringSafeArea(.all)
            
            // Floating tab bar
            if tabBarVisibility.isTabBarVisible {
                HStack {
                    FloatingTabItemView(
                        imageName: "house.fill",
                        isSelected: selection == 0,
                        tabName: "Home"
                    )
                    .onTapGesture { selection = 0 }
                    
                    FloatingTabItemView(
                        imageName: "calendar",
                        isSelected: selection == 1,
                        tabName: "Events"
                    )
                    .onTapGesture { selection = 1 }
                    
                    FloatingTabItemView(
                        imageName: "heart",
                        isSelected: selection == 2,
                        tabName: "Favorites"
                    )
                    .onTapGesture { selection = 2 }
                    
                    FloatingTabItemView(
                        imageName: "magnifyingglass",
                        isSelected: selection == 3,
                        tabName: "Search"
                    )
                    .onTapGesture {
                        tabBarVisibility.isTabBarVisible = false
                        selection = 3
                    }
                    
                    FloatingTabItemView(
                        imageName: "person.2.fill",
                        isSelected: selection == 4,
                        tabName: "Groups"
                    )
                    .onTapGesture { selection = 4 }
                }
                .frame(width: 325, height: 85)
                .padding(.horizontal, 20)
                .background(Color.black) // Slightly transparent black background
                .cornerRadius(50)
                .shadow(radius: 10)
                .animation(.easeInOut, value: selection)
                .transition(.move(edge: .bottom))
            }
        }
        .environmentObject(tabBarVisibility)
    }
}


struct FloatingTabItemView: View {
    var imageName: String
    var isSelected: Bool
    var tabName: String

    var body: some View {
        VStack {
            Image(systemName: imageName)
                .resizable()
                .scaledToFit()
                .frame(width: 24, height: 24)
                .foregroundColor(isSelected ? .white : .gray)
            Text(tabName)
                .foregroundColor(.white)
                .fontWeight(.regular)
                .font(.caption)
        }
        .frame(width: 60, height: 50)
    }
}

// Preview
#Preview {
    TabBarView()
        .environmentObject(TabBarVisibility())
}
