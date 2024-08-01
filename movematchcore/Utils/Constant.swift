//
//  Constant.swift
//  spotmatch
//
//  Created by Chris Jones on 6/9/24.
//

import SwiftUI

struct Constant {
    
    
    // MARK: Links
    static let websiteURL = URL(string: "https://www.apple.com")
    static let termsURL = URL(string: "https://www.apple.com")
    static let privacyURL = URL(string: "https://www.apple.com")
    
    // MARK: Manage app environment with release type
    static let appEnvironment: DeploymentEnvironment = .development
    
    // MARK: App environments
    enum DeploymentEnvironment {
        case development
        case staging
        case production
    }
    
    // MARK: Get URLs (Base url etc.)
    enum URLs {
        static let baseUrl = getBaseURL()
    }
    
    // MARK: Supabase Secrets
    enum Secrets {
        static let supabaseURL = "https://dfhpyspvnrijljkhfxgn.supabase.co"
        static let supebaseKey = "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImRmaHB5c3B2bnJpamxqa2hmeGduIiwicm9sZSI6ImFub24iLCJpYXQiOjE3MTY5MzU1NTAsImV4cCI6MjAzMjUxMTU1MH0.TtUIwwi7qNPOgyOkp8ZcMPmz0EW_OMEGmusSdYmCrfg"
    }
    
    // MARK: Provide base url for current app environment
    static func getBaseURL() -> String {
        switch Constant.appEnvironment {
        case .development:
            return "<development_base_url>"
        case .staging:
            return "<staging_base_url>"
        case .production:
            return "<production_base_url>"
        }
    }
    
    
    // MARK: Get API keys
    enum APIKeys {
        static let RESTful = Constant.getAPIKey()
        static let google = ""
    }
    
    // MARK: Provide API key for current app environment
    static func getAPIKey() -> String {
        switch Constant.appEnvironment {
        case .development:
            return ""
        case .staging:
            return ""
        case .production:
            return ""
        }
    }

    enum Strings {
        static let isDarkTheme = "is_dark_theme"
        static let isAuthenticated = "is_authenticated"
    }
}
