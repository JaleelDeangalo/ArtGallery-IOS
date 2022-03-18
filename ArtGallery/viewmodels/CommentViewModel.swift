//
//  File.swift
//  ArtGallery
//
//  Created by Jaleel Gilbert on 3/1/22.
//

import Foundation

@MainActor
final class CommentViewModel: ObservableObject {
    
    @Published var comments: [Comment] = []
    @Published var response: String = ""
    @Published var isLoading: Bool = false
    
    func readComments(postId: String) async {
        isLoading = true
        do {
            let data = try await CommentRepository.shared.readComments(postId: postId)
            comments = data
            isLoading = false
        } catch {
            isLoading = false
            print(error)
        }
    }
    
    func postComment(postId: String, comment: String) async {
        do {
            let data = try await CommentRepository.shared.postComment(postId: postId, comment: comment)
            response = data.Message
        } catch {
            print(error)
        }
    }
    
    func updateComment(postId: String, comment: String, commentId: String) async {
        do {
            let data = try await CommentRepository.shared.updateComment(postId: postId, comment: comment, commentId: commentId)
            response = data.Message
        } catch {
            print(error)
        }
    }
    
    func deleteComment(postId: String, commentId: String) async {
        do {
            let data = try await CommentRepository.shared.deleteComment(postId: postId, commentId: commentId)
            response = data.Message
        } catch {
            print(error)
        }
    }
    
    
}
