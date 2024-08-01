//
//  NotificationView.swift
//  FitooZone
//
//  Created by Pankaja Wijesena on 2023-05-21.
//

import SwiftUI

struct NavBar<TrailingView: View>: View {
    @Environment(\.dismiss) private var dismissView
    let title: String
    @ViewBuilder let trailing: () -> TrailingView

    var body: some View {
        HStack(alignment: .center, spacing: 0) {
            Button(action: {
                dismissView()
            }, label: {
                Text(":)")
            })

            Spacer()

            trailing()
        }
        .overlay(
            Text(title)
                .frame(minHeight: 40)
        )
    }
}

struct NotificationView: View {
    @StateObject var vm = NotificationVM()

    var body: some View {
        VStack(alignment: .center, spacing: 0) {
            NavBar(title: "Notification") {}
                .padding(.bottom, 8)

            ScrollView(.vertical, showsIndicators: false) {
                VStack(alignment: .center, spacing: 24) {
                    ForEach(vm.notificationsByDate, id: \.id) { section in
                        NotificationSection(
                            date: section.date,
                            notifications: section.notifications
                        )
                    }
                }
                .padding(.top, 20)
            }
        }
    }
}

struct NotificationView_Previews: PreviewProvider {
    static var previews: some View {
        NotificationView()
    }
}

struct NotificationSection: View {
    let date: Date
    let notifications: [Notification]

    var body: some View {
        VStack(alignment: .center, spacing: 8) {
            Text("Jan 8th, 2023")
                .frame(maxWidth: .infinity, alignment: .leading)

            VStack(alignment: .center, spacing: 16) {
                ForEach(notifications, id: \.id) { notification in
                    NotificationCardView(notification: notification)
                }
            }
        }
    }
}

struct NotificationCardView: View {
    let notification: Notification

    var body: some View {
        HStack(alignment: .center, spacing: 16) {
            Circle()
                .scaledToFill()
                .frame(width: 64, height: 64)
                .cornerRadius(8)

            VStack(alignment: .leading, spacing: 8) {
                Text(notification.title)
                

                Text(notification.time)
                    .foregroundColor(.white)
                    .frame(width: 56, height: 24)
                    .clipShape(Capsule())
            }

            Spacer(minLength: 0)
        }
        .padding([.vertical, .leading], 8)
        .padding(.trailing, 20)
        .cornerRadius(8)
    }
}
