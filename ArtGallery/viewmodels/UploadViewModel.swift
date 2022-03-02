//
//  UploadViewModel.swift
//  ArtGallery
//
//  Created by Jaleel Gilbert on 3/1/22.
//

import Foundation

final class UploadViewModel: ObservableObject {
    
    @Published var responseMessage: String = ""
    
    func uploadImage(image: Data, postDescription: String, title: String, postId: String, userId: String) async {
     
        do {
            let response = try await UploadRepository.shared.uploadImage(newImage: "", newPostDescription: postDescription, newTitle: title, postId: postId, userId: userId)
            responseMessage = response.Message
        } catch {
            print(error)
        }
        
    }
    
}
