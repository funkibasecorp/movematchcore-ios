//
//  SegmentedControlModifier.swift
//  spotmatch
//
//  Created by Chris Jones on 5/17/24.
//

import SwiftUI

struct SegmentedControlModifier: ViewModifier {
    @Binding var selectedTab: Int
    var currentTab: Int
    var selectedColor: Color = .white
    var unselectedColor: Color = .purple
    var selectedTextColor: Color = .black
    var unselectedTextColor: Color = .white
    
    func body(content: Content) -> some View {
        content
            .frame(maxWidth: .infinity)
            .fontWeight(.bold)
            .padding()
            .background(selectedTab == currentTab ? selectedColor : unselectedColor)
            .foregroundColor(selectedTab == currentTab ? selectedTextColor : unselectedTextColor)
            .cornerRadius(30)
            .padding(5)
    }
}

