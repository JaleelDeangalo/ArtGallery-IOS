//
//  ProfileVIewModel.swift
//  ArtGallery
//
//  Created by Jaleel Gilbert on 3/1/22.
//

import Foundation
import SwiftUI

@MainActor
final class ProfileViewModel: ObservableObject {
    
    @AppStorage("token") var token = ""
    @Published var username: String = ""
    @Published var avatar: String = ""
    @Published var bio: String = ""
    @Published var followers: Int = 0
    @Published var following: Int = 0
    
    
    func getUser() async {
        do {
            let data = try await ProfileRepository.shared.getUser()
            username = data.username
            avatar = data.avatar
            bio = data.bio
            followers = data.followers.count
            following = data.following.count
        } catch {
            print(error)
        }
    }
    
    
}
