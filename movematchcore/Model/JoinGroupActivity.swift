//
//  JoinGroupActivity.swift
//  SpotMatch
//
//  Created by Jake Sax on 7/23/24.
//

import Foundation

/// The activity of when a user joins a ``FitnessGroup``.
class JoinGroupActivity: AnyActivity {
    
    // MARK: Properties
    var id: UUID
    
    var groupID: UUID
    
    var text: String { "Has joined the group" }
    
    var date: Date
    
    var user: User
    
    var isSharable: Bool { false }
    
    // MARK: Initialization
    internal init(
        id: UUID = UUID(),
        groupID: UUID,
        date: Date,
        user: User
    ) {
        self.id = id
        self.groupID = groupID
        self.date = date
        self.user = user
    }
    
    // MARK: Protocol Conformance
    static func == (lhs: JoinGroupActivity, rhs: JoinGroupActivity) -> Bool {
        lhs.id == rhs.id && lhs.groupID == rhs.groupID && lhs.user == rhs.user && lhs.date == rhs.date
    }
    
}

extension JoinGroupActivity {
    static let test1 = JoinGroupActivity(
        groupID: FitnessGroup.testGroupAtlantaRunners.id,
        date: Date().addingTimeInterval(-60*60*2.5),
        user: User.testUserKaisla
    )
}
