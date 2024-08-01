//
//  ViewModifiers.swift
//  SpotMatch
//
//  Created by Jake Sax on 7/22/24.
//

import SwiftUI

extension View {
    func showViewFrame(color: Color = .red) -> some View {
        self.overlay {
            color
                .opacity(0.2)
                .allowsHitTesting(false)
        }
    }
    
    func mockTask(
        delay: Duration = .seconds(0.2),
        animation: Animation? = .default,
        action: @escaping () -> Void
    ) -> some View {
        self
            .task {
                do {
                    try await Task.sleep(for: delay)
                    await MainActor.run {
                        withAnimation(animation) {
                            action()
                        }
                    }
                } catch {
                    print(error.localizedDescription)
                }
            }
    }
}
