//
//  GroupActionSheetModifier.swift
//  SpotMatch
//
//  Created by Jake Sax on 7/26/24.
//

import SwiftUI

private struct GroupActionSheetModifier: ViewModifier {
    
    // MARK: Data
    var group: FitnessGroup
    var isMember: Bool
    var isAdmin: Bool
    var groupWasJoined: (FitnessGroup) -> Void
    var groupWasLeft: (FitnessGroup) -> Void
    var groupWasDeleted: (FitnessGroup) -> Void
    @Environment(User.self) private var user
    
    // MARK: UI
    @Binding var isPresentingActionSheet: Bool
    @Binding var navigation: NavigationPath
    @State private var isPresentingShareSheet: Bool = false
    @State private var isPresentingNotificationsPage: Bool = false
    @State private var isReportingGroup: Bool = false
    
    func body(content: Content) -> some View {
        content
            .customActionSheet(
                isPresented: $isPresentingActionSheet,
                actionButtons: actionButtons
            )
            .adaptiveSheet(isPresented: $isPresentingShareSheet) {
                ShareGroupSheetContent(isPresented: $isPresentingShareSheet)
            }
            .adaptiveSheet(isPresented: $isReportingGroup) {
                ReportGroupSheetContent(isPresented: $isReportingGroup)
            }
            .navigationDestination(isPresented: $isPresentingNotificationsPage) {
                NotificationSettingsPage(
                    groupID: group.id,
                    isPresented: $isPresentingNotificationsPage
                )
            }
    }
    
    private var actionButtons: [ActionSheetButton.Configuration] {
        if isAdmin {
            return adminActionSheetButtons
        } else if isMember {
            return memberActionSheetButtons
        } else {
            return nonmemberActionSheetButtons
        }
    }
    
    private var adminActionSheetButtons: [ActionSheetButton.Configuration] {
        [
            .init(
                text: "Create Group Challenge",
                icon: .mountains,
                action: createChallengeWasPressed
            ),
            .init(
                text: "Create Event",
                icon: .flag,
                action: createEventWasPressed
            ),
            shareGroupButton,
            .init(
                text: "Group Settings",
                icon: .settings,
                action: groupSettingsWasPressed
            ),
            notificationSettingsButton,
            .init(
                text: "Delete Group",
                icon: .trash,
                role: .destructive,
                action: deleteGroupWasPressed
            )
        ]
    }
    private var notificationSettingsButton: ActionSheetButton.Configuration {
        .init(
            text: "Notification Settings",
            icon: .bell,
            action: notificationSettingsWasPressed
        )
    }
    
    private var shareGroupButton: ActionSheetButton.Configuration {
        .init(
            text: "Share Group",
            icon: .share,
            action: shareGroupWasPressed
        )
    }
    
    private var reportGroupButton: ActionSheetButton.Configuration {
        .init(
            text: "Report Group",
            icon: .exclamationTriangleFill,
            role: .destructive,
            action: reportGroupWasPressed
        )
    }
    
    private var memberActionSheetButtons: [ActionSheetButton.Configuration] {
        [
            notificationSettingsButton,
            shareGroupButton,
            reportGroupButton,
            .init(
                text: "Leave Group",
                icon: .leaveGroup,
                role: .destructive,
                action: leaveGroupWasPressed
            ),
        ]
    }
    
    private var nonmemberActionSheetButtons: [ActionSheetButton.Configuration] {
        [
            .init(
                text: "Join Group",
                icon: .plus,
                action: joinGroupWasPressed
            ),
            shareGroupButton,
            reportGroupButton
        ]
    }
    
    // MARK: Methods
    func shareGroupWasPressed() {
        Haptics.triggerGentleInteractionHaptic()
        isPresentingActionSheet = false
        Task {
            try await Task.sleep(for: .seconds(0.2))
            await MainActor.run {
                isPresentingShareSheet = true
            }
        }
    }
    
    func createChallengeWasPressed() {
        Haptics.triggerGentleInteractionHaptic()
    }
    
    func createEventWasPressed() {
        Haptics.triggerGentleInteractionHaptic()
    }
    
    func groupSettingsWasPressed() {
        Haptics.triggerGentleInteractionHaptic()
        isPresentingActionSheet = false
        navigation.append(
            GroupSettingsPage.NavRequest(group: group)
        )
        
    }
    
    func notificationSettingsWasPressed() {
        Haptics.triggerGentleInteractionHaptic()
        isPresentingActionSheet = false
        Task {
            try await Task.sleep(for: .seconds(0.2))
            await MainActor.run {
                isPresentingNotificationsPage = true
            }
        }
    }
    
    func deleteGroupWasPressed() {
        Haptics.triggerGentleInteractionHaptic()
        groupWasDeleted(group)
    }
    
    func joinGroupWasPressed() {
        Haptics.triggerGentleInteractionHaptic()
        isPresentingActionSheet = false
        if !group.members.contains(user.id) {
            group.members.append(user.id)
        }
        groupWasJoined(group)
    }
    
    func leaveGroupWasPressed() {
        Haptics.triggerGentleInteractionHaptic()
        isPresentingActionSheet = false
        group.members.removeAll(where: {$0 == user.id})
        group.admins.removeAll(where: {$0 == user.id})
        groupWasLeft(group)
    }
    
    func reportGroupWasPressed() {
        Haptics.triggerGentleInteractionHaptic()
        isPresentingActionSheet = false
        Task {
            try await Task.sleep(for: .seconds(0.2))
            await MainActor.run {
                isReportingGroup = true
            }
        }
    }
    
}

extension View {
    func groupActionSheet(
        group: FitnessGroup,
        isMember: Bool,
        isAdmin: Bool,
        groupWasJoined: @escaping (FitnessGroup) -> Void,
        groupWasLeft: @escaping (FitnessGroup) -> Void,
        groupWasDeleted: @escaping (FitnessGroup) -> Void,
        isPresentingActionSheet: Binding<Bool>,
        navigation: Binding<NavigationPath>
    ) -> some View {
        self.modifier(
            GroupActionSheetModifier(
                group: group,
                isMember: isMember,
                isAdmin: isAdmin,
                groupWasJoined: groupWasJoined,
                groupWasLeft: groupWasLeft,
                groupWasDeleted: groupWasDeleted,
                isPresentingActionSheet: isPresentingActionSheet,
                navigation: navigation
            )
        )
    }
}

//#Preview {
//    GroupActionSheetModifier()
//}
