//
//  NoButtonHeaderView.swift
//  spotmatch
//
//  Created by Chris Jones on 5/19/24.
//

import SwiftUI

import SwiftUI

struct NoButtonHeaderView: View {
    var title: String

    var body: some View {
        HStack {
            Text(title)
                .font(.largeTitle)
                .bold()
            Spacer()
        }
        .padding(.horizontal, 20)
        .padding(.top, 10)
    }
}

#Preview {
    NoButtonHeaderView(
        title: "Favorites"
    )
}
