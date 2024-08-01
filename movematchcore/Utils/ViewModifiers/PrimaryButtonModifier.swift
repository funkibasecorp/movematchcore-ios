//
//  PrimaryButtonModifier.swift
//  spotmatch
//
//  Created by Chris Jones on 5/12/24.
//
import SwiftUI

struct PrimaryButtonModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.subheadline)
            .fontWeight(.semibold)
            .foregroundColor(.white)
            .background(.purple)
            .cornerRadius(30)
    }
}
