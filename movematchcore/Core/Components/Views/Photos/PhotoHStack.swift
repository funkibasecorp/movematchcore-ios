//
//  PhotoHStack.swift
//  SpotMatch
//
//  Created by Jake Sax on 7/22/24.
//

import SwiftUI

struct PhotoHStack<Placeholder: View>: View {
   
    var urls: [String?]
    var size: CGFloat = 40
    var maxThumbnails: Int = 3
    var backgroundColor: Color = .brand(.white)
    
    var exceededMaxThumbnailFillColor: Color = .purple
    var exceededMaxThumbnailStrokeWidth: CGFloat = 1
    var exceededMaxThumbnailFont: Font = .headline
    
    @ViewBuilder var placeholder: Placeholder
    
    private var maxThumbnailAdjusted: Int {
        hasExceededMaxThumbnails ? maxThumbnails - 1 : maxThumbnails
    }
    private var hasExceededMaxThumbnails: Bool {
        urls.count > maxThumbnails
    }
    private var urlsToDisplay: Array<EnumeratedSequence<[String?]>.Element> {
        Array(Array(urls.prefix(maxThumbnailAdjusted)).enumerated()).reversed()
    }
    
    var body: some View {
        ZStack(alignment: .leading) {
            ForEach(urlsToDisplay, id: \.offset) { url in
                AsyncImage(url: URL(string: url.element ?? "")) { image in
                    image
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                } placeholder: {
                    placeholder
                }
                .frame(width: size, height: size)
                .background(backgroundColor)
                .clipShape(Circle())
                .zIndex(Double(url.offset))
                .padding(.leading, size * CGFloat(url.offset) * 0.675)
            }
            if hasExceededMaxThumbnails {
                Circle()
                    .fill(exceededMaxThumbnailFillColor)
                    .stroke(backgroundColor, lineWidth: 1)
                    .frame(width: size, height: size)
                    .clipShape(Circle())
                    .overlay {
                        Text("+\(urls.count - maxThumbnails + 1)")
                            .font(exceededMaxThumbnailFont)
                            .foregroundStyle(.black)
                    }
                    .zIndex(1000)
                    .padding(.leading, size * CGFloat(maxThumbnails - 1) * 0.675)
            }
        }
    }
}

#Preview {
    PhotoHStack(
        urls: ["test", "anothertest", "anotherTest", "this"],
        size: 40,
        maxThumbnails: 3,
        backgroundColor: .brand(.white),
        placeholder: {
            Circle()
                .fill(Color.purple)
                .stroke(Color.brand(.white), lineWidth: 1)
        }
    )
}
