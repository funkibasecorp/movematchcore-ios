//
//  Challenge.swift
//  SpotMatch
//
//  Created by Jake Sax on 7/22/24.
//

import Foundation

class Challenge: Identifiable, Equatable, Hashable {
    
    // MARK: Properties
    var id: UUID
    var title: String
    var description: String
    
    // MARK: Initialization
    init(id: UUID = UUID(), title: String, description: String) {
        self.id = id
        self.title = title
        self.description = description
    }
    
    // MARK: Protocol Conformance
    static func == (lhs: Challenge, rhs: Challenge) -> Bool {
        lhs.id == rhs.id && lhs.title == rhs.title
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}

extension Challenge {
    static let testChallenge1 = Challenge(
        title: "Week 27 Workout",
        description: "Complete this week's workout for points!"
    )
}
