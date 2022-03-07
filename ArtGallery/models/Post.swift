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
    
    enum CodingKeys: String, CodingKey {
        case id = "_id"
        case commentsCount = "comments"
        case likesCount = "likes"
        case title = "details"
        case image
        case userId = "user"
        case postDescription = "description"
        case username, avatar
    }
}

struct PostInput: Codable {
    let newImage: String?
    let newPostDescription: String?
    let newTitle: String?
}
