//
//  FitnessTestHeaderView.swift
//  spotmatch
//
//  Created by Chris Jones on 5/14/24.
//

import SwiftUI

struct FitnessTestHeaderView: View {
    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                Text("Fitness test result expires in 2 days")
                    .font(.system(size: 14))
                    .foregroundColor(.gray)
                NavigationLink(destination: FitnessTestView()){
                    Text("Start Test")
                        .font(.system(size: 14))
                        .padding(.horizontal)
                        .padding(.vertical, 8)
                        .background(Color.green)
                        .foregroundColor(.white)
                        .cornerRadius(20)
                }
                
            }
            Spacer()
            Image(systemName: "info.circle.fill")
                .resizable()
                .frame(width: 30, height: 30)
                .foregroundColor(.yellow)
        }
        .padding()
        .background(Color(.systemGray6))
        .cornerRadius(10)
        .padding(.horizontal)
    }
}

#Preview {
    FitnessTestHeaderView()
}
