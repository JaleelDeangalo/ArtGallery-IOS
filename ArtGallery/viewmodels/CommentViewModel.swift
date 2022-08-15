//
//  File.swift
//  ArtGallery
//
//  Created by Jaleel Gilbert on 3/1/22.
//
import Foundation

@MainActor
final class CommentViewModel: ObservableObject {
    
    @Published var comments: [Comment] = [Comment]()
    @Published var response: String = ""
    @Published var isLoading: Bool = false
    
    private let delegate: CommentService
    
    init(delegate: CommentService) {
        self.delegate = delegate
    }
    
    func readComments(postId: String) async {
        self.isLoading = true
        do {
            let data = try await delegate.readComments(postId: postId)
            self.comments = data
            self.isLoading = false
        } catch {
            isLoading = false
            print(error)
        }
    }
    
    func postComment(postId: String, comment: String) async {
        do {
            let data = try await delegate.postComment(postId: postId, comment: comment)
            self.response = data.Message
        } catch {
            print(error)
        }
    }
    
    func updateComment(postId: String, comment: String, commentId: String) async {
        do {
            let data = try await delegate.updateComment(postId: postId, comment: comment, commentId: commentId)
            self.response = data.Message
        } catch {
            print(error)
        }
    }
    
    func deleteComment(postId: String, commentId: String) async {
        do {
            let data = try await delegate.deleteComment(postId: postId, commentId: commentId)
            self.response = data.Message
        } catch {
            print(error)
        }
    }
    
    func likeComment(commentId: String) async {
        do {
            let data = try await delegate.likeComment(commentId: commentId)
            self.response = data.Message
        } catch {
            print(error)
        }
    }
    
    func unlikeComment(commentId: String) async {
        do {
            let data = try await delegate.unlikeComment(commentId: commentId)
            self.response = data.Message
        } catch {
            print(error)
        }
    }
    
   /*
    func getSelectedUserComment(id: String) async {
        do {
            let data = try await delegate.getSelectedUserComment(id: id)
            commentAvatar = data.avatar
            commentUsername = data.username
        } catch {
            print(error)
        }
    }
    */
    
    func checkIfLiked(currentUserId: String, comment: Comment) -> Bool {
        var liked: Bool = false
            comment.likes.forEach { id in
                if currentUserId == id {
                    liked = true
            }
        }
        return liked
    }
    
    
}
