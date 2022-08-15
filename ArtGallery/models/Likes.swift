//
//  Likes.swift
//  ArtGallery
//
//  Created by Jaleel Gilbert on 4/15/22.
//
import Foundation

struct Likes: Codable, Identifiable {
    let id: String
    let postId: String
    let likes: [String]
    let userId: String
    
    private enum CodingKeys: String, CodingKey {
        case id
        case likes
        case postId, userId
    }
}
