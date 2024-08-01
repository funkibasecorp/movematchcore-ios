//
//  SBPageNavHeaderView.swift
//  spotmatch
//
//  Created by Chris Jones on 5/19/24.
//

import SwiftUI

struct SBPageNavHeaderView<Destination: View>: View {
    var title: String
    var destination: Destination

    var body: some View {
        HStack {
            Text(title)
                .font(.largeTitle)
                .bold()
            Spacer()
            HStack(spacing: 16) {
                NavigationLink(destination: destination) {
                    Image(systemName: "plus")
                        .resizable()
                        .frame(width: 20, height: 20)
                }
            }
        }
        .padding(.horizontal, 20)
        .padding(.top, 10)
    }
}

#Preview {
    SBPageNavHeaderView(title: "Test", destination: Text("Here"))
}
