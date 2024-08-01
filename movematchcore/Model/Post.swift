//
//  Post.swift
//  SpotMatch
//
//  Created by Jake Sax on 7/22/24.
//

import Foundation

class Post: AnyActivity, Interactable {
 
    // MARK: Properties
    var id: UUID
    var text: String
    var photos: [String] = []
    var user: User
    var groupID: UUID
    var date: Date
    
    var isSharable: Bool { true }
    
    // MARK: Initialization
    init(
        id: UUID = UUID(),
        text: String,
        photos: [String] = [],
        user: User,
        groupID: UUID,
        date: Date = .now
    ) {
        self.id = id
        self.user = user
        self.text = text
        self.photos = photos
        self.groupID = groupID
        self.date = date
    }
    
    // MARK: Protocol Conformance
    static func == (lhs: Post, rhs: Post) -> Bool {
        lhs.id == rhs.id && lhs.text == rhs.text && lhs.photos == rhs.photos
    }
    
}

extension Post {
    static var testPost1 = Post(
        text: "The best places to get running shoes are often specialty stores dedicated to athletic gear and footwear. These stores typically offer a wide range of brands and styles tailored to various running needs, from trail running to marathon training. Additionally, sports department stores in larger retail chains can also be good options, providing both popular brands and budget-friendly choices. Online retailers offer convenience and a vast selection, allowing runners to compare prices and read customer reviews before making a purchase. Lastly, visiting local running clubs or events sometimes leads to discovering specialty shops or exclusive discounts, making it worthwhile to explore community resources for avid runners.",
        photos: ["photoURL"],
        user: User.testUserKaisla,
        groupID: FitnessGroup.testGroupAtlantaRunners.id,
        date: Date().addingTimeInterval(-60*60*2)
    )
    
    static var testPost2 = Post(
        text: "Being part of this running group has completely transformed my running experience. The camaraderie and support from fellow runners make a huge difference.",
        photos: [],
        user: User.testUserJohn,
        groupID: FitnessGroup.testGroupAtlantaRunners.id,
        date: Date().addingTimeInterval(-60*60*3)
    )
}
