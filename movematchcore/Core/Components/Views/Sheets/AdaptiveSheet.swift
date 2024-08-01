//
//  AdaptiveSheet.swift
//  SpotMatch
//
//  Created by Jake Sax on 7/22/24.
//

import SwiftUI

fileprivate struct AdaptiveSheetContent<Content: View>: View {
    
    var cornerRadius: CGFloat
    var bkgd: AnyShapeStyle
    var shouldShowDragIndicator: Bool
    var enableBackgroundInteraction: Bool
    var maxHeight: CGFloat?
    var sheetContent: () -> Content
    // Assuming a small amount of height is true in virtually all cases and improves presentation animation
    @State private var viewSize: CGSize = .init(width: UIScreen.deviceWidth, height: 300)
    private var presentationDetent: PresentationDetent {
        if let maxHeight {
            return .height(min(maxHeight,viewSize.height))
        } else {
            return .height(viewSize.height)
        }
    }
    private var backgroundInteraction: PresentationBackgroundInteraction {
        enableBackgroundInteraction ? .enabled(upThrough: presentationDetent) : .disabled
    }
    
    var body: some View {
        ViewSizeReader(size: $viewSize) {
            sheetContent()
        }
        .presentationBackground {
            Rectangle()
                .foregroundStyle(bkgd)
        }
        .presentationBackgroundInteraction(backgroundInteraction)
        .presentationDetents([presentationDetent])
        .presentationCornerRadius(cornerRadius)
        .presentationDragIndicator(shouldShowDragIndicator ? .automatic : .hidden)
    }
}

extension View {
    
    /// A system Sheet that automatically sizes itself to the size of the content.
    /// Uses a single detent that adapts to the content size with the option of
    /// constraining it to a max height. Should be noted that enabling
    /// background interaction will remove the dimming overlay.
    func adaptiveSheet<Content: View>(
        isPresented: Binding<Bool>,
        cornerRadius: CGFloat = 32,
        bkgd: AnyShapeStyle = AnyShapeStyle(Color.white),
        shouldShowDragIndicator: Bool = true,
        enableBackgroundInteraction: Bool = false,
        maxHeight: CGFloat? = nil,
        onDismiss: (() -> Void)? = nil,
        @ViewBuilder sheetContent: @escaping () -> Content
    ) -> some View {
        self.sheet(isPresented: isPresented, onDismiss: onDismiss) {
            AdaptiveSheetContent(
                cornerRadius: cornerRadius,
                bkgd: bkgd,
                shouldShowDragIndicator: shouldShowDragIndicator,
                enableBackgroundInteraction: enableBackgroundInteraction,
                maxHeight: maxHeight,
                sheetContent: sheetContent
            )
        }
    }
}

