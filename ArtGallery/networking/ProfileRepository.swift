//
//  ProfileRepository.swift
//  ArtGallery
//
//  Created by Jaleel Gilbert on 3/1/22.
//
import Foundation
import SwiftUI

struct ProfileRepository: ProfileService {
    
    @AppStorage("token") var token = ""
    
    func getUser() async throws -> User {
        return try await makeUserRequest(param: "user", method: GET, token: token, input: nil)
    }
    
    func updateUser(email: String, username: String, avatar: String, bio: String) async throws -> User {
        return try await makeUserRequest(param: "user", method: PUT, token: token, input: UserInput(username: username, email: email, bio: bio, avatar: avatar))
    }
    
    func deleteUser() async throws {
      try await makeProfileRequestVoid(param: "user", method: DELETE, token: token, input: nil)
    }
    
}
