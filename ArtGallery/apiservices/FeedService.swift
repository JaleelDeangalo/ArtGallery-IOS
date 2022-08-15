//
//  ApiService.swift
//  ArtGallery
//
//  Created by Jaleel Gilbert on 4/9/22.
//
import Foundation


protocol FeedService {
    
    
    func getPosts() async throws -> [Post]
    
  //  func getUser() async throws -> User
    
  //  func getSelectedUser(id: String) async throws -> User
    
   // func getPostsData(id: String) async throws -> Post
    
    func followUser(id: String) async throws
    
    func unfollowUser(id: String) async throws
    
  //  func getSelectedUserPost(id: String) async throws -> User
    
    func likePost(id: String) async throws
    
    func unlikePost(id: String) async throws
    
}
