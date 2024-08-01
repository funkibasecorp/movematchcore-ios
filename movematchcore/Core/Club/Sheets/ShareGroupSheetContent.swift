//
//  ShareGroupSheetContent.swift
//  SpotMatch
//
//  Created by Jake Sax on 7/23/24.
//

import SwiftUI

struct ShareGroupSheetContent: View {
    
    @Binding var isPresented: Bool
    
    var body: some View {
        SheetContent(title: "Share Group", isPresented: $isPresented) {
            HStack {
                Button(action: copyLinkWasPressed) {
                    VStack(spacing: 16) {
                        IconButton(
                            .link,
                            bkgdColor: .brand(.primaryBlue),
                            iconColor: .brand(.white),
                            action: nil
                        )
                        Text("Copy Link")
                            .foregroundColor(brand: .black)
                    }
                }
                
                Spacer()
                
                shareButton(
                    image: "X",
                    bkgdColor: .black,
                    action: shareToXWasPressed
                )
                
                Spacer()
                
                shareButton(
                    image: "Instagram",
                    bkgdColor: .pink,
                    action: shareToInstagramWasPressed
                )
                
                Spacer()
                
                shareButton(
                    image: "Facebook",
                    bkgdColor: .blue,
                    action: shareToFacebookWasPressed
                )
                
            }.padding(.horizontal, 20)
        }
    }
    
    func shareButton(
        image: String,
        bkgdColor: Color,
        action: @escaping () -> Void
    ) -> some View {
        Button(action: action) {
            VStack(spacing: 16) {
                RoundedRectangle(cornerRadius: 16)
                    .fill(bkgdColor)
                    .frame(width: 56, height: 56)
                    .overlay {
                        Image(image)
                            .resizable()
                            .frame(width: 24, height: 24)
                    }
                Text(image)
                    .foregroundColor(brand: .black)
            }
        }
    }
    
    // MARK: Methods
    func copyLinkWasPressed() {
        
    }
    
    func shareToXWasPressed() {
        
    }
    
    func shareToInstagramWasPressed() {
        
    }
    
    func shareToFacebookWasPressed() {
        
    }
}

#Preview {
    Color.gray
        .adaptiveSheet(isPresented: .constant(true)) {
            ShareGroupSheetContent(isPresented: .constant(true))
        }
}
