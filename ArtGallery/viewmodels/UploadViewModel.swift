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
    
    func uploadImage(image: UIImage, postDescription: String, title: String) {
        
        guard postDescription != "", title != "" else {
            return
        }
        
        isLoading = true
        
        let imageRef = FirebaseManager.shared.storage.reference().child("images")
        guard let uploadedImage = image.jpegData(compressionQuality: 1) else { return }
        
        let metaDataConfig = StorageMetadata()
        metaDataConfig.contentType = "image/jpg"
        imageRef.putData(uploadedImage, metadata: metaDataConfig) { data, error in
            guard error == nil else { return }
            print("photo saved in database")
        
            imageRef.downloadURL { url, error in
                guard let url = url else { return }
                UploadRepository.shared.uploadImage(newImage: url.absoluteString, newPostDescription: postDescription, newTitle: title) { [weak self] result in
                
                    switch result {
                        
                    case .success(let response):
                        print("Image Uploaded")
                        DispatchQueue.main.async {
                            self?.isLoading = false
                            self?.responseMessage = response.Message
                        }
                        
                    case .failure(let error):
                        DispatchQueue.main.async {
                            self?.isLoading = false
                        }
                        print(error)
                        
                    }
                    
                }
               
            }
            
        }
        
        isLoading = false
      
      
    }
    
  
    
}
