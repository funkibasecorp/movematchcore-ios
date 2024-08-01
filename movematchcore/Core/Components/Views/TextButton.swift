//
//  TextButton.swift
//  SpotMatch
//
//  Created by Jake Sax on 7/22/24.
//

import SwiftUI

struct TextButton: View {
    
    var text: String
    var action: () -> Void
    
    @Environment(\.isEnabled) private var isEnabled
    
    var body: some View {
        Button(action: action) {
            Text(text)
                .font(.headline.bold())
                .foregroundColor(brand: .white)
                .padding(.vertical, 12)
                .frame(maxWidth: .infinity, minHeight: 48)
                .background {
                    RoundedRectangle(cornerRadius: 100)
                        .foregroundColor(brand: .primaryBlue)
                }
        }
        .opacity(isEnabled ? 1 : 0.5)
    }
    
    init(_ text: String, action: @escaping () -> Void) {
        self.text = text
        self.action = action
    }
}

//#Preview {
//    TextButton("Join Group") {
//        print("join group was pressed")
//    }
//    TextButton("Join Group") {
//        print("join group was pressed")
//    }.disabled(true)
//}
