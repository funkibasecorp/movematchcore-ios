//
//  LetterIndexSidebar.swift
//  SpotMatch
//
//  Created by Jake Sax on 7/23/24.
//

import SwiftUI

/// A sidebar that emits a selected letter for jumping to positions in an
/// alphabetically sorted list.
struct LetterIndexSidebar: View {
    
    let letters = Array("ABCDEFGHIJKLMNOPQRSTUVWXYZ")
    var animation: Animation = .snappy(duration: 0.3)
    @Binding var selectedLetter: String?
    
    var body: some View {
        GeometryReader { geometry in
            VStack(spacing: 0) {
                ForEach(letters, id: \.self) { letter in
                    Text(String(letter))
                        .font(.system(size: 12))
                        .frame(
                            width: 24,
                            height: geometry.size.height / CGFloat(letters.count)
                        )
                        .background(alignment: .trailing) {
                            RoundedRectangle(cornerRadius: 100)
                                .frame(width: 20)
                                .offset(x: -2)
                                .foregroundStyle(selectedLetter == String(letter) ? Color.brand(.primaryBlue).opacity(0.5) : Color.white.opacity(0.001))
                            
                        }
                        .onTapGesture {
                            withAnimation(animation) {
                                selectedLetter = String(letter)
                            }
                        }
                }
            }
            .frame(width: 24, alignment: .trailing)
            .gesture(
                DragGesture(minimumDistance: 0)
                    .onChanged { value in
                        let index = Int((value.location.y / geometry.size.height) * CGFloat(letters.count))
                        if index >= 0 && index < letters.count {
                            selectedLetter = String(letters[index])
                        }
                    }
            )
        }
        .frame(width: 24, alignment: .trailing)
    }
}

extension LetterIndexSidebar {
    struct _Preview: View {
        
        @State private var items = ["Apple", "Banana", "Cherry", "Date", "Elderberry", "Fig", "Grape", "Honeydew", "Imbe", "Jackfruit", "Kiwi", "Lemon", "Mango", "Nectarine", "Orange", "Papaya", "Quince", "Raspberry", "Strawberry", "Tangerine", "Ugli Fruit", "Vanilla Bean", "Watermelon", "Xigua", "Yuzu", "Zucchini"]
           @State private var selectedLetter: String?
           
           var sortedItems: [String: [String]] {
               Dictionary(grouping: items) { String($0.prefix(1)).uppercased() }
           }
           
           var sortedKeys: [String] {
               sortedItems.keys.sorted()
           }
        
        var body: some View {
            ScrollViewReader { proxy in
                ScrollView {
                    VStack {
                                                HStack {
                        List {
                            ForEach(sortedKeys, id: \.self) { key in
                                Group {
                                    ForEach(sortedItems[key]!, id: \.self) { item in
                                        Text(item)
                                    }
                                }.id(key)
                            }
                        }
                        .listStyle(PlainListStyle())
//                        .overlay(alignment: .trailing) {
                            LetterIndexSidebar(selectedLetter: $selectedLetter)
                                .frame(height: 400)
                                .onChange(of: selectedLetter) {
                                    if let selectedLetter {
                                        withAnimation {
                                            proxy.scrollTo(selectedLetter, anchor: .top)
                                        }
                                    }
                                }
                        }
                    }
                    .frame(height: UIScreen.deviceHeight)
                }
            }
        }
    }
}


#Preview {
    LetterIndexSidebar._Preview()
}
