//
//  BrandColors.swift
//  SpotMatch
//
//  Created by Jake Sax on 7/22/24.
//

import SwiftUI

extension Brand {
    enum Color {
        case white
        case lightGray
        case gray
        case darkGray
        case black
        case primaryBlue
        case secondaryNeonGreen
        
        /// The name used in Assets to define the color.
        var name: String {
            switch self {
            case .white: "White1"
            case .lightGray: "LightGray1"
            case .gray: "Gray1"
            case .darkGray: "DarkGray1"
            case .black: "Black1"
            case .primaryBlue: "PrimaryBlue"
            case .secondaryNeonGreen: "NeonGreen"
            }
        }
        
    }
}

extension Color {
    static func brand(_ color: Brand.Color) -> Color {
        self.init(color.name, bundle: nil)
    }
}

extension View {
    func foregroundColor(brand color: Brand.Color) -> some View {
        self.foregroundStyle(Color.brand(color))
    }
}
