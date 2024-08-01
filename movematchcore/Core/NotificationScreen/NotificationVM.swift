//
//  NotificationVM.swift
//  FitooZone
//
//  Created by Pankaja Wijesena on 2023-05-21.
//

import Foundation


extension String {
    func toDate() -> Date? {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
        let localDate: Date? = formatter.date(from: self)
        return localDate
    }
}


class NotificationVM: ObservableObject {
    let notificationsByDate: [NotificationsByDate] = [
        .init(
            date: "2023-07-05T09:34:31.000000Z".toDate() ?? Date(),
            notifications: [
                .init(
                    image: "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRdrE7RmE4dUxBwBb2qgC1Dm1uT4VXPeS_V1J9NJCwOo8hDDtIaaSQXc-vUki3qKO74qKM&usqp=CAU",
                    title: "Full Body Yoga",
                    time: "08:30"
                )
            ]
        ),
        .init(
            date: "2023-07-04T10:22:46.000000Z".toDate() ?? Date(),
            notifications: [
                .init(
                    image: "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRdrE7RmE4dUxBwBb2qgC1Dm1uT4VXPeS_V1J9NJCwOo8hDDtIaaSQXc-vUki3qKO74qKM&usqp=CAU",
                    title: "Full Body Yoga",
                    time: "08:30"
                ),
                .init(
                    image: "https://hips.hearstapps.com/hmg-prod/images/fitness-woman-doing-abs-crunches-royalty-free-image-579128718-1551795417.jpg?crop=1.00xw:0.796xh;0,0.0102xh&resize=1200:*",
                    title: "Ab Crunches",
                    time: "15:15"
                )
            ]
        )
    ]
}

struct NotificationsByDate {
    let id = UUID().uuidString
    let date: Date
    let notifications: [Notification]
}

struct Notification {
    let id = UUID().uuidString
    let image: String
    let title: String
    let time: String
}
