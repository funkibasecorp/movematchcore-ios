//
//  GroupChallengeDetailPage.swift
//  SpotMatch
//
//  Created by Jake Sax on 7/22/24.
//

import SwiftUI

struct GroupChallengeDetailPage: View {
    
    // MARK: Data
    var challenge: Challenge
    @State private var workouts: [Workout] = [.testWorkout1]
    
    // MARK: UI
    @Binding var navigation: NavigationPath
    
    var body: some View {
        ScrollView {
            VStack(spacing: 16) {
                PageHeaderView(title: "Group Challenge", navigation: $navigation)
                
                Divider()
                
                VStack(spacing: 16) {
                    Text("To get started, add 7 days worth of workouts that users can schedule and complete. Whether it's intense cardio sessions, strength training circuits, or rejuvenating yoga practices, let's fill this week with energizing activities to keep everyone engaged and motivated.")
                        .font(.caption)
                        .foregroundColor(brand: .darkGray)
                    
                    Text(challenge.title)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(20)
                        .background {
                            RoundedRectangle(cornerRadius: 100)
                                .stroke(Color.brand(.lightGray), lineWidth: 1)
                        }
                    
                    ForEach(workouts) { workout in
                        workoutListItem {
                            HStack {
                                Circle()
                                    .frame(width: 56, height: 56)
                                    .foregroundColor(brand: .gray)
                                VStack(alignment: .leading) {
                                    Text(workout.name)
                                        .bold()
                                        .foregroundColor(brand: .black)
                                    Text(workout.muscle)
                                        .foregroundColor(brand: .darkGray)
                                        .font(.footnote)
                                }.frame(maxWidth: .infinity, alignment: .leading)
                                
                                
                                Icon(.ellipsis, size: 24)
                            }
                        }
                    }
                    
                    ForEach(workouts.count..<7, id: \.self) { _ in
                        workoutListItem {
                            HStack {
                                Circle()
                                    .frame(width: 56, height: 56)
                                    .foregroundColor(brand: .gray)
                                Text("Add New Workout")
                                    .bold()
                                    .foregroundColor(brand: .gray)
                            }
                        }
                    }
                    
                }
                .padding(.horizontal, 20)
                .padding(.bottom, 80)
            }
        }.overlay(alignment: .bottom) {
            TextButton("Create Challenge", action: createChallengeWasPressed)
                .padding(.horizontal, 20)
        }
        .navigationBarBackButtonHidden()
    }
    
    func workoutListItem<Item: View>(_ item: () -> Item) -> some View {
        item()
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(20)
            .background {
                RoundedRectangle(cornerRadius: 20)
                    .stroke(Color.brand(.lightGray))
            }
    }
    
    // MARK: Methods
    func createChallengeWasPressed() {
        Haptics.triggerGentleInteractionHaptic()
    }
}

extension GroupChallengeDetailPage {
    struct _Preview: View {
        
        @State private var navigation: NavigationPath = .init()
        
        var body: some View {
            GroupChallengeDetailPage(
                challenge: .testChallenge1,
                navigation: $navigation
            )
        }
    }
}


#Preview {
    GroupChallengeDetailPage._Preview()
}
