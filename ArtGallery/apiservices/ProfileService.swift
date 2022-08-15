//
//  ProfileService.swift
//  ArtGallery
//
//  Created by Jaleel Gilbert on 4/15/22.
//
import Foundation


protocol ProfileService {
    
    func getUser() async throws -> User
    
    func updateUser(email: String, username: String, avatar: String, bio: String) async throws -> User
    
    func deleteUser() async throws
    
    
}
