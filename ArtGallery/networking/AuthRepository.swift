//
//  AuthRepository.swift
//  ArtGallery
//
//  Created by Jaleel Gilbert on 3/1/22.
//
import Foundation
import SwiftUI

struct AuthRepository: AuthService {
    
    func login(email: String, password: String) async throws -> Token {
        return try await makeAuthRequest(param: "auth/login", method: POST, token: nil, input: AuthInput(username: nil, email: email, photoUrl: nil, password: password, idToken: nil))
    }
    
    func signup(username: String, email: String, password: String) async throws -> Token {
        return try await makeAuthRequest(param: "auth/signup", method: POST, token: nil, input: AuthInput(username: username, email: email, photoUrl: nil, password: password, idToken: nil))
    }
    
    func googleSignIn(username: String, email: String, photoUrl: String, idToken: String) async throws -> Token {
        return try await makeAuthRequest(param: "auth/googleLogin", method: POST, token: nil, input: AuthInput(username: username, email: email, photoUrl: photoUrl, password: nil, idToken: idToken))
    }
    
}
