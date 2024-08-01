//
//  FitnessGroup+NotificationSettings.swift
//  SpotMatch
//
//  Created by Jake Sax on 7/25/24.
//

import Foundation

extension FitnessGroup {
    struct NotificationSettings: Codable {
        var allowsNotifications: Bool = true
        var allowsMentions: Bool = true
        var allowsLeaderboardUpdates: Bool = true
        var allowsNewChallenges: Bool = true
    }
}
