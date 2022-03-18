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
        let user, postId: String
        let v: Int

        enum CodingKeys: String, CodingKey {
            case likes, comment, date
            case id = "_id"
            case username, avatar, user, postId
            case v = "__v"
        }
    
}

struct CommentInput: Codable {
    let comment: String
}
