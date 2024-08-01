//
//  ProfilePhotoView.swift
//  SpotMatch
//
//  Created by Jake Sax on 7/22/24.
//

import SwiftUI

struct ProfilePhotoView: View {
 
    // MARK: Properties
    var url: URL?
    var size: CGFloat
    var cornerRadius: CGFloat
    
    var body: some View {
        AsyncImage(url: url) { image in
            image
                .resizable()
                .aspectRatio(contentMode: .fill)
        } placeholder: {
            Color.gray
        }
        .frame(width: size, height: size)
        .clipShape(RoundedRectangle(cornerRadius: cornerRadius))

    }
    
    // MARK: Initialization
    internal init(url: URL?, size: CGFloat, cornerRadius: CGFloat) {
        self.url = url
        self.size = size
        self.cornerRadius = cornerRadius
    }
    
    internal init(urlString: String?, size: CGFloat, cornerRadius: CGFloat) {
        self.url = URL(string: urlString ?? "")
        self.size = size
        self.cornerRadius = cornerRadius
    }
}

#Preview {
    VStack {
        ProfilePhotoView(url: nil, size: 32, cornerRadius: 32)
        ProfilePhotoView(url: nil, size: 36, cornerRadius: 12)
    }
}
