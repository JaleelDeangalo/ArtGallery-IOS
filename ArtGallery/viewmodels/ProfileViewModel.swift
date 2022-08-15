//
//  ProfileVIewModel.swift
//  ArtGallery
//
//  Created by Jaleel Gilbert on 3/1/22.
//
import Foundation

@MainActor
final class ProfileViewModel: ObservableObject {
    @Published var user: User
    
    private let delegate: ProfileService
    
    init(delegate: ProfileService) {
        self.delegate = delegate
        self.user = User(id: "", username: "", email: "", avatar: "", bio: "", followers: [], following: [], posts: [], myPosts: [], date: "")
    }
    
    func getUser() async {
        do {
            let data = try await delegate.getUser()
            self.user = data
        } catch {
            print("getUser")
            print(error)
        }
    }
    
    func updateUser(email: String, username: String, avatar: String, bio: String) async {
        do {
            let data = try await delegate.updateUser(email: email, username: username, avatar: avatar, bio: bio)
            self.user = data
        } catch {
            print(error)
        }
    }
    
    
}
