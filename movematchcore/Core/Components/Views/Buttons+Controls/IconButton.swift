//
//  IconButton.swift
//  SpotMatch
//
//  Created by Jake Sax on 7/22/24.
//

import SwiftUI

struct IconButton: View {
    
    // MARK: Properties
    var icon: Brand.Icon
    var bkgdColor: Color
    var strokeColor: Color
    var iconColor: Color
    var xOffset: CGFloat
    var yOffset: CGFloat
    var action: (() -> Void)?
    
    var body: some View {
        Button(action: {
            if let action {
                action()
            }
        }) {
            RoundedRectangle(cornerRadius: 16)
                .fill(bkgdColor)
                .stroke(strokeColor, lineWidth: 1, antialiased: true)
                .frame(width: 56, height: 56)
                .overlay {
                    Icon(icon, size: 24)
                        .foregroundStyle(iconColor)
                        .offset(x: xOffset, y: yOffset)
                }
        }.disabled(action == nil)
    }
    
    // MARK: Initialization
    init(
        _ icon: Brand.Icon,
        bkgdColor: Color = .brand(.white),
        strokeColor: Color = .clear,
        iconColor: Color = .brand(.darkGray),
        xOffset: CGFloat = 0,
        yOffset: CGFloat = 0,
        action: (() -> Void)?
    ) {
        self.icon = icon
        self.bkgdColor = bkgdColor
        self.strokeColor = strokeColor
        self.iconColor = iconColor
        self.xOffset = xOffset
        self.yOffset = yOffset
        self.action = action
    }
}

extension IconButton {
    
    init(configuration: Configuration) {
        self.init(
            configuration.icon,
            bkgdColor: configuration.bkgdColor,
            strokeColor: configuration.strokeColor,
            iconColor: configuration.iconColor,
            xOffset: configuration.xOffset,
            yOffset: configuration.yOffset,
            action: configuration.action
        )
    }
    
    struct Configuration: Identifiable {
        let id: UUID = UUID()
        var icon: Brand.Icon
        var bkgdColor: Color = .brand(.white)
        var strokeColor: Color = .clear
        var iconColor: Color = .brand(.darkGray)
        var xOffset: CGFloat = 0
        var yOffset: CGFloat = 0
        var action: (() -> Void)?
    }
}

#Preview {
    Color.gray.ignoresSafeArea()
        .overlay {
            VStack {
                IconButton(.chevronLeft, action: { print("yeah") })
                IconButton(.chevronLeft, action: nil)
            }
        }
}
