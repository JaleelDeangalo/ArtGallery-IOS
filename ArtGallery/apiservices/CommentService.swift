//
//  CommentService.swift
//  ArtGallery
//
//  Created by Jaleel Gilbert on 4/15/22.
//
import Foundation


protocol CommentService {
    
    func readComments(postId: String) async throws -> [Comment]
    
    func postComment(postId: String, comment: String) async throws -> Response
    
    func updateComment(postId: String, comment: String, commentId: String) async throws -> Response
    
    func deleteComment(postId: String, commentId: String) async throws -> Response
    
    func likeComment(commentId: String) async throws -> Response
    
    func unlikeComment(commentId: String) async throws -> Response
    
}
