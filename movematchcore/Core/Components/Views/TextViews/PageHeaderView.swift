//
//  PageHeaderView.swift
//  SpotMatch
//
//  Created by Jake Sax on 7/22/24.
//

import SwiftUI

struct PageHeaderView<TrailingButton: View>: View {
    
    var title: String
    var icon: Brand.Icon
    @Binding var navigation: NavigationPath
    @Binding var isPresented: Bool
    var trailingButton: (() -> TrailingButton)?
    
    var body: some View {
        HStack(spacing: 16) {
            IconButton(
                icon,
                bkgdColor: .clear,
                strokeColor: .brand(.lightGray)
            ) {
                navigation.goBack()
                isPresented = false
            }
            
            Text(title)
                .font(.title2).bold()
                .frame(maxWidth: .infinity, alignment: trailingButton == nil ? .leading : .center)
                .foregroundColor(brand: .black)
            
            if let trailingButton {
                trailingButton()
            }
        }
        .padding(.horizontal, 20)
    }
    
    // MARK: Initialization
    init(
        title: String,
        icon: Brand.Icon = .chevronLeft,
        navigation: Binding<NavigationPath>,
        trailingButton: @escaping () -> TrailingButton
    ) {
        self.title = title
        self.icon = icon
        self._navigation = navigation
        self._isPresented = .constant(true)
        self.trailingButton = trailingButton
    }
    
    init(
        title: String,
        icon: Brand.Icon = .chevronLeft,
        navigation: Binding<NavigationPath>
    ) where TrailingButton == EmptyView {
        self.title = title
        self.icon = icon
        self._navigation = navigation
        self._isPresented = .constant(true)
        self.trailingButton = nil
    }
    
    init(
        title: String,
        icon: Brand.Icon = .chevronLeft,
        isPresented: Binding<Bool>,
        trailingButton: @escaping () -> TrailingButton
    ) {
        self.title = title
        self.icon = icon
        self._navigation = .constant(.init())
        self._isPresented = isPresented
        self.trailingButton = trailingButton
    }
    
    init(
        title: String,
        icon: Brand.Icon = .chevronLeft,
        isPresented: Binding<Bool>
    ) where TrailingButton == EmptyView {
        self.title = title
        self.icon = icon
        self._navigation = .constant(.init())
        self._isPresented = isPresented
        self.trailingButton = nil
    }
}

#Preview {
    VStack {
//        PageHeaderView(title: "Privacy Settings", navigation: .constant(.init()))
        PageHeaderView(
            title: "Privacy Settings",
            navigation: .constant(.init()),
            trailingButton: { IconButton(.bell, action: {}) }
        )
        Spacer()
    }
}
