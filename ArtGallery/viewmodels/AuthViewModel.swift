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
    
    enum ApiErrors: Error {
        case invalidURL
        case invalidHTTPResponse
        case badRequest400
        case notAuthorized401
        case forbidden403
        case notFound404
        case internalServerError500
    }
    
    
    func login(email: String, password: String) async {
        
        guard !email.isEmpty, !password.isEmpty else {
            isError = true
            errorMessage = "All fields are required"
            return
        }
        
        isLoading = true
        do {
            let data = try await AuthRepository.shared.login(email: email, password: password)
            token = data.token
            auth = true
            isLoading = false
        } catch {
            isError = true
            isLoading = false
            print(error)
            errorMessage = "Email or password is invalid"
        }
        
    }
    
    
    func signup(username: String, email: String, password: String) async {
        
        guard !username.isEmpty, !email.isEmpty, !password.isEmpty else {
            isError = true
            errorMessage = "All fields are required"
            return
        }
        
        isLoading = true
        
        do {
            let data = try await AuthRepository.shared.signup(username: username, email: email, password: password)
            token = data.token
            auth = true
            isLoading = false
        } catch {
            isLoading = false
            isError = true
            print(error)
            errorMessage = "Email is in use"
           
        }
    }
    
    func signout() {
        auth = false
    }
    
}
