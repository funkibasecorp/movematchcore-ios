//
//  FavoritesActionModalView.swift
//  spotmatch
//
//  Created by Chris Jones on 5/17/24.
//

import SwiftUI

struct FavoritesActionModalView: View {
    let navigateToWorkout: () -> Void
    let navigateToExercise: () -> Void
    let navigateToCollection: () -> Void
    let dismissModal: () -> Void
    
    var body: some View {
        VStack {
            HStack {
                Spacer()
                Button(action: {
                    dismissModal()
                }) {
                    Image(systemName: "xmark")
                        .padding()
                }
            }
            .padding(.top)
            
            Text("Select Action")
                .font(.title2)
                .bold()
                .padding(.bottom, 20)
            
            Spacer()
            
            Button(action: {
                dismissModal()
                navigateToWorkout()
            }) {
                FavoriteItemView(icon: "figure.walk", title: "Create New Workout", subtitle: "")
            }
            .padding(.bottom)
            
            Button(action: {
                dismissModal()
                navigateToExercise()
            }) {
                FavoriteItemView(icon: "figure.run", title: "Create New Exercise", subtitle: "")
            }
            .padding(.bottom)
            
            Button(action: {
                dismissModal()
                navigateToCollection()
            }) {
                FavoriteItemView(icon: "tray", title: "Create New Collection", subtitle: "")
            }
            .padding(.bottom)
            
            Spacer()
            
            Button(action: {
                dismissModal()
            }) {
                Text("Close")
                    .padding()
                    .background(Color.purple)
                    .foregroundColor(.white)
                    .cornerRadius(10)
            }
            .padding(.bottom)
        }
        .padding()
        .background(Color.white.edgesIgnoringSafeArea(.all))
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .presentationDetents([.medium])
    }
}

#Preview {
    FavoritesActionModalView(
        navigateToWorkout: { print("Navigate to Workout") },
        navigateToExercise: { print("Navigate to Exercise") },
        navigateToCollection: { print("Navigate to Collection") },
        dismissModal: { print("Dismiss Modal") }
    )
}
