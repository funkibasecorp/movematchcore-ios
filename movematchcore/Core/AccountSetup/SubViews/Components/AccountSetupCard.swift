//
//  AccountSetupCard.swift
//  FitooZone
//
//  Created by Pankaja Wijesena on 2023-05-22.
//

import SwiftUI

struct AccountSetupCard: View {
    let title: String
    let emoji: String
    var emojiBgGradient: Gradient = ThemeManager.shared.getGradient(\.cardGradient)
    var isCheck: Bool = false

    var body: some View {
        HStack(alignment: .center, spacing: 16) {
            ZStack(alignment: .center) {
                LinearGradient(
                    gradient: emojiBgGradient,
                    startPoint: .leading,
                    endPoint: .trailing
                )

                Image(emoji)
                    .renderingMode(.original)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 24)
            }
            .frame(width: 56, height: 56)
            .cornerRadius(8)

            Text(title)

            Spacer(minLength: 0)

            if isCheck {
                Circle()
                    .fill(ThemeManager.shared.getColor(\.backgroundSecondary))
                    .frame(width: 20)
                    .overlay(
                        Image(systemName: "checkmark.circle.fill")

                    )
            }
        }
        .padding(.all, 16)
        .cornerRadius(8)
    }
}

struct AccountSetupCard_Previews: PreviewProvider {
    static var previews: some View {
        VStack(alignment: .center, spacing: 16) {
            AccountSetupCard(
                title: "Woman",
                emoji: "emoji_face_woman"
            )

            AccountSetupCard(
                title: "Woman",
                emoji: "emoji_face_woman"
            )

            AccountSetupCard(
                title: "Woman",
                emoji: "emoji_face_woman",
                isCheck: true
            )
        }
        .padding(.horizontal, 16)
        .environmentObject(ThemeManager.shared)
    }
}
