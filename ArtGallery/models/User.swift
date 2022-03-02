//
//  User.swift
//  ArtGallery
//
//  Created by Jaleel Gilbert on 3/1/22.
//

import Foundation

struct User: Codable, Identifiable {
    
    let id: String
    let username: String
    let email: String
    let password: String
    let avatar: String
    let bio: String
    let followers: [String]
    let following: [String]
    
    enum CodingKeys: String, CodingKey {
        case id = "_id"
        case username, email, password, bio, avatar
        case following, followers
    }
}

struct UserInput: Codable {
    let newEmail: String?
    let newUsername: String?
    let newAvatar: String?
    let newBio: String?
}

struct LoginInput: Codable {
    let email: String
    let password: String
}

struct SignupInput: Codable {
    let username: String
    let email: String
    let password: String
}

struct Token: Codable {
    let jwt: String
}
