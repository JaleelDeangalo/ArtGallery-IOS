//
//  AuthService.swift
//  ArtGallery
//
//  Created by Jaleel Gilbert on 4/15/22.
//
import Foundation


protocol AuthService {
    
    func login(email: String, password: String) async throws -> Token
    
    func signup(username: String, email: String, password: String) async throws -> Token
    
    func googleSignIn(username: String, email: String, photoUrl: String, idToken: String) async throws -> Token
    
}
