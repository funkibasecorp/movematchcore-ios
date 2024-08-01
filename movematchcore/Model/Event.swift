//
//  Event.swift
//  spotmatch
//
//  Created by Chris Jones on 6/12/24.
//

import Foundation
import SwiftUI

struct Event: Identifiable {
    let id = UUID()
    let startDate: Date
    let endDate: Date
    let duration: Double
    let language: String
    let title: String
    let time: String
    let location: EventLocation
    let attendees: [User]
    let reoccurring: Bool
    let weekdays: [Weekday]
    let workout: Workout
    let type: EventType
    let facilitationType: FacilitationType
    let participantLimit: Int
    let description: String
    let itemsToBring: [String]
    let images: [String]
    let organizer: User
    let eventTags: [String]
    let eventGoal: EventGoal
}

// Define event types
enum EventGoal: String {
    case flexibility = "Flexibility"
    case strength = "Strength"
    case aerobics = "Aerobics"
    case mobility = "Mobility"
    
    var color: Color {
        switch self {
        case .flexibility: return .blue
        case .strength: return .red
        case .aerobics: return .green
        case .mobility: return .orange
        }
    }
}


enum Weekday: Int, Codable, Identifiable, Hashable {
    case monday
    case tuesday
    case wednesday
    case thursday
    case friday
    case saturday
    case sunday
    
    var id: Int { return self.rawValue }
}

enum EventType: Int, Codable, Identifiable, Hashable {
    case solo
    case publicEvent
    case privateEvent
    
    var id: Int { return self.rawValue }
}

enum FacilitationType: Int, Codable, Identifiable, Hashable {
    case coaching
    case trainer
    case spotter
    
    var id: Int { return self.rawValue }
}
