//
//  UploadViewModel.swift
//  ArtGallery
//
//  Created by Jaleel Gilbert on 3/1/22.
//

import Foundation
import UIKit
import SwiftUI
import FirebaseStorage

final class UploadViewModel: ObservableObject {
    
    @Published var responseMessage: String = ""
    @Published var isLoading: Bool = false
    @Published var isError: Bool = false
    @Published var errorMessage: String = ""
    @Published var isUploading: Bool = false
    
    func uploadImage(image: UIImage, postDescription: String, title: String) {
        
        guard postDescription != "", title != "" else { return }
        
        isUploading = true
        isLoading = true
        
        let imageRef = FirebaseManager.shared.storage.reference().child("images")
        guard let uploadedImage = image.jpegData(compressionQuality: 1) else { return }
        
        let metaDataConfig = StorageMetadata()
        metaDataConfig.contentType = "image/jpg"
        imageRef.putData(uploadedImage, metadata: metaDataConfig) { data, error in
            guard error == nil else {
                self.isUploading = false
                self.isError = true
                self.errorMessage = "Image failed to save"
                return }
            print("photo saved in database")
        
            imageRef.downloadURL { url, error in
                guard let url = url else { return }
                UploadRepository.shared.uploadImage(newImage: url.absoluteString, newPostDescription: postDescription, newTitle: title) { [weak self] result in
                
                    switch result {
                        
                    case .success(let response):
                        print("Image Uploaded")
                        DispatchQueue.main.async {
                            self?.isUploading = false
                            self?.isLoading = false
                            self?.responseMessage = response.Message
                        }
                        
                    case .failure(let error):
                        DispatchQueue.main.async {
                            self?.isUploading = false
                            self?.isError = true
                            self?.errorMessage = "Failed to upload"
                            self?.isLoading = false
                        }
                        print(error)
                        
                    }
                    
                }
               
            }
            
        }
        
        isLoading = false
      
      
    }
    
    func deleteUser() async {
        do {
            try await UploadRepository.shared.deleteUser()
        } catch {
            print(error)
        }
    }
    
    
    func uploadProfileImage(username: String, email: String, bio: String, avatar: UIImage?, currentAvatar: String) {
        
        isUploading = true
        if avatar != nil {
            let imageRef = FirebaseManager.shared.storage.reference().child("profile/images")
            guard let uploadedImage = avatar?.jpegData(compressionQuality: 1) else { return }
            
            let metaDataConfig = StorageMetadata()
            metaDataConfig.contentType = "image/jpg"
            
            imageRef.putData(uploadedImage, metadata: metaDataConfig) { data, error in
                guard error == nil else {
                    print("Image failed to save to firebase")
                    self.isUploading = false
                    self.isError = true
                    self.errorMessage = "Image failed to save"
                    return
                }
                
                print("Image saved to firebase")
                
                imageRef.downloadURL { url, error in
                    guard let url = url, error == nil else { return }
                    
                    UploadRepository.shared.uploadUserData(newUsername: username, newEmail: email, newBio: bio, newAvatar: url.absoluteString) { [weak self] result in
                        
                        switch result {
                            
                        case .success(let response):
                            print("Image saved to database")
                            DispatchQueue.main.async {
                                self?.responseMessage = response.Message
                                self?.isUploading = false
                            }
                            
                        case .failure(let error):
                            self?.isUploading = false
                            print(error)
                        }
                        
                    }
                }
            }
        } else {
            UploadRepository.shared.uploadUserData(newUsername: username, newEmail: email, newBio: bio, newAvatar: currentAvatar) { [weak self] result in
                
                switch result {
                    
                case .success(let response):
                    DispatchQueue.main.async {
                        self?.isUploading = false
                        self?.responseMessage = response.Message
                    }
                    
                case .failure(let error):
                    self?.isUploading = false
                    print(error)
                }
                
            }
        }
      
        
    }
    
  
    
}
