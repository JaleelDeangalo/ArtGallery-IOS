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
    @Published var selectedUserFollowing: [String] = []
    @Published var selectedUserFollowers: [String] = []
    @Published var currentUsername: String = ""
    @Published var message: String = ""
    @Published var currentUserFollower: [String] = []
    @Published var currentUserFollowing: [String] = []
    
    let repository: FeedRepository
    
    init(repository: FeedRepository) {
        self.repository = repository
        Task {
        
        }
    }
    
  /*
   func getUser() async {
       do {
           let data = try await repository.getUser()
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
           let data = try await repository.getSelectedUser(id: id)
           selectedUsername = data.username
           selectedUserAvatar = data.avatar
           selectedUserBio = data.bio
           selectedUserFollowers = data.followers
       } catch {
           print("selectedUser")
           print(error)
       }
   }
   */
    
    func followUser(id: String) async {
        do {
           try await repository.followUser(id: id)
        } catch {
            print(error)
        }
    }
    
    
    func unfollowUser(id: String) async {
        do {
            try await repository.unfollowUser(id: id)
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
