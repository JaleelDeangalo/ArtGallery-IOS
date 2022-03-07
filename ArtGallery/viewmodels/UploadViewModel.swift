//
//  UploadViewModel.swift
//  ArtGallery
//
//  Created by Jaleel Gilbert on 3/1/22.
//

import Foundation
import UIKit


final class UploadViewModel: ObservableObject {
    
    @Published var responseMessage: String = ""
    
    func uploadImage(image: Data, postDescription: String, title: String) {
        
        let imageRef = FirebaseManager.shared.storage.reference().child("images")
        let uploadTask = imageRef.putData(image, metadata: nil) { data, error in
            guard error == nil else {
                return
            }
            imageRef.downloadURL { url, error in
                guard let downloadURL = url else {
                    return
                }
                
                let image = downloadURL.absoluteString
                UploadRepository.shared.uploadImage(newImage: image, newPostDescription: postDescription, newTitle: title) { [weak self] result in
                    
                    switch result {
                    case .success(let response):
                        DispatchQueue.main.async {
                            self?.responseMessage = response.Message
                        }
                    case .failure(let error):
                        print(error)
                    }
                    
                }
             
            }
        }
        
        uploadTask.resume()
      
    }
    
  
    
}
