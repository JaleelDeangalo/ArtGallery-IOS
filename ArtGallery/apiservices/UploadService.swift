
//
//  UploadService.swift
//  ArtGallery
//
//  Created by Jaleel Gilbert on 4/15/22.
//
import Foundation


protocol UploadService {
    
    func uploadImage(image: String, description: String, title: String, completion: @escaping (Result<Response, APIError>) -> ())
    
    func uploadUserData(newUsername: String, newEmail: String, newBio: String , newAvatar: String, completion: @escaping (Result<Response, APIError>) -> ())
    
    func deleteUser() async throws
    
}
