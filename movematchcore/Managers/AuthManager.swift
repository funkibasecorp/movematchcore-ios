//
//  AuthManager.swift
//  spotmatch
//
//  Created by Chris Jones on 6/9/24.
//

import Combine
import SwiftUI

struct AuthManager {
    static let authStatus = PassthroughSubject<Bool, Never>()

    static var isAuthenticated: Bool {
        UserDefaults.standard.bool(forKey: Constant.Strings.isAuthenticated)
    }

    static func setAuthenticated(_ value: Bool) {
        UserDefaults.standard.set(value, forKey: Constant.Strings.isAuthenticated)
        AuthManager.authStatus.send(value)
    }
}
