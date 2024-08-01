//
//  InfoView.swift
//  spotmatch
//
//  Created by Chris Jones on 6/14/24.
//

import SwiftUI

struct InfoItem {
    let icon: String
    let title: String
    let subtitle: String
}

struct InfoView: View {
    let items: [InfoItem] = [
        InfoItem(icon: "mappin.circle.fill", title: "Remixes", subtitle: "20"),
        InfoItem(icon: "flag.circle.fill", title: "Intensity", subtitle: "Moderate"),
        InfoItem(icon: "flag.circle.fill", title: "Type", subtitle: "Strength"),
        InfoItem(icon: "flag.circle.fill", title: "Rating", subtitle: "4.5 Stars")
    ]
    
    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            ForEach(items, id: \.title) { item in
                HStack {
                    Image(systemName: item.icon)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 40, height: 40)
                        .foregroundColor(Color.purple)
                    
                    VStack(alignment: .leading) {
                        Text(item.title)
                            .font(.headline)
                            .foregroundColor(.black)
                        Text(item.subtitle)
                            .font(.subheadline)
                            .foregroundColor(.gray)
                    }
                    Spacer()
                }
                .padding(.vertical, 8)
                
                if item.title != items.last?.title {
                    Divider()
                }
            }
        }
        .padding()
        .background(
            RoundedRectangle(cornerRadius: 20)
                .stroke(Color.gray.opacity(0.3), lineWidth: 1)
                .background(RoundedRectangle(cornerRadius: 20).fill(Color.white))
        )
        .padding()
    }
}

#Preview {
    InfoView()
}
