//
//  AllExercisesVM.swift
//  FitooZone
//
//  Created by Pankaja Wijesena on 2023-07-01.
//

import Foundation

struct Exercises {
    let id: String = UUID().uuidString
    let name: String
    let time: String
    let image: String

    static var sample: Exercises {
        Exercises(
            name: "Front and Back Lunge",
            time: "0:30",
            image: "https://picsum.photos/200"
        )
    }
}

class AllExercisesVM: ObservableObject {
    @Published var searchText = ""
    let categories = ["All Exercises", "Arms", "Chest", "Legs", "Shoulders", "Back"]
    @Published var activeCategory = "All Exercises"
    @Published var exercises: [Exercises] = Array(
        repeating: Exercises(name: "Front and Back Lunge", time: "0:30", image: "https://picsum.photos/200"),
        count: 7
    )
}
