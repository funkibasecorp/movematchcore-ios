//
//  Icon.swift
//  SpotMatch
//
//  Created by Jake Sax on 7/22/24.
//

import SwiftUI

extension Brand {
    /// An enum wrapper around SF Symbol `String`s and custom SF Symbol
    /// `String`s. This means modifiers like `.foregroundColor()` work,
    /// the icon is inverted automatically for dark/light mode, and SF Symbol
    /// animations are supported.
    enum Icon: String, Equatable {
        case bell
        case bubble
        case bubbleFill = "bubble.fill"
        case captionsBubble = "captions.bubble"
        case checkmark
        case checkmarkSealFill = "checkmark.seal.fill"
        case chevronLeft = "chevron.left"
        case chevronRight = "chevron.right"
        case ellipsis
        case exclamationTriangleFill = "exclamationmark.triangle.fill"
        case flag
        case heart
        case heartFill = "heart.fill"
        case imagePlus = "photo.badge.plus"
        case info
        case infoCircleFill = "info.circle.fill"
        case leaveGroup = "rectangle.portrait.and.arrow.forward.fill"
        case link
        case mappin
        case mapPinCircleFill = "mappin.circle.fill"
        case medalFill = "medal.fill"
        case mountains = "mountain.2"
        case personBadgeMinus = "person.badge.minus"
        case personCropBadgePlus = "person.crop.rectangle.badge.plus"
        case personFill = "person.fill"
        case personTextFill = "person.text.rectangle.fill"
        case plus
        case search = "magnifyingglass"
        case settings = "gear"
        case share = "square.and.arrow.up"
        case textBubbleFill = "text.bubble.fill"
        case trash
        case trophy
        case xmark = "xmark"
    }
}


extension Image {
    /// Creates an `Image` from a enumerated SF Symbol.
    /// - Parameter sf: The `Brand.Icon` that represents the desired
    /// SF Symbol.
    init(sf: Brand.Icon) {
        self.init(systemName: sf.rawValue)
    }
}

/// A convenience wrapper for displaying SF Symbols and custom
/// SF Symbols as images. Add more cases to `Brand.IconSF`
/// to enable easy usage of more SF Symbols.
struct Icon: View {
    
    var icon: Brand.Icon
    var size: CGFloat
    var scale: Image.Scale
    
    var body: some View {
        Image(sf: icon)
            .imageScale(scale)
            .font(.system(size: size))
    }
    
    /// A convenience wrapper for displaying SF Symbols and custom
    /// SF Symbols as images. Add more cases to `Brand.Icon`
    /// to enable easy usage of more SF Symbols.
    /// - Parameters:
    ///   - icon: The icon (`Brand.Icon`) to display.
    ///   - size: The size of the icon.
    ///   - scale: Scales the image within the view according to one of the
    ///   relative sizes available including small, medium, and large images sizes.
    ///   Defaults to `small`
    init(
        _ icon: Brand.Icon,
        size: CGFloat,
        scale: Image.Scale = .small
    ) {
        self.icon = icon
        self.size = size
        self.scale = scale
    }
}


#Preview {
    Icon(.xmark, size: 32)
}
