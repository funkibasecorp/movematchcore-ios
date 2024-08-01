//
//  TextFieldModifier.swift
//  spotmatch
//
//  Created by Chris Jones on 5/12/24.
//

import SwiftUI

struct TextFieldModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .padding(.vertical, 12)
            .padding(.horizontal)
            .background(Color.white)
            .cornerRadius(30)
            .shadow(radius: 1)
    }
}
