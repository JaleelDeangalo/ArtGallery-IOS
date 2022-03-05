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
    
    func login(email: String, password: String) async {
        
        do {
            let data = try await AuthRepository.shared.login(email: email, password: password)
            token = data.token
            auth = true
        } catch {
            print(error)
        }
        
    }
    
    
    func signup(username: String, email: String, password: String) async {
        
        do {
            let data = try await AuthRepository.shared.signup(username: username, email: email, password: password)
            token = data.token
            auth = true
        } catch {
            print(error)
        }
    }
    
    func signout() {
        auth = false
    }
    
}
