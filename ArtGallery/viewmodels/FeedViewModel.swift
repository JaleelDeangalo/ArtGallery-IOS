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
    @Published var isLoading: Bool = false
    @Published var message: String = ""
    
    init() {
        Task {
            await getPosts()
        }
    }
    
    func getPosts() async {
        do {
            let data = try await FeedRepository.shared.getPosts()
            posts = data
        } catch {
            print("getPosts")
            print(error)
        }
    }
    
    func likePost(id: String) async {
        do {
            let data = try await FeedRepository.shared.likePost(id: id)
            message = data.Message
        } catch {
            print(error)
        }
    }
    
    
    func unlikePost(id: String) async {
        do {
            let data = try await FeedRepository.shared.unlikePost(id: id)
            message = data.Message
        } catch {
            print(error)
        }
    }
    
    
    func checkIfLiked(currentUserId: String, post: Post) -> Bool {
        var liked: Bool = false
        post.likesCount.forEach { id in
            if currentUserId == id {
                liked = true
            }
        }
        return liked
    }
    
}
