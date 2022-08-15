
//
//  Follow.swift
//  ArtGallery
//
//  Created by Jaleel Gilbert on 4/15/22.
//
import Foundation


struct Follow: Codable, Identifiable {
    let id: String
    let followers: [String]
    let following: [String]
    let userId: String
    
    private enum CodingKeys: String, CodingKey {
        case id, userId
        case followers, following
    }
}
