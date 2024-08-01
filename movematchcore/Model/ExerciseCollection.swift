//
//  ExerciseCollection.swift
//  spotmatch
//
//  Created by Chris Jones on 6/12/24.
//

import Foundation
import SwiftUI

struct ExerciseCollection: Identifiable {
    let id: UUID = UUID()
    let title: String
    let exercises: [Exercise]
    let emoji: String
    let color: Color
    let type: String = "exercise"
}
