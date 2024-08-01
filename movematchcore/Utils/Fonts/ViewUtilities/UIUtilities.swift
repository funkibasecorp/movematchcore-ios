//
//  UIUtilities.swift
//  SpotMatch
//
//  Created by Jake Sax on 7/22/24.
//

import SwiftUI

extension UIScreen {
    /// Gets the true width of the device, does not change based on orientation.
    static let deviceWidth: CGFloat = AppDelegate.keyWindow?.windowScene?.screen.fixedCoordinateSpace.bounds.width ?? UIScreen.main.fixedCoordinateSpace.bounds.width
    /// Gets the true height of the device, does not change based on orientation.
    static let deviceHeight: CGFloat = AppDelegate.keyWindow?.windowScene?.screen.fixedCoordinateSpace.bounds.height ?? UIScreen.main.fixedCoordinateSpace.bounds.height
}

/// A namespace for controlling simple haptic events.
enum Haptics {
    /// Triggers a light haptic, suitable for toggles, or other simple
    /// interactions.
    static func triggerGentleInteractionHaptic() {
        UIImpactFeedbackGenerator(style: .light).impactOccurred(intensity: 0.8)
    }
    
    /// Triggers a medium haptic, suitable for enhancing an interaction,
    /// especially recommended for when the user is confirming or changing something.
    static func triggerInteractionHaptic() {
        UIImpactFeedbackGenerator(style: .medium).impactOccurred(intensity: 0.8)
    }
    
    /// Triggers a series of haptics, suitable for when the user submitted
    /// or succeeded at something.
    static func triggerSuccessHaptic() {
        UINotificationFeedbackGenerator().notificationOccurred(.success)
    }
    
    /// Triggers a haptic, suitable for indicating a warning.
    static func triggerWarningHaptic() {
        UINotificationFeedbackGenerator().notificationOccurred(.warning)
    }
    
    /// Triggers a pair of rigid haptics, suitable for indicating an error.
    static func triggerErrorHaptic() {
        UINotificationFeedbackGenerator().notificationOccurred(.error)
    }
}


extension NavigationPath {
    mutating func goBack() {
        if self.count > 0 {
            self.removeLast()
        }
    }
    
    mutating func goToHomePage() {
        self.removeAll()
    }
    
    mutating func removeAll() {
        self.removeLast(self.count)
    }
    
    public var debugDescription: String {
        """
NavigationPath:
    Count: \(self.count)
"""
    }
}
