//
//  ProfileVIewModel.swift
//  ArtGallery
//
//  Created by Jaleel Gilbert on 3/1/22.
//

import Foundation

@MainActor
final class ProfileViewModel: ObservableObject {

    @Published var username: String = ""
    @Published var avatar: String = ""
    @Published var bio: String = ""
    @Published var email: String = ""
    @Published var followers: Int = 0
    @Published var following: Int = 0
    
    
    init() {
        Task {
            await getUser()
        }
    }
    
    func getUser() async {
        do {
            let data = try await ProfileRepository.shared.getUser()
            self.username = data.username
            self.avatar = data.avatar
            self.bio = data.bio
            self.email = data.email
            self.followers = data.followers.count
            self.following = data.following.count
        } catch {
            print("getUser")
            print(error)
        }
    }
    
    func updateUser(email: String, username: String, avatar: String, bio: String) async {
        do {
            let data = try await ProfileRepository.shared.updateUser(email: email, username: username, avatar: avatar, bio: bio)
            self.username = data.username
            self.avatar = data.avatar
            self.bio = data.bio
        } catch {
            print(error)
        }
    }
    
    
}
