//
//  CheckmarkToggle.swift
//  SpotMatch
//
//  Created by Jake Sax on 7/25/24.
//

import SwiftUI

struct CheckmarkToggle: View {
    
    @Binding var isOn: Bool
    
    var body: some View {
        Button(action: {
            Haptics.triggerGentleInteractionHaptic()
            isOn.toggle()
        }) {
            RoundedRectangle(cornerRadius: 2)
                .frame(width: 16, height: 16)
                .foregroundColor(brand: isOn ? .primaryBlue : .gray)
                .overlay {
                    if isOn {
                        Icon(.checkmark, size: 16)
                            .foregroundColor(brand: .white)
                    }
                }
        }
    }
}

//#Preview {
//    CheckmarkToggle()
//}
