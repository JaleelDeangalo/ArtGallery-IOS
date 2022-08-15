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
    
    private let delegate: FeedService
    
    init(delegate: FeedService) {
        self.delegate = delegate
    }
    
    func getPosts() async {
        do {
            self.posts = try await delegate.getPosts()
        } catch {
            print("getPosts")
            print(error)
        }
    }
    
    func likePost(id: String) async {
        do {
            try await delegate.likePost(id: id)
        } catch {
            print(error)
        }
    }
    
    
    func unlikePost(id: String) async {
        do {
            try await delegate.unlikePost(id: id)
        } catch {
            print(error)
        }
    }
    
}
