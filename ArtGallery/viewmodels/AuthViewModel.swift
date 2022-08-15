//
//  File.swift
//  ArtGallery
//
//  Created by Jaleel Gilbert on 3/1/22.
//
import Foundation
import SwiftUI

@MainActor
final class AuthViewModel: ObservableObject {
    
    @AppStorage("token") var token = ""
    @AppStorage("Authorization") var auth = false
    @Published var isError: Bool = false
    @Published var isLoading: Bool = false
    @Published var errorMessage: String = ""
    
    private let delegate: AuthService
    
    init(delegate: AuthService) {
        self.delegate = delegate
    }
    
    func login(email: String, password: String) async {
        
        guard !email.isEmpty, !password.isEmpty else {
            self.isError = true
            self.errorMessage = "All fields are required"
            return
        }
        
        self.isLoading = true
        do {
            let data = try await delegate.login(email: email, password: password)
            self.token = data.token
            self.auth = true
            self.isLoading = false
        } catch {
            self.isError = true
            self.isLoading = false
            print(error)
            self.errorMessage = "Email or password is invalid"
        }
        
    }
    
    
    func signup(username: String, email: String, password: String) async {
        
        guard !username.isEmpty, !email.isEmpty, !password.isEmpty else {
            self.isError = true
            self.errorMessage = "All fields are required"
            return
        }
        
        self.isLoading = true
        
        do {
            let data = try await delegate.signup(username: username, email: email, password: password)
            self.token = data.token
            self.auth = true
            self.isLoading = false
        } catch {
            self.isLoading = false
            self.isError = true
            print(error)
            self.errorMessage = "Email is in use"
           
        }
    }
    
    func signout() { self.auth = false }
    
}
