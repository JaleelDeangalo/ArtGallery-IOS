//
//  Comment.swift
//  ArtGallery
//
//  Created by Jaleel Gilbert on 3/1/22.
//

import Foundation

struct Comment: Codable, Identifiable {
    
    let id: String
    let commentText: String
    let likesCount: [String]
    let userId: String
    let postId: String
    let date: Date
    
    enum CodiungKeys: String, CodingKey {
        case id = "_id"
        case commentText = "comment"
        case userId = "user"
        case postId = "postID"
        case likesCount = "likes"
        case date
    }
}

struct CommentInput: Codable {
    let newComment: String
    let newDate: Date
}
