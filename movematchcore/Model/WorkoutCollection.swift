//
//  WorkoutCollection.swift
//  spotmatch
//
//  Created by Chris Jones on 6/12/24.
//

import Foundation
import SwiftUI

struct WorkoutCollection: Identifiable {
    let id: UUID = UUID()
    let title: String
    let workouts: [Workout]
    let emoji: String
    let color: Color
    let type: String = "workout"
}
