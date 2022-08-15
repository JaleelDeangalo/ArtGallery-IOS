//
//  FeedRepository.swift
//  ArtGallery
//
//  Created by Jaleel Gilbert on 3/1/22.
//
import Foundation
import SwiftUI

class FeedRepository: FeedService {
    
    @AppStorage("token") var token = ""
    
    func getPosts() async throws -> [Post] {
        return try await makeFeedRequest(param: "post", method: GET, token: nil)
    }
    
    func followUser(id: String) async throws {
        try await toggleFollow(param: "user/\(id)", method: POST, token: token)
    }
    
    func unfollowUser(id: String) async throws {
        try await toggleFollow(param: "user/\(id)", method: POST, token: token)
    }
    
    func likePost(id: String) async throws {
      try await toggleLikes(param: "post/like/\(id)", method: PUT, token: token)
    }
    
    func unlikePost(id: String) async throws {
        try await toggleLikes(param: "post/unlike/\(id)", method: PUT, token: token)
    }
    
    
}
