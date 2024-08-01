//
//  ReportReason.swift
//  SpotMatch
//
//  Created by Jake Sax on 7/25/24.
//

import Foundation

/// Represents the reason for reporting content.
/// Conforms to `PickerControllable` for use in picker interfaces.
enum ReportReason: PickerControllable {
    
    /// Report reason is advertisement-related.
    case ads
    
    /// Report reason is discrimination-related.
    case discrimination
    
    /// Report reason is not covered by other cases.
    /// - Parameter reason: A string describing the specific reason.
    case other(reason: String)
    
    /// All possible cases of `ReportReason`.
    ///
    /// Note: The `other` case uses an empty string as a placeholder.
    static var allCases: [ReportReason] = [.ads, .discrimination, .other(reason: "")]
    
    /// Unique identifier for each case.
    ///
    /// This property allows `ReportReason` to be used as its own `Identifiable` type.
    var id: Self { self }
    
    var pickerTitle: String {
        switch self {
        case .ads: "Ads"
        case .discrimination: "Discrimination"
        case .other(_): "Other Reason"
        }
    }
    
    /// Indicates whether the reason is of type `other`.
    ///
    /// - Returns: `true` if the reason is `other`, `false` otherwise.
    var isOther: Bool {
        switch self {
        case .other(_): true
        default: false
        }
    }
}
