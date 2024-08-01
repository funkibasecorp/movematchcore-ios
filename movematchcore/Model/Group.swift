//
//  Group.swift
//  spotmatch
//
//  Created by Chris Jones on 6/20/24.
//

import Foundation
import SwiftUI

struct UserGroup: Identifiable {
    let id: UUID
    let name: String
    let description: String
    let members: [User]
    let admins: [User]
    let isPublic: Bool
    let createdDate: String
    let location: Location?
    let activities: [Activity]
    let currentChallenge: Challenge
    let leaderboard: [LeaderboardMember]
    let coverImage: Data?
    let isLocal: Bool
    let createdBy: User
}

struct Activity: Identifiable {
    let id: UUID
    let content: String
    let timestamp: String
    let userName: String
    let userAvatar: Image
}

struct LeaderboardMember: Identifiable {
    let id: UUID
    let name: String
    let score: Int
    let rank: Int
    let avatar: Image
}

let sampleActivity = Activity(id: UUID(), content: "Best places to get running shoes", timestamp: "2 hours ago", userName: "Kaisla", userAvatar: Image(systemName: "person.crop.circle"))
let sampleChallenge = Challenge(id: UUID(), title: "Week 27 Workout", description: "Complete this week's workout for points!")
let sampleLeaderboard = [
    LeaderboardMember(id: UUID(), name: "John", score: 11, rank: 1, avatar: Image(systemName: "person.crop.circle")),
    LeaderboardMember(id: UUID(), name: "Abram George", score: 9, rank: 2, avatar: Image(systemName: "person.crop.circle")),
    LeaderboardMember(id: UUID(), name: "Jane Doe", score: 8, rank: 3, avatar: Image(systemName: "person.crop.circle"))
]

let mockGroups: [UserGroup] = [
    UserGroup(
        id: UUID(),
        name: "Fitness Enthusiasts",
        description: "A group for fitness lovers",
        members: Array(repeating: sampleUsers[0], count: 120),
        admins: Array(repeating: sampleUsers[0], count: 5),
        isPublic: true,
        createdDate: "January 1, 2021",
        location: sampleLocation,
        activities: [sampleActivity],
        currentChallenge: sampleChallenge,
        leaderboard: sampleLeaderboard,
        coverImage: nil,
        isLocal: true,
        createdBy: sampleUsers[1]
    ),
    UserGroup(
        id: UUID(),
        name: "Yoga Lovers",
        description: "A group for yoga enthusiasts",
        members: Array(repeating: sampleUsers[0], count: 80),
        admins: Array(repeating: sampleUsers[0], count: 3),
        isPublic: false,
        createdDate: "March 15, 2021",
        location: sampleLocation,
        activities: [Activity(id: UUID(), content: "Yoga poses for beginners", timestamp: "1 hour ago", userName: "Alex", userAvatar: Image(systemName: "person.crop.circle"))],
        currentChallenge: Challenge(id: UUID(), title: "Week 28 Yoga Challenge", description: "Complete daily yoga sessions for points!"),
        leaderboard: [
            LeaderboardMember(id: UUID(), name: "Alex", score: 15, rank: 1, avatar: Image(systemName: "person.crop.circle")),
            LeaderboardMember(id: UUID(), name: "Jane", score: 12, rank: 2, avatar: Image(systemName: "person.crop.circle")),
            LeaderboardMember(id: UUID(), name: "Bob", score: 10, rank: 3, avatar: Image(systemName: "person.crop.circle"))
        ],
        coverImage: nil,
        isLocal: false,
        createdBy: sampleUsers[0]
    ),
    UserGroup(
        id: UUID(),
        name: "Cycling Community",
        description: "A group for cycling enthusiasts",
        members: Array(repeating: sampleUsers[0], count: 150),
        admins: Array(repeating: sampleUsers[0], count: 4),
        isPublic: true,
        createdDate: "May 20, 2021",
        location: sampleLocation,
        activities: [Activity(id: UUID(), content: "Best cycling routes", timestamp: "3 hours ago", userName: "Emma", userAvatar: Image(systemName: "person.crop.circle"))],
        currentChallenge: Challenge(id: UUID(), title: "Week 29 Cycling Challenge", description: "Ride your bike daily for points!"),
        leaderboard: [
            LeaderboardMember(id: UUID(), name: "Emma", score: 18, rank: 1, avatar: Image(systemName: "person.crop.circle")),
            LeaderboardMember(id: UUID(), name: "Bob", score: 14, rank: 2, avatar: Image(systemName: "person.crop.circle")),
            LeaderboardMember(id: UUID(), name: "John", score: 12, rank: 3, avatar: Image(systemName: "person.crop.circle"))
        ],
        coverImage: nil,
        isLocal: true,
        createdBy: sampleUsers[1]
    )
]


@Observable class FitnessGroup: Identifiable, Codable, Hashable {
  
    // MARK: Properties
    var id: UUID
    var name: String
    var description: String
    var members: [UUID]
    var admins: [UUID]
    var createdBy: UUID
    var creationDate: Date
    var privacy: Privacy
    var isPublic: Bool {
        privacy == .public
    }
    var isPublicText: String {
        isPublic ? "Public" : "Private"
    }
    var location: Location
    var locationPrivacy: LocationPrivacy
    
    // MARK: Initialization
    internal init(
        id: UUID = UUID(),
        name: String,
        description: String,
        members: [UUID],
        admins: [UUID],
        createdBy: UUID,
        creationDate: Date,
        privacy: Privacy,
        location: Location,
        locationPrivacy: LocationPrivacy = .global
    ) {
        self.id = id
        self.name = name
        self.description = description
        self.members = members
        self.admins = admins
        self.createdBy = createdBy
        self.creationDate = creationDate
        self.privacy = privacy
        self.location = location
        self.locationPrivacy = locationPrivacy
    }
    
    // MARK: Protocol Conformance
    static func == (lhs: FitnessGroup, rhs: FitnessGroup) -> Bool {
        lhs.id == rhs.id &&
        lhs.name == rhs.name &&
        lhs.description == rhs.description &&
        lhs.isPublic == rhs.isPublic &&
        lhs.location == rhs.location &&
        lhs.privacy == rhs.privacy &&
        lhs.locationPrivacy == rhs.locationPrivacy
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
    
    // MARK: Data Structures
    enum Privacy: String, PickerControllable, Codable {
        case `private`, `public`
    }
    
    enum LocationPrivacy: String, PickerControllable, Codable {
        case local, global
    }
    
}

extension FitnessGroup {
    static let testGroups: [FitnessGroup] = [
        testGroupAtlantaRunners,
        testGroupYogaLovers,
        testGroupCyclingComunity,
        testGroupFitnessEnthusiasts
    ]
    static let testGroupAtlantaRunners: FitnessGroup = FitnessGroup(
        name: "Atlanta Runners",
        description: "Connect with Purdue Alumni in the Atlanta area. Join us for regular meetups, networking events, and group activities.",
        members: (1...12).map { _ in UUID() },
        admins: [UUID(), UUID(), UUID()],
        createdBy: User.testUserChris.id,
        creationDate: Date().addingTimeInterval(-60*60*24*8),
        privacy: .public,
        location: .testLocationAtlanta
    )
    static let testGroupFitnessEnthusiasts: FitnessGroup = FitnessGroup(
        name: "Fitness Enthusiasts",
        description: "A group for fitness lovers",
        members: (1...120).map { _ in UUID() },
        admins: (1...5).map { _ in UUID() },
        createdBy: User.testUserChris.id,
        creationDate: Date(),
        privacy: .public,
        location: .testLocationCupertino
    )
    
    static let testGroupYogaLovers: FitnessGroup = FitnessGroup(
        name: "Yoga Lovers",
        description: "A group for yoga enthusiasts",
        members: (1...80).map { _ in UUID() },
        admins: (1...3).map { _ in UUID() },
        createdBy: User.testUserJohn.id,
        creationDate: Date(),
        privacy: .public,
        location: .testLocationCupertino
    )
    static let testGroupCyclingComunity: FitnessGroup = FitnessGroup(
        name: "Cycling Community",
        description: "A group for cycling enthusiasts",
        members: (1...150).map { _ in UUID() },
        admins: (1...4).map { _ in UUID() },
        createdBy: User.testUserJohn.id,
        creationDate: Date(),
        privacy: .public,
        location: .testLocationCupertino
    )
}
