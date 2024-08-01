//
//  SwiftUIView.swift
//  spotmatch
//
//  Created by Chris Jones on 6/16/24.
//

import SwiftUI

struct DetailImageView: View {
    let title: String
    let image: Image
    let description: String
    
    var body: some View {
        NavigationLink(destination: OrganizerProfileView(name: description)) {
            VStack(alignment: .leading, spacing: 8) {
                Text(title)
                    .font(.headline)
                    .foregroundColor(.gray)
                
                HStack(spacing: 8) {
                    image
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: 40, height: 40)
                        .clipShape(Circle())
                    
                    Text(description)
                        .font(.body)
                        .foregroundColor(.black)
                        .multilineTextAlignment(.leading)
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
}

struct OrganizerProfileView: View {
    let name: String
    
    var body: some View {
        VStack {
            Text("Organizer Profile")
                .font(.largeTitle)
                .padding()
            
            Text("Name: \(name)")
                .font(.title)
                .padding()
            
            Spacer()
        }
        .navigationTitle("Profile")
    }
}

#Preview {
    NavigationView {
        DetailImageView(title: "Creator", image: Image(systemName: "person.fill"), description: "Irvin Jonason")
    }
}
