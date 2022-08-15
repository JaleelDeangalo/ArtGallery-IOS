//
//  Comment.swift
//  ArtGallery
//
//  Created by Jaleel Gilbert on 3/1/22.
//
import Foundation



struct Comment: Codable, Identifiable {
    
        let likes: [String]
        let comment, date, id, username: String
        let avatar: String
        let userId, postId: String

        private enum CodingKeys: String, CodingKey {
            case likes, comment, date
            case id = "_id"
            case userId = "user"
            case username, avatar, postId
        }
    
}

struct CommentInput: Codable {
    let comment: String
}
