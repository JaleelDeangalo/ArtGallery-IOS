//
//  FeedViewModel.swift
//  ArtGallery
//
//  Created by Jaleel Gilbert on 3/1/22.
//

import Foundation

@MainActor
final class FeedViewModel: ObservableObject {
    @Published var posts: [Post] = []
    
    func getPosts() async {
        
        do {
            let data = try await FeedRepository.shared.getPosts()
            posts = data
        } catch {
            print(error)
        }
    }
}
