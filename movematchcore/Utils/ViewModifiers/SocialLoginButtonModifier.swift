//
//  SocialLoginButtonModifier.swift
//  spotmatch
//
//  Created by Chris Jones on 5/12/24.
//

import SwiftUI

struct SocialLoginButtonModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.subheadline)
            .padding()
            .frame(height: 44)
            .frame(maxWidth: .infinity)
            .background(Color.white)
            .cornerRadius(30)
            .shadow(radius: 1)
    }
}
