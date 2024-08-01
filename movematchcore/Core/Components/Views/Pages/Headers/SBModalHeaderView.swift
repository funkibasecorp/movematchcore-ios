//
//  SBModalHeaderView.swift
//  spotmatch
//
//  Created by Chris Jones on 5/19/24.
//

import SwiftUI

struct SBModalHeaderView<ModalView: View, FirstButtonContent: View>: View {
    @State private var showFilterModal: Bool = false
    var title: String
    var modalView: ModalView
    var firstButtonContent: FirstButtonContent

    var body: some View {
        HStack {
            Text(title)
                .font(.largeTitle)
                .bold()
            Spacer()
            HStack(spacing: 16) {
                firstButtonContent
            }
        }
        .padding(.horizontal, 20)
        .padding(.top, 10)
        .sheet(isPresented: $showFilterModal) {
            modalView
        }
    }
}

#Preview {
    SBModalHeaderView(
        title: "Favorites",
        modalView: Text("Filter Modal View"),
        firstButtonContent: Button(action: { /* action */ }) {
            Image(systemName: "plus")
                .resizable()
                .frame(width: 20, height: 20)
        }
    )
}
