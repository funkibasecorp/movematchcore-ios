//
//  Location.swift
//  spotmatch
//
//  Created by Chris Jones on 6/13/24.
//

import Foundation

struct Location: Identifiable, Codable, Equatable, CustomStringConvertible {
    let id: UUID
    let city: String
    let state: String?
    let country: String
    
    var description: String {
        [city, state, country].compactMap{$0}.joined(separator: ", ")
    }
    
    init(city: String, state: String? = nil, country: String) {
        self.city = city
        self.state = state
        self.country = country
        self.id = UUID()
    }
}

extension Location {
    static let testLocationCupertino = Location(
        city: "Cupertino",
        state: "California",
        country: "USA"
    )
    static let testLocationAtlanta = Location(
        city: "Atlanta",
        state: "Georgia",
        country: "USA"
    )
}



struct EventLocation: Identifiable, Codable, Equatable {
    let id: UUID = UUID()
    let name: String
    let city: String
    let state: String?
    let country: String
    let latitude: Double
    let longitude: Double

    init(name: String, city: String, state: String? = nil, country: String, latitude: Double, longitude: Double) {
        self.name = name
        self.city = city
        self.state = state
        self.country = country
        self.latitude = latitude
        self.longitude = longitude
    }
}

let sampleEventLocation = EventLocation(
    name: "Apple Park Visitor Center",
    city: "Cupertino",
    state: "California",
    country: "USA",
    latitude: 37.333744,
    longitude: -122.009056
)

let sampleLocation = Location(
    city: "Cupertino",
    state: "California",
    country: "USA"
)

let sampleGlobalLocation = Location(city: "Global", state: "Global", country: "Global")
