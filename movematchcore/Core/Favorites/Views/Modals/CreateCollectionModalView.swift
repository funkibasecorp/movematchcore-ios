//
//  CreateCollectionModalView.swift
//  spotmatch
//
//  Created by Chris Jones on 5/17/24.
//

import SwiftUI

struct CreateCollectionModalView: View {
    @State private var title: String = ""
    @State private var emoji: String = "😊"
    @State private var color: Color = .gray
    @State private var showEmojiPicker: Bool = false
    @Environment(\.presentationMode) var presentationMode
    let onSubmit: (Any) -> Void
    
    var body: some View {
        VStack {
            HStack {
                Text("Create Collection")
                    .font(.title)
                    .bold()
                Spacer()
                Button(action: {
                    presentationMode.wrappedValue.dismiss()
                }) {
                    Image(systemName: "xmark")
                        .padding()
                }
            }
            .padding()
            
            VStack(alignment: .leading) {
                Text("Collection Name")
                    .font(.headline)
                TextField("Name", text: $title)
                    .padding()
                    .background(Color(UIColor.systemGray6))
                    .cornerRadius(10)
                
                HStack {
                    Button(action: {
                        showEmojiPicker.toggle()
                    }) {
                        VStack {
                            Text("Add Emoji")
                            Text(emoji)
                                .font(.largeTitle)
                        }
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color(UIColor.systemGray5))
                        .cornerRadius(10)
                    }
                    
                    VStack {
                        Text("Add Color")
                        ColorPicker("", selection: $color)
                    }
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color(UIColor.systemGray5))
                    .cornerRadius(10)
                    .labelsHidden()
                }
                .padding(.vertical)
                .sheet(isPresented: $showEmojiPicker) {
                    EmojiPickerViewController(selectedEmoji: $emoji)
                }
                
                Button(action: {
                    guard title.count > 3, title.rangeOfCharacter(from: .decimalDigits) == nil else {
                        // Show an alert or handle error
                        return
                    }
                    if title.lowercased().contains("exercise") {
                        let newCollection = ExerciseCollection(
                            title: title,
                            exercises: [],
                            emoji: emoji,
                            color: color
                        )
                        onSubmit(newCollection)
                    } else {
                        let newCollection = WorkoutCollection(
                            title: title,
                            workouts: [],
                            emoji: emoji,
                            color: color
                        )
                        onSubmit(newCollection)
                    }
                    presentationMode.wrappedValue.dismiss()
                }) {
                    Text("Submit")
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.purple)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                }
                .padding(.top)
            }
            .padding()
            
            Spacer()
        }
        .background(Color.white)
        .padding()
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .presentationDetents([.medium])
    }
}

#Preview {
    CreateCollectionModalView(onSubmit: { _ in print("Collection created") })
}
