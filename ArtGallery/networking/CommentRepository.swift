//
//  CommentRepository.swift
//  ArtGallery
//
//  Created by Jaleel Gilbert on 3/1/22.
//
import Foundation
import SwiftUI

struct CommentRepository: CommentService {
    
    @AppStorage("token") var token = ""
    
    func readComments(postId: String) async throws -> [Comment] {
        return try await makeCommentRequest(param: "comments/readComment/\(postId)", method: GET, token: token, input: nil)
    }
    
    
    func postComment(postId: String, comment: String) async throws -> Response {
        return try await makeCommentRequestResponse(param: "comments/postComment/\(postId)", method: POST, token: token, input: CommentInput(comment: comment), updating: true)
    }
    
    
    func updateComment(postId: String, comment: String, commentId: String) async throws -> Response {
        return try await makeCommentRequestResponse(param: "comments/updateComment/\(postId)", method: PUT, token: token, input: CommentInput(comment: comment), updating: true)
    }
    
    
    func deleteComment(postId: String, commentId: String) async throws -> Response {
        return try await makeCommentRequestResponse(param: "comments/deleteComment/\(postId)", method: DELETE, token: token, input: nil, updating: false)
    }
    
    func likeComment(commentId: String) async throws -> Response {
        return try await makeCommentRequestResponse(param: "comments/like/\(commentId)", method: PUT, token: token, input: nil, updating: false)
    }
    
    func unlikeComment(commentId: String) async throws -> Response {
        return try await makeCommentRequestResponse(param: "comments/unlike/\(commentId)" , method: PUT, token: token, input: nil, updating: false)
    }
    
    func getSelectedUserComment(id: String) async throws -> User {
        
        guard let url = URL(string: BASE_URL + "user/getUser/\(id)") else { throw APIError.invalidURL }
        
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = GET
        urlRequest.addValue(Value, forHTTPHeaderField: Headers)
        urlRequest.addValue(token, forHTTPHeaderField: Authorization)
        
        let (data, response) = try await URLSession.shared.data(for: urlRequest)
        guard let httpResponse = response as? HTTPURLResponse else { throw APIError.invalidHTTPResponse }
        guard httpResponse.statusCode != 400 else { throw APIError.badRequest400 }
        guard httpResponse.statusCode != 401 else { throw APIError.notAuthorized401 }
        guard httpResponse.statusCode != 403 else { throw APIError.forbidden403 }
        guard httpResponse.statusCode != 404 else { throw APIError.notFound404 }
        guard httpResponse.statusCode != 500 else { throw APIError.internalServerError500 }
        return try JSONDecoder().decode(User.self, from: data)
    }
    
}
