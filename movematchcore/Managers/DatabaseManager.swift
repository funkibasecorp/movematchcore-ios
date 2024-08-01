//
//  DatabaseManager.swift
//  spotmatch
//
//  Created by Chris Jones on 5/28/24.
//

import Foundation
import Supabase

@MainActor
final class AuthViewModel: ObservableObject {
    @Published var signInPhone = ""
    @Published var signInEmail = ""
    @Published var signInPassword = ""
    @Published var currentUser: User?
    
    private let authService = AuthService.shared
    
    func logInWithPhone() async {
        do {
            try await authService.signInWithPhone(phone: signInPhone, password: signInPassword)
            currentUser = authService.currentUser
        } catch {
            print(error.localizedDescription)
        }
    }
    
    func logInWithEmail(email: String, password: String) async {
        do {
            try await authService.signInWithEmail(email: email, password: password)
            currentUser = authService.currentUser
        } catch {
            print(error.localizedDescription)
        }
    }
    
    func createAccountWithPhone() async {
        do {
            try await authService.registerNewUserWithPhone(phone: signInPhone, password: signInPassword)
            currentUser = authService.currentUser
        } catch {
            print(error.localizedDescription)
        }
    }
    
    func createAccountWithEmail() async {
        do {
            try await authService.registerNewUserWithEmail(email: signInEmail, password: signInPassword)
            currentUser = authService.currentUser
        } catch {
            print(error.localizedDescription)
        }
    }
    
    func logOut() async {
        do {
            try await authService.signOut()
            currentUser = nil
        } catch {
            print(error.localizedDescription)
        }
    }
}

@Observable
class AuthService {
    
    static let shared = AuthService()
    private let auth: AuthClient
    var currentUser: User? // Keep this as optional
    
    private init() {
        let supabaseURL = URL(string: Constant.Secrets.supabaseURL)!
        auth = SupabaseClient(supabaseURL: supabaseURL,
                              supabaseKey: Constant.Secrets.supebaseKey).auth
    }
    
    func registerNewUserWithPhone(phone: String, password: String) async throws {
        let response = try await auth.signUp(phone: phone, password: password)
        self.currentUser = response.user
    }
    
    func signUpWithPhone(phone: String, password: String) async throws {
        let response = try await auth.signUp(phone: phone, password: password)
        self.currentUser = response.user
    }
    
    func signInWithPhone(phone: String, password: String) async throws {
        let session = try await auth.signIn(phone: phone, password: password)
        self.currentUser = session.user
    }
    
    func registerNewUserWithEmail(email: String, password: String) async throws {
        let response = try await auth.signUp(email: email, password: password)
        self.currentUser = response.user
    }
    
    func signUpWithEmail(email: String, password: String) async throws {
        let response = try await auth.signUp(email: email, password: password)
        self.currentUser = response.user
    }
    
    func signInWithEmail(email: String, password: String) async throws {
        let session = try await auth.signIn(email: email, password: password)
        self.currentUser = session.user
    }
    
    func signInWithApple(idToken: String, nonce: String) async throws {
        let session = try await auth.signInWithIdToken(credentials: .init(idToken: idToken, nonce: nonce))
        self.currentUser = session.user
    }
    
    func signOut() async throws {
        try await auth.signOut()
        currentUser = nil
    }
}
