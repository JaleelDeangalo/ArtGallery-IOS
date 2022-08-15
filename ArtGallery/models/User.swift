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
    let avatar: String
    let bio: String
    let followers: [String]
    let following: [String]
    let posts: [Post]
    let myPosts: [Post]
    let date: String
    
   private enum CodingKeys: String, CodingKey {
        case id = "_id"
        case username, email, bio, avatar
        case following, followers
        case posts, myPosts
        case date
    }
}

struct UserInput: Codable {
    let username: String
    let email: String
    let bio: String
    let avatar: String?
}


struct AuthInput: Codable {
    let username: String?
    let email: String
    let photoUrl: String?
    let password: String?
    let idToken: String?
}


struct Token: Codable {
    let token: String
}
