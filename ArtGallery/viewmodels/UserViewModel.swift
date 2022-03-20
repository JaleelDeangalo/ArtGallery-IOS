//
//  UserViewModel.swift
//  ArtGallery
//
//  Created by Jaleel Gilbert on 3/18/22.
//

import Foundation

@MainActor
final class UserViewModel: ObservableObject {
    @Published var selectedUsername: String = ""
    @Published var selectedUserAvatar: String = ""
    @Published var selectedUserBio: String = ""
    @Published var selectedId: String = ""
    @Published var selectedUserFollowers: [String] = []
    @Published var currentUsername: String = ""
    @Published var message: String = ""
    @Published var currentUserFollower: [String] = []
    @Published var currentUserFollowing: [String] = []
    
    init() {
        Task {
        
        }
    }
    
    func getUser() async {
        do {
            let data = try await FeedRepository.shared.getUser()
            currentUsername = data.username
            currentUserFollower = data.followers
            currentUserFollowing = data.following
        } catch {
            print("getUser/ UserViewModel")
            print(error)
        }
    }
    
    func getSelectedUser(id: String) async {
        do {
            let data = try await FeedRepository.shared.getSelectedUser(id: id)
            selectedUsername = data.username
            selectedUserAvatar = data.avatar
            selectedUserBio = data.bio
            selectedUserFollowers = data.followers
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
    
    func checkIfFollowing(currentUserId: String) -> Bool {
        var isFollowing: Bool = false
        
        selectedUserFollowers.forEach { id in
            if currentUserId == id {
                isFollowing = true
            }
        }
        return isFollowing
    }

}
