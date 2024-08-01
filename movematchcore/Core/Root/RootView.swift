//
//  RootView.swift
//  spotmatch
//
//  Created by Chris Jones on 6/9/24.
//

import SwiftUI

struct RootView: View {
    @State var isAuthenticated = AuthManager.isAuthenticated
    @State var showSignup = true

    var body: some View {
        NavigationView {
            ZStack {
                if isAuthenticated {
                    TabBarView()
                } else {
                    Login()
                }
            }
            .onReceive(AuthManager.authStatus) {
                isAuthenticated = $0
            }
        }
    }
}

#Preview {
    RootView()
}
