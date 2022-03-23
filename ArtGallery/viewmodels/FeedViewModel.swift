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
    @Published var currentUserId: String = ""
    @Published var isLoading: Bool = false
    @Published var message: String = ""
    @Published var postAvatar: String = ""
    @Published var postUsername: String = ""
    
    init() {
        Task {
            await getPosts()
            await getUser()
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
    
    func getUser() async {
        do {
            let data = try await FeedRepository.shared.getUser()
            currentUserId = data.id
        } catch {
            print("getUser")
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
    
    func getSelectedUserPosts(id: String) async {
        do {
            let data = try await FeedRepository.shared.getSelectedUser(id: id)
            postAvatar = data.avatar
            postUsername = data.username
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
