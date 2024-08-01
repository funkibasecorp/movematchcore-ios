//
//  NotificationsFeedView.swift
//  spotmatch
//
//  Created by Chris Jones on 5/13/24.
//

import SwiftUI

struct Notifications: Identifiable {
    let id: UUID = UUID()
    let type: NotificationType
    let message: String
    let timestamp: String
    let imageName: String
    let buttonLabel: String?
}

enum NotificationType {
    case eventReminder
    case profileView
    case followRequest
    case groupNotification
    case userFollow
}

struct NotificationsFeedView: View {
    let notifications: [Notifications] = [
        Notifications(type: .eventReminder, message: "Your Workout with Susan will start today. Be well prepared to participate 💪", timestamp: "02:01 PM", imageName: "bell", buttonLabel: nil),
        Notifications(type: .profileView, message: "John viewed your profile!", timestamp: "10:32 AM", imageName: "eye", buttonLabel: nil),
        Notifications(type: .userFollow, message: "Herbert started following you!", timestamp: "10:32 AM", imageName: "person.fill", buttonLabel: nil),
        Notifications(type: .followRequest, message: "Diana wants to be your friend!", timestamp: "10:32 AM", imageName: "person.badge.plus.fill", buttonLabel: "Accept"),
        Notifications(type: .eventReminder, message: "Your Event with Alex will start today. Be well prepared to participate 💪", timestamp: "02:01 PM", imageName: "bell", buttonLabel: nil),
        Notifications(type: .userFollow, message: "Chris started following you!", timestamp: "10:32 AM", imageName: "person.fill", buttonLabel: nil)
    ]
    
    var body: some View {
        NavigationView {
            ZStack {
                Color.white.edgesIgnoringSafeArea(.all) // Set the background color to white
                
                List(notifications) { notification in
                    NavigationLink(destination: destinationView(for: notification)) {
                        HStack {
                            Image(systemName: notification.imageName)
                                .resizable()
                                .frame(width: 50, height: 50)
                                .clipShape(Circle())
                                .padding(.trailing, 10)
                            VStack(alignment: .leading) {
                                Text(notification.message)
                                    .font(.system(size: 16))
                                HStack {
                                    Text(notification.timestamp)
                                        .font(.system(size: 12))
                                        .foregroundColor(.gray)
                                    if let buttonLabel = notification.buttonLabel {
                                        Spacer()
                                        Button(action: {
                                            // Handle the button action
                                        }) {
                                            Text(buttonLabel)
                                                .font(.system(size: 12))
                                                .foregroundColor(.green)
                                                .padding(5)
                                                .background(Color(.systemGray5))
                                                .cornerRadius(8)
                                        }
                                    }
                                }
                            }
                        }
                        .padding(.vertical, 5)
                    }
                }
                .listStyle(PlainListStyle())
                .navigationTitle("Notifications")
                .navigationBarHidden(true)
            }
        }
    }
    
    @ViewBuilder
    private func destinationView(for notification: Notifications) -> some View {
        switch notification.type {
        case .eventReminder:
            NotificationEventDetailView()
        case .profileView:
            ProfileDetailView()
        case .followRequest:
            FollowRequestView()
        case .groupNotification:
            GroupNotificationView()
        case .userFollow:
            FollowDetailView()
        }
    }
}

struct NotificationEventDetailView: View {
    var body: some View {
        Text("Event Details")
    }
}

struct ProfileDetailView: View {
    var body: some View {
        Text("Profile View Details")
    }
}

struct FollowRequestView: View {
    var body: some View {
        Text("Follow Request Details")
    }
}

struct GroupNotificationView: View {
    var body: some View {
        Text("Group Notification Details")
    }
}

struct FollowDetailView: View {
    var body: some View {
        Text("Follow Details")
    }
}

#Preview {
    NotificationsFeedView()
}
