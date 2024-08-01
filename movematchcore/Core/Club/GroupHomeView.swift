////
////  GroupHomeView.swift
////  spotmatch
////
////  Created by Chris Jones on 6/23/24.
////
//
//import SwiftUI
//
//struct GroupHomeView: View {
//    let group: UserGroup
//    
//    var body: some View {
//        NavigationView {
//            ScrollView {
//                VStack(alignment: .leading, spacing: 20) {
//                    // Header Section
//                    HStack {
//                        NavigationLink(destination: PreviousScreenView()) {
//                            Image(systemName: "chevron.left")
//                                .font(.title)
//                        }
//                        Text(group.name)
//                            .font(.largeTitle)
//                            .bold()
//                        Spacer()
//                        Button(action: {
//                            // Share action
//                        }) {
//                            Image(systemName: "square.and.arrow.up")
//                                .font(.title)
//                        }
//                        Button(action: {
//                            // Options action
//                        }) {
//                            Image(systemName: "ellipsis.circle")
//                                .font(.title)
//                        }
//                    }
//                    
//                    // About Section
//                    VStack(alignment: .leading, spacing: 10) {
//                        Text("About")
//                            .font(.title2)
//                            .bold()
//                        Text(group.description)
//                        Text("Created \(group.createdDate)")
//                        Text("Privacy: \(group.isPublic ? "Public" : "Private")")
//                        Text("Location: \(group.location)")
//                    }
//                    
//                    // Members and Admins Section
//                    VStack(alignment: .leading, spacing: 10) {
//                        Text("Members")
//                            .font(.title2)
//                            .bold()
//                        ScrollView(.horizontal, showsIndicators: false) {
//                            HStack {
//                                ForEach(group.members.prefix(5).indices, id: \.self) { index in
//                                           if let avatarURL = URL(string: group.members[index].avatarURL) {
//                                               AsyncImage(url: avatarURL) { image in
//                                                   AvatarView(image: image, size: 50)
//                                               } placeholder: {
//                                                   Color.gray
//                                                       .frame(width: 50, height: 50)
//                                                       .clipShape(Circle())
//                                               }
//                                           } else {
//                                               Color.gray
//                                                   .frame(width: 50, height: 50)
//                                                   .clipShape(Circle())
//                                           }
//                                       }
//                                   }
//                                if group.members.count > 5 {
//                                    Text("+\(group.members.count - 5)")
//                                        .font(.caption)
//                                        .padding(5)
//                                        .background(Color.gray.opacity(0.2))
//                                        .clipShape(Circle())
//                                }
//                            }
//                        }
//                        .onTapGesture {
//                            // Navigate to members list
//                        }
//                        
//                        Text("Admins")
//                            .font(.title2)
//                            .bold()
//                        ScrollView(.horizontal, showsIndicators: false) {
//                            HStack {
//                                ForEach(group.members.prefix(5).indices, id: \.self) { index in
//                                   if let avatarURL = URL(string: group.members[index].avatarURL) {
//                                       AsyncImage(url: avatarURL) { image in
//                                           AvatarView(image: image, size: 50)
//                                       } placeholder: {
//                                           Color.gray
//                                               .frame(width: 50, height: 50)
//                                               .clipShape(Circle())
//                                       }
//                                   } else {
//                                       Color.gray
//                                           .frame(width: 50, height: 50)
//                                           .clipShape(Circle())
//                                   }
//                            }
//                        }
//                        .onTapGesture {
//                            // Navigate to admins list
//                        }
//                    }
//                    
//                    // Activity Feed Section
//                    VStack(alignment: .leading, spacing: 10) {
//                        Text("Activity Feed")
//                            .font(.title2)
//                            .bold()
//                        ForEach(group.activities.prefix(3)) { activity in
//                            ActivityFeedItemView(activity: activity)
//                        }
//                    }
//                    .onTapGesture {
//                        // Navigate to activity feed
//                    }
//                    
//                    // Group Challenge Section
//                    VStack(alignment: .leading, spacing: 10) {
//                        Text("Group Challenge")
//                            .font(.title2)
//                            .bold()
//                        Text(group.currentChallenge.title)
//                    }
//                    .onTapGesture {
//                        // Navigate to group challenge
//                    }
//                    
//                    // Group Leaderboards Section
//                    VStack(alignment: .leading, spacing: 10) {
//                        Text("Leaderboards")
//                            .font(.title2)
//                            .bold()
//                        ForEach(group.leaderboard.prefix(5)) { member in
//                            HStack {
//                                Text("\(member.rank).")
//                                AvatarView(image: member.avatar, size: 30)
//                                Text(member.name)
//                                Spacer()
//                                Text("\(member.score) points")
//                            }
//                        }
//                    }
//                    .onTapGesture {
//                        // Navigate to leaderboards
//                    }
//                    
//                    // Join Group Button
//                    Button(action: {
//                        // Join group action
//                    }) {
//                        Text("Join Group")
//                            .frame(maxWidth: .infinity)
//                            .padding()
//                            .background(Color.blue)
//                            .foregroundColor(.white)
//                            .cornerRadius(10)
//                    }
//                }
//                .padding()
//            }
//            .navigationBarHidden(true)
//        }
//    }
//}
//
//struct AvatarView: View {
//    let image: Image
//    let size: CGFloat
//
//    var body: some View {
//        image
//            .resizable()
//            .frame(width: size, height: size)
//            .clipShape(Circle())
//    }
//}
//
//struct ActivityFeedItemView: View {
//    let activity: Activity
//    
//    var body: some View {
//        VStack(alignment: .leading, spacing: 5) {
//            HStack {
//                AvatarView(image: activity.userAvatar, size: 30)
//                Text(activity.userName)
//                Spacer()
//                Text(activity.timestamp)
//            }
//            Text(activity.content)
//        }
//    }
//}
//
//// Placeholder views for navigation
//struct PreviousScreenView: View {
//    var body: some View {
//        Text("Previous Screen")
//    }
//}
//
//#Preview {
//    GroupHomeView(group: mockGroups.last!)
//}
