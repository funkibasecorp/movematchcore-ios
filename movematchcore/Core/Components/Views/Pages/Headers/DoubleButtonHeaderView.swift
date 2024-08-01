//
//  HeaderView.swift
//  spotmatch
//
//  Created by Chris Jones on 5/17/24.
//

import SwiftUI


struct DoubleButtonHeaderView<ModalView: View, FirstButtonContent: View, SecondButtonContent: View>: View {
    @State private var showFilterModal: Bool = false
    var title: String
    var modalView: ModalView
    var firstButtonContent: FirstButtonContent
    var secondButtonContent: SecondButtonContent?

    var body: some View {
        HStack {
            Text(title)
                .font(.largeTitle)
                .bold()
            Spacer()
            HStack(spacing: 16) {
                firstButtonContent
                if let secondButton = secondButtonContent {
                    secondButton
                }
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
    DoubleButtonHeaderView(
        title: "Favorites",
        modalView: Text("Filter Modal View"),
        firstButtonContent: Button(action: { /* action */ }) {
            Image(systemName: "plus")
                .resizable()
                .frame(width: 20, height: 20)
        },
        secondButtonContent: Button(action: { /* action */ }) {
            Image(systemName: "slider.horizontal.3")
                .resizable()
                .frame(width: 20, height: 20)
        }
    )
}
