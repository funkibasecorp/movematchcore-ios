//
//  TopToolbar.swift
//  SpotMatch
//
//  Created by Jake Sax on 7/22/24.
//

import SwiftUI

/// A row of buttons to place at the top of a page.
struct TopToolbar: View {
    
    var leadingButtons: [IconButton.Configuration]
    var trailingButtons: [IconButton.Configuration]
    
    var body: some View {
        HStack(spacing: 12) {
            ForEach(leadingButtons) { button in
                IconButton(configuration: button)
            }
            Spacer()
            ForEach(trailingButtons) { button in
                IconButton(configuration: button)
            }
        }.padding(.horizontal, 16)
    }
}

#Preview {
    Color.gray
        .ignoresSafeArea()
        .overlay(alignment: .top) {
            TopToolbar(
                leadingButtons: [
                    .init(icon: .chevronLeft)
                ],
                trailingButtons: [
                    .init(icon: .share, yOffset: -2),
                    .init(icon: .ellipsis)
                ]
            )
        }
}
