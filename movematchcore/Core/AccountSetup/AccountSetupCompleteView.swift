//
//  AccountSetupCompleteView.swift
//  FitooZone
//
//  Created by Pankaja Wijesena on 2023-05-22.
//

import SwiftUI

struct CardGradientView: View {
    var body: some View {
        LinearGradient(
            gradient: ThemeManager.shared.getGradient(\.cardGradient),
            startPoint: .leading,
            endPoint: .trailing
        )
    }
}

struct AccountSetupCompleteView: View {
    var body: some View {
        ZStack(alignment: .center) {
            CardGradientView()
                .ignoresSafeArea()

            VStack(alignment: .center, spacing: 0) {
                VStack(alignment: .center, spacing: 0) {
                    Text("We create your training plan")

                    ZStack(alignment: .center) {
                        CircularProgressViewMain(
                            progress: 0.75,
                            lineWidth: 28,
                            rotationDegrees: -135
                        )

                        Text("75%")
                    }
                    .frame(width: 264)
                    .frame(height: 380)

                    Text("We create a workout according \nto demographic profile, activity \nlevel and interests")
                        .multilineTextAlignment(.center)
                }

                Spacer(minLength: 0)

                Button("Start Training", action: {
                    AuthManager.setAuthenticated(true)
                })
            }
            .padding(.top, 40)
            .padding(.horizontal, 16)
        }
        .navigationBarHidden(true)
    }
}

struct AccountSetupCompletedView_Previews: PreviewProvider {
    static var previews: some View {
        AccountSetupCompleteView()
            .environmentObject(ThemeManager.shared)
    }
}

struct CircularProgressViewMain: View {
    let progress: Double
    let lineWidth: CGFloat
    let rotationDegrees: Double

    var body: some View {
        ZStack {
            Circle()
                .stroke(
                    ThemeManager.shared.getColor(\.backgroundPrimary),
                    lineWidth: lineWidth
                )

            Circle()
                .trim(from: 0, to: progress)
                .stroke(
                    ThemeManager.shared.getColor(\.purple2),
                    style: StrokeStyle(
                        lineWidth: lineWidth,
                        lineCap: .round
                    )
                )
                .rotationEffect(.degrees(rotationDegrees))
        }
    }
}
