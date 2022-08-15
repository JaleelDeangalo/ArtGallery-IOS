//
//  Post.swift
//  ArtGallery
//
//  Created by Jaleel Gilbert on 3/1/22.
//
import Foundation

struct Post: Codable, Identifiable {
    
    let id: String
    let image: String
    let username: String
    let avatar: String
    let commentsCount: [String]
    let likesCount: [String]
    let postDescription: String
    let title: String
    let userId: String
    
    private enum CodingKeys: String, CodingKey {
        case id = "_id"
        case commentsCount = "comments"
        case likesCount = "likes"
        case title = "details"
        case userId = "user"
        case postDescription = "description"
        case username, avatar, image
    }
}

struct PostInput: Codable {
    let description: String
    let image: String
    let details: String
}
