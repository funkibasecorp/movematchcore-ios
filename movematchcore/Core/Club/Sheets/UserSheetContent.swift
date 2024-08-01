//
//  UserSheetContent.swift
//  SpotMatch
//
//  Created by Jake Sax on 7/23/24.
//

import SwiftUI

struct UserSheetContent: View {
    
    var user: User
    var addUserAsAdmin: (User) -> Void
    var removeUserFromGroup: (User) -> Void
    @Binding var isPresented: Bool
    @Binding var navigation: NavigationPath
    
    var body: some View {
        SheetContent(title: "", isPresented: $isPresented) {
            VStack(spacing: 16) {
                
                VStack(spacing: 12) {
                    ProfilePhotoView(
                        urlString: user.avatarURL,
                        size: 96,
                        cornerRadius: 96
                    )
                    
                    Text(user.name)
                        .font(.title)
                        .bold()
                    
                    HStack(spacing: 12) {
                        userDetail(icon: .personFill, text: "Male")
                        userDetail(icon: .mappin, text: user.location.description)
                        userDetail(icon: .personFill, text: "32 y.o.")
                    }
                }.frame(maxWidth: .infinity)
                    .padding(20)
                    .background {
                        RoundedRectangle(cornerRadius: 20)
                            .foregroundColor(brand: .white)
                    }
                
                
                button(
                    text: "View Full Profile",
                    icon: .personTextFill,
                    action: viewFullProfileWasPressed
                )
            
                button(
                    text: "Select As Admin",
                    icon: .personCropBadgePlus,
                    action: selectAsAdminWasPressed
                )
            
                button(
                    text: "Remove From This Group",
                    icon: .personBadgeMinus,
                    role: .destructive,
                    action: removeFromGroupWasPressed
                )
            }
            .padding(.horizontal, 20)
            
        }.background {
            VStack(spacing: 0) {
                Color.brand(.black)
                    .frame(height: 240)
                Color.brand(.lightGray)
            }.ignoresSafeArea()
        }
        
    }
    
    func userDetail(icon: Brand.Icon, text: String) -> some View {
        HStack(spacing: 2) {
            Icon(icon, size: 16)
                .foregroundColor(brand: .primaryBlue)
            Text(text)
                .foregroundColor(brand: .darkGray)
                .font(.caption)
        }
    }
    
    func button(
        text: String,
        icon: Brand.Icon,
        role: ButtonRole? = nil,
        action: @escaping () -> Void
    ) -> some View {
        ActionSheetButton(
            button: .init(
                text: text,
                icon: icon,
                role: role,
                action: action
            )
        ).disabled(true)
            .padding(16)
            .background {
                RoundedRectangle(cornerRadius: 20)
                    .foregroundColor(brand: .white)
            }
    }
    
    // MARK: Methods
    func viewFullProfileWasPressed() {
        Haptics.triggerGentleInteractionHaptic()
        print("view full profile")
    }
    
    func selectAsAdminWasPressed() {
        Haptics.triggerGentleInteractionHaptic()
        addUserAsAdmin(user)
    }
    
    func removeFromGroupWasPressed() {
        Haptics.triggerGentleInteractionHaptic()
        removeUserFromGroup(user)
    }
}

extension UserSheetContent {
    struct _Preview: View {
        
        @State private var admins: [User] = []
        @State private var members: [User] = [.testUserJohn, .testUserKaisla]
        
        @State private var isPresented: Bool = true
        @State private var navigation: NavigationPath = .init()
        
        var body: some View {
            Color.gray.ignoresSafeArea()
                .adaptiveSheet(isPresented: $isPresented) {
                    UserSheetContent(
                        user: .testUserJohn,
                        addUserAsAdmin: { admins.append($0) },
                        removeUserFromGroup: { user in members.removeAll(where: {$0 == user}) },
                        isPresented: $isPresented,
                        navigation: $navigation
                    )
                }
        }
    }
}

#Preview {
    UserSheetContent._Preview()
}
