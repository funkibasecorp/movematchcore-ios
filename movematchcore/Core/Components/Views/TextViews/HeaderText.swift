//
//  HeaderView.swift
//  SpotMatch
//
//  Created by Jake Sax on 7/22/24.
//

import SwiftUI

struct HeaderView: View {
    
    var title: String
    var icon: Brand.Icon = .xmark
    var iconColor: Color = .black
    var iconAction: () -> Void
    
    var body: some View {
        HStack {
            Text(title)
                .font(.title).bold()
                .frame(maxWidth: .infinity, alignment: .leading)
                .foregroundColor(brand: .black)
            
            IconButton(
                icon,
                bkgdColor: .clear,
                strokeColor: .brand(.lightGray),
                iconColor: iconColor,
                action: iconAction
            )
        }
        .padding(.horizontal, 20)
    }
}

#Preview {
    HeaderView(title: "Groups", icon: .xmark, iconAction: {
        print("Pressed")
    })
}
