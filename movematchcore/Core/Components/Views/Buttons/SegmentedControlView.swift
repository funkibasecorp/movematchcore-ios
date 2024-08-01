//
//  SegmentedControlView.swift
//  spotmatch
//
//  Created by Chris Jones on 5/17/24.
//

import SwiftUI

struct SegmentedControlView: View {
    @Binding var selectedTab: Int
    var titles: [String]
    var backgroundColor: Color

    var body: some View {
        HStack {
            ForEach(0..<titles.count, id: \.self) { index in
                Button(action: {
                    selectedTab = index
                }) {
                    Text(titles[index])
                        .modifier(SegmentedControlModifier(
                            selectedTab: $selectedTab,
                            currentTab: index
                        )
                    )
                }
            }
        }
        .background(backgroundColor)
        .cornerRadius(30)
        .padding(.horizontal, 20)
    }
}

#Preview {
    SegmentedControlView(
        selectedTab: .constant(0),
        titles: ["Workouts", "Exercises"],
        backgroundColor: .purple
    )
}
