//
//  AnyActivity.swift
//  SpotMatch
//
//  Created by Jake Sax on 7/22/24.
//

import SwiftUI

/// An activity that can be shared in a ``FitnessGroup``'s Activity Feed.
protocol AnyActivity: Identifiable, Codable, Equatable where Self.ID == UUID {
    var id: UUID { get set }
    /// The text of the activity to display.
    var text: String { get }
    /// The date the activity took place.
    var date: Date { get set }
    /// The user who the activity references.
    var user: User { get set }
    
    /// Whether the activity can be shared.
    var isSharable: Bool { get }
}
