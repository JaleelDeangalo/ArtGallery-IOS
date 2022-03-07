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
    @Published var selectedUsername: String = ""
    @Published var selectedUserAvatar: String = ""
    @Published var selectedUserBio: String = ""
    @Published var message: String = ""
    @Published var currentUsername: String = ""
    @Published var currentUserFollower: [String] = []
    @Published var currentUserFollowing: [String] = []
    
    init() {
        Task {
            await getPosts()
        }
    }
    
    
    func getUser() async {
        do {
            let data = try await FeedRepository.shared.getUser()
            currentUsername = data.username
            currentUserFollower = data.followers
            currentUserFollowing = data.following
        } catch {
            print(error)
        }
    }
    func getPosts() async {
        do {
            let data = try await FeedRepository.shared.getPosts()
            posts = data
        } catch {
            print(error)
        }
    }
    
    func getSelectedUser(id: String) async {
        do {
            let data = try await FeedRepository.shared.getSelectedUser(id: id)
            selectedUsername = data.username
            selectedUserAvatar = data.avatar
            selectedUserBio = data.bio
        } catch {
            print(error)
        }
    }
    
    func followUser(id: String) async {
        do {
            let data = try await FeedRepository.shared.followUser(id: id)
            message = data.Message
        } catch {
            print(error)
        }
    }
    
    
    func unfollowUser(id: String) async {
        do {
            let data = try await FeedRepository.shared.unfollowUser(id: id)
            message = data.Message
        } catch {
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
    
    
    func checkIfLiked() -> Bool {
        return false
    }
    
    
    func checkIfFollowing() -> Bool {
        return false
    }
}
