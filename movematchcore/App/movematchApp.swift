//
//  spotmatchApp.swift
//  spotmatch
//
//  Created by Chris Jones on 5/12/24.
//

import SwiftUI

@main
struct movematchApp: App {
    @StateObject var themeManager = ThemeManager.shared
    
    var body: some Scene {
        WindowGroup {
            RootView()
//                .environmentObject(themeManager)
//                .preferredColorScheme(themeManager.theme.type == .dark ? .light : .dark)
        }
    }
}

class AppDelegate: UIResponder, UIApplicationDelegate {
    
    @MainActor static var keyWindow: UIWindow? {
        (UIApplication.shared.connectedScenes.first as? UIWindowScene)?.keyWindow
    }
}
