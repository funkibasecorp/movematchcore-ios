//
//  ImageGridView.swift
//  SpotMatch
//
//  Created by Jake Sax on 7/23/24.
//

import SwiftUI

/// A square grid of up to 9 images with square aspect ratios.
struct ImageGridView: View {
    let images: [Image]
    let maxImages: Int = 9
    
    static let gridItemCount: Int = 3
    static let padding: CGFloat = 8
    private let columns: [GridItem] = Array(
        repeating: GridItem(.flexible(), spacing: Self.padding),
        count: Self.gridItemCount
    )
    
    var body: some View {
        GeometryReader { geo in
            let sideLength = (geo.size.width  - Self.padding * 2) / CGFloat(Self.gridItemCount)
            
            LazyVGrid(columns: columns, spacing: Self.padding) {
                ForEach(0..<min(images.count, maxImages), id: \.self) { index in
                    images[index]
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: sideLength, height: sideLength)
                        .clipShape(RoundedRectangle(cornerRadius: 16))
                }
            }
        }
    }
}


#Preview {
    ImageGridView(
        images: [
            Image(systemName: "rectangle.fill"),
            Image(systemName: "square.fill"),
            Image(systemName: "triangle.fill"),
            Image(systemName: "diamond.fill"),
            Image(systemName: "circle.fill"),
            Image(systemName: "heart.fill"),
            Image(systemName: "pentagon.fill"),
            Image(systemName: "triangle.fill"),
            Image(systemName: "button.roundedtop.horizontal.fill")
        ]
    )
//    .padding(80)
}
