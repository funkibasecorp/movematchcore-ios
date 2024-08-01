//
//  GroupActivityFeedPage.swift
//  SpotMatch
//
//  Created by Jake Sax on 7/22/24.
//

import SwiftUI

struct GroupActivityFeedPage: View {
    
    // MARK: Data
    var group: FitnessGroup
    @State private var activity: [any AnyActivity] = []
    
    // MARK: UI
    @Binding var navigation: NavigationPath
    @State private var isPresentingGroupShareSheet: Bool = false
    @State private var isPresentingActivityShareSheet: Bool = false
    @State private var isComposingPost: Bool = false
    
    var body: some View {
        ScrollView {
            
            VStack {
                toolbar
                
                VStack(spacing: 20) {
                    Text(group.name)
                        .font(.title).bold()
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .foregroundColor(brand: .white)
                    
                    ForEach(activity, id: \.id) { activityItem in
                        ActivityView(activity: activityItem)
                    }
                 
                    TextButton("Post", action: postWasPressed)
                    
                }.padding(.horizontal, 20)
                    .padding(.top, 96)
            }
            
        }.background(.blue)
        .adaptiveSheet(isPresented: $isPresentingGroupShareSheet) {
            ShareGroupSheetContent(isPresented: $isPresentingGroupShareSheet)
        }
        .navigationBarBackButtonHidden()
        .fullScreenCover(isPresented: $isComposingPost) {
            PostComposerPage(   
                groupID: group.id,
                didSubmitPost: { post in
                    withAnimation {
                        activity.insert(post, at: 0)
                    }
                },
                navigation: $navigation
            )
        }
        .task {
            do {
                try await fetchActivity()
            } catch {
                print(error.localizedDescription)
            }
        }
    }
    
    var toolbar: some View {
        TopToolbar(
            leadingButtons: [
                .init(
                    icon: .chevronLeft,
                    action: {
                        Haptics.triggerGentleInteractionHaptic()
                        navigation.goBack()
                    }
                )
            ],
            trailingButtons: [
                .init(
                    icon: .share,
                    yOffset: -2,
                    action: {
                        Haptics.triggerGentleInteractionHaptic()
                        isPresentingGroupShareSheet = true
                    }
                ),
                .init(
                    icon: .ellipsis,
                    action: {
                        Haptics.triggerGentleInteractionHaptic()
                        print("ellipsis presed")
                    }
                )
            ]
        )
    }
    
    // MARK: Methods
    func fetchActivity() async throws {
        try await Task.sleep(for: .seconds(0.2))
        await MainActor.run {
            withAnimation {
                self.activity = [
                    Post.testPost1, JoinGroupActivity.test1, Post.testPost2
                ].sorted(by: {$0.date > $1.date})
            }
        }
    }
    
    func postWasPressed() {
        Haptics.triggerGentleInteractionHaptic()
        isComposingPost = true
    }
    
    // MARK: Supporting Views
    struct ActivityView: View {
        
        var activity: any AnyActivity
        @State private var likes: Int = 1202
        @State private var wasLiked: Bool = false
        
        var body: some View {
            VStack(spacing: 16) {
                
                HStack {
                    ProfilePhotoView(
                        urlString: activity.user.avatarURL,
                        size: 48,
                        cornerRadius: 48
                    )
                    VStack(alignment: .leading, spacing: 4) {
                        Text(activity.user.name)
                            .foregroundColor(brand: .black)
                        HStack(spacing: 8) {
                            if let activity = activity as? JoinGroupActivity {
                                Text(activity.text)
                                    .bold()
                                    .frame(maxWidth: .infinity, alignment: .leading)
                                
                            }
                            Text(activity.date.formatAsTimeAgo())
                                
                        }.foregroundColor(brand: .gray)
                            .font(.caption)
                    }.frame(maxWidth: .infinity, alignment: .leading)
                    
                    if activity.isSharable {
                        IconButton(
                            .share,
                            bkgdColor: .clear,
                            strokeColor: .brand(.lightGray),
                            yOffset: -2,
                            action: {
                                Haptics.triggerGentleInteractionHaptic()
                                print("share activity")
                            }
                        )
                    }
                    
                }
                
                if let post = activity as? Post {
                    VStack(alignment: .leading, spacing: 12) {
                        Text(post.text)
                            .font(.body)
                            .multilineTextAlignment(.leading)
                            .foregroundColor(brand: .black)
                            .frame(maxWidth: .infinity, alignment: .leading)
                        
                        ForEach(post.photos, id: \.description) { photo in
                            RoundedRectangle(cornerRadius: 24)
                                .aspectRatio(16/9, contentMode: .fill)
                                .foregroundColor(brand: .gray)
                        }
                    }
                }
                
                if activity is Interactable {
                    HStack(spacing: 16) {
                        interactionButton(
                            icon: .heartFill,
                            iconColor: wasLiked ? .red : .brand(.gray),
                            count: likes,
                            action: likesWasPressed
                        )
                        interactionButton(
                            icon: .textBubbleFill,
                            iconColor: .brand(.primaryBlue),
                            count: 22,
                            action: commentsWasPressed
                        )
                    }.frame(maxWidth: .infinity, alignment: .leading)
                        .foregroundColor(brand: .primaryBlue)
                }
                
            }.padding(20)
                .background {
                    RoundedRectangle(cornerRadius: 24)
                        .foregroundColor(brand: .white)
                }
        }
        
        func interactionButton(
            icon: Brand.Icon,
            iconColor: Color,
            count: Int,
            action: @escaping () -> Void
        ) -> some View {
            Button(action: action) {
                HStack(spacing: 6) {
                    Icon(icon, size: 12)
                        .foregroundColor(iconColor)
                    Text(count.description)
                        .font(.caption)
                        .foregroundColor(brand: .darkGray)
                        .contentTransition(.numericText(value: Double(count)))
                }.padding(.horizontal, 12)
                    .padding(.vertical, 8)
                    .background {
                        RoundedRectangle(cornerRadius: 100)
                            .stroke(Color.brand(.lightGray), lineWidth: 1)
                    }
            }
        }
        
        // MARK: Methods
        func likesWasPressed() {
            Haptics.triggerGentleInteractionHaptic()
            withAnimation {
                if wasLiked {
                    likes -= 1
                } else {
                    likes += 1
                }
                wasLiked.toggle()
            }
        }
        
        func commentsWasPressed() {
            Haptics.triggerGentleInteractionHaptic()
            print("comment was pressed")
        }
        
    }
    
    // MARK: Data Structures
    struct NavRequest: Hashable {
        var group: FitnessGroup
    }
    
}

extension GroupActivityFeedPage {
    struct _Preview: View {
        
        @State private var navigation: NavigationPath = .init()
        
        var body: some View {
            GroupActivityFeedPage(
                group: .testGroupAtlantaRunners,
                navigation: $navigation
            )
        }
    }
}


#Preview {
    GroupActivityFeedPage._Preview()
}
