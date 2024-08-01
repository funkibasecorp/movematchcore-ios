//
//  Utilities.swift
//  SpotMatch
//
//  Created by Jake Sax on 7/22/24.
//

import Foundation

extension Date {
    /// Formats the date as a string in the format "February 12, 2024"
    ///
    /// - Returns: A string representing the date in the specified format.
    func formatAsFullDate() -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "MMMM d, yyyy"
        return formatter.string(from: self)
    }
    
    /// Converts the date to a relative time string (e.g., "2 hours ago")
    ///
    /// - Parameter style: The relative date formatting style to use. Defaults to .named.
    /// - Returns: A string representing the relative time from now to the date.
    func formatAsTimeAgo(style: RelativeDateTimeFormatter.UnitsStyle = .short) -> String {
        let formatter = RelativeDateTimeFormatter()
        formatter.unitsStyle = style
        return formatter.localizedString(for: self, relativeTo: Date())
    }
}
