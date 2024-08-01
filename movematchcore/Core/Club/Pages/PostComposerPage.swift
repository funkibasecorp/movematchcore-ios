//
//  PostComposerPage.swift
//  SpotMatch
//
//  Created by Jake Sax on 7/23/24.
//

import SwiftUI
import PhotosUI

struct PostComposerPage: View {

    // MARK: Data
    var groupID: UUID
    var didSubmitPost: (Post) -> Void
    @State private var text: String = ""
    @State private var photos: [UIImage] = []
    
    // MARK: UI
    @Binding var navigation: NavigationPath
    @FocusState private var isFocused: Bool
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        VStack {
            PageHeaderView(title: "New Post", icon: .xmark, navigation: $navigation)
            
            ScrollView {
                VStack(alignment: .leading, spacing: 20) {
                    TextField(
                        "What do you want to share with your group?",
                        text: $text,
                        axis: .vertical
                    )
                    .lineLimit(8, reservesSpace: true)
                    .focused($isFocused)
                    .font(.callout)
                    .padding(20)
                    .background {
                        RoundedRectangle(cornerRadius: 32)
                            .stroke(Color.brand(.lightGray))
                    }
                    
                    if photos.count < 9 {
                        PhotoPickerView(selectedImages: $photos) {
                            RoundedRectangle(cornerRadius: 24)
                                .foregroundColor(brand: .lightGray)
                                .frame(width: 108, height: 108)
                                .overlay {
                                    Icon(.imagePlus, size: 40)
                                        .foregroundColor(brand: .black)
                                        .offset(x: -1.5, y: 4.5)
                                }
                        }
                    }
                    if photos.count > 0 {
                        ImageGridView(images: photos.map { Image(uiImage: $0)})
                    }
                    
                    Spacer()
                    
                }
                
            }.padding(.horizontal, 20)
            
            TextButton("Post", action: postWasPressed)
                .disabled(text.isEmpty)
                .padding(.horizontal, 20)
        }
        .background {
            Color.white.opacity(0.001)
                .onTapGesture {
                    isFocused = false
                }
        }
        .animation(.smooth, value: photos)
    }
    
    // MARK: Methods
    func postWasPressed() {
        Haptics.triggerInteractionHaptic()
        let post = Post(
            text: text,
            photos: photos.map { _ in UUID().uuidString },
            user: .testUserJohn,
            groupID: groupID
        )
        didSubmitPost(post)
        dismiss()
    }
}

extension PostComposerPage {
    struct _Preview: View {
        
        @State private var navigation: NavigationPath = .init()
        
        var body: some View {
            Color.gray
                .fullScreenCover(isPresented: .constant(true)) {
                    PostComposerPage(
                        groupID: FitnessGroup.testGroupAtlantaRunners.id,
                        didSubmitPost: { _ in },
                        navigation: $navigation
                    )
                }
        }
    }
}

#Preview {
    PostComposerPage._Preview()
}
