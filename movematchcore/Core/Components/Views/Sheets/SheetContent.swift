//
//  SheetContent.swift
//  SpotMatch
//
//  Created by Jake Sax on 7/23/24.
//

import SwiftUI

struct SheetContent<Content:View>: View {
    
    var title: String
    @Binding var isPresented: Bool
    @ViewBuilder var content: () -> Content
    
    var body: some View {
        VStack(spacing: 24) {
            HeaderView(
                title: title,
                icon: .xmark,
                iconColor: .brand(.gray),
                iconAction: {
                    Haptics.triggerGentleInteractionHaptic()
                    isPresented = false
                }
            )
            .padding(.top, 20)
            
            content()
        }.padding(.bottom, 16)
    }
}

#Preview {
    Color.gray.ignoresSafeArea()
        .adaptiveSheet(isPresented: .constant(true)) {
            SheetContent(title: "hello", isPresented: .constant(true)) {
                Text("some sheet content")
            }
        }
}
