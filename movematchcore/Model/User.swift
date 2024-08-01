//
//  User.swift
//  spotmatch
//
//  Created by Chris Jones on 6/12/24.
//

import SwiftUI

@Observable class User: Identifiable, Codable, Hashable {
    
    // MARK: Properties
    var id: UUID = UUID()
    var name: String
    var avatarURL: String?
    var location: Location
    var notificationSettings: [FitnessGroup.ID: FitnessGroup.NotificationSettings] = [:]
    
    // MARK: Initialization
    init(
        id: UUID = UUID(),
        name: String,
        avatarURL: String? = nil,
        location: Location,
        notificationSettings: [FitnessGroup.ID: FitnessGroup.NotificationSettings] = [:]
    ) {
        self.id = id
        self.name = name
        self.avatarURL = avatarURL
        self.location = location
        self.notificationSettings = notificationSettings
    }

    // MARK: Protocol Conformance
    static func == (lhs: User, rhs: User) -> Bool {
        lhs.id == rhs.id && lhs.name == rhs.name && lhs.avatarURL == rhs.avatarURL && lhs.location == rhs.location
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
    
}

extension User {
    static let testUserChris = User(name: "Chris", location: .testLocationAtlanta)
    static let testUserKaisla = User(name: "Kaisla", location: .testLocationCupertino)
    static let testUserJohn = User(name: "John", location: .testLocationAtlanta)
    static let testUserAbramGeorge = User(name: "Abram George", location: .testLocationCupertino)
    
    private static let names: [String] = [
        "Olivia", "Liam", "Emma", "Noah", "Ava", "Sophia", "Isabella", "Mia",
        "Amelia", "Harper", "Evelyn", "Abigail", "Ella", "Elizabeth", "Camila",
        "Luna", "Sofia", "Avery", "Mila", "Aria", "Scarlett", "Penelope", "Layla",
        "Chloe", "Victoria", "Madison", "Eleanor", "Grace", "Nora", "Riley",
        "Zoey", "Hannah", "Hazel", "Lily", "Ellie", "Violet", "Lillian", "Zoe",
        "Stella", "Aurora", "Natalie", "Emilia", "Everly", "Leah", "Aubrey",
        "Willow", "Addison", "Lucy", "Audrey", "Bella"
    ]
    
    static let testMockUserList: [User] = names.map { User(name: $0, location: .testLocationAtlanta)}
}

