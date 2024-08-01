//
//  DetailsView.swift
//  spotmatch
//
//  Created by Chris Jones on 6/14/24.
//

import SwiftUI

import SwiftUI

struct DetailsView: View {
    let title: String
    let description: String
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(title)
                .font(.headline)
                .foregroundColor(.gray)
            
            Text(description)
                .font(.body)
                .foregroundColor(.black)
                .multilineTextAlignment(.leading)
        }
        .padding()
        .background(
            RoundedRectangle(cornerRadius: 20)
                .stroke(Color.gray.opacity(0.3), lineWidth: 1)
                .background(RoundedRectangle(cornerRadius: 20).fill(Color.white))
        )
    }
}

#Preview {
    DetailsView(title: "Description", description: "Lorem ipsum dolor sit amet consectetur. Lacus posuere odio enim ultrices placerat amet a nisl. Ipsum tristique purus ut egestas lectus semper ac. Consectetur in aliquet cursus urna hac lacus id hac.")
}
