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
    
    private let delegate: UploadService
    
    init(delegate: UploadService) {
        self.delegate = delegate
    }
    
    func uploadImage(image: UIImage, postDescription: String, title: String) {
        
        guard postDescription != "", title != "" else { return }
        
        self.isUploading = true
        self.isLoading = true
        
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
                self.delegate.uploadImage(image: url.absoluteString, description: postDescription, title: title) { [weak self] result in
                
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
        
        self.isLoading = false
      
      
    }
    
    func deleteUser() async {
        do {
            try await delegate.deleteUser()
        } catch {
            print(error)
        }
    }
    
    
    func uploadProfileImage(username: String, email: String, bio: String, avatar: UIImage?, currentAvatar: String) {
        
        self.isUploading = true
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
                    
                    self.delegate.uploadUserData(newUsername: username, newEmail: email, newBio: bio, newAvatar: url.absoluteString) { [weak self] result in
                        
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
            self.delegate.uploadUserData(newUsername: username, newEmail: email, newBio: bio, newAvatar: currentAvatar) { [weak self] result in
                
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
