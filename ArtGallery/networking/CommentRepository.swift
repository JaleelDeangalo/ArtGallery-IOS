//
//  CommentRepository.swift
//  ArtGallery
//
//  Created by Jaleel Gilbert on 3/1/22.
//

import Foundation
import SwiftUI

struct CommentRepository {
    
    @AppStorage("token") var token = ""
    private init() {}
    static let shared = CommentRepository()
    
    enum ApiErrors: Error {
        case invalidURL
        case invalidHTTPResponse
        case badRequest400
        case notAuthorized401
        case forbidden403
        case notFound404
        case internalServerError500
    }
    
    func readComments(postId: String) async throws -> [Comment] {
        guard let url = URL(string: BASE_URL + "/comments/\(postId)") else { throw ApiErrors.invalidURL }
        
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = GET
        urlRequest.addValue(Value, forHTTPHeaderField: Headers)
        urlRequest.addValue(token, forHTTPHeaderField: Authorization)
        
        let (data, response) = try await URLSession.shared.data(for: urlRequest)
        
        guard let httpResponse = response as? HTTPURLResponse else { throw ApiErrors.invalidHTTPResponse }
        guard httpResponse.statusCode != 400 else { throw ApiErrors.badRequest400 }
        guard httpResponse.statusCode != 401 else { throw ApiErrors.notAuthorized401 }
        guard httpResponse.statusCode != 403 else { throw ApiErrors.forbidden403 }
        guard httpResponse.statusCode != 404 else { throw ApiErrors.notFound404 }
        guard httpResponse.statusCode != 500 else { throw ApiErrors.internalServerError500 }
        
        return try JSONDecoder().decode([Comment].self, from: data)
    }
    
    
    func postComment(postId: String) async throws -> Response {
        guard let url = URL(string: BASE_URL + "/comments/\(postId)") else { throw ApiErrors.invalidURL }
        
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = POST
        urlRequest.addValue(Value, forHTTPHeaderField: Headers)
        urlRequest.addValue(token, forHTTPHeaderField: Authorization)
        
        let (data, response) = try await URLSession.shared.data(for: urlRequest)
        
        guard let httpResponse = response as? HTTPURLResponse else { throw ApiErrors.invalidHTTPResponse }
        guard httpResponse.statusCode != 400 else { throw ApiErrors.badRequest400 }
        guard httpResponse.statusCode != 401 else { throw ApiErrors.notAuthorized401 }
        guard httpResponse.statusCode != 403 else { throw ApiErrors.forbidden403 }
        guard httpResponse.statusCode != 404 else { throw ApiErrors.notFound404 }
        guard httpResponse.statusCode != 500 else { throw ApiErrors.internalServerError500 }
        
        return try JSONDecoder().decode(Response.self, from: data)
    }
    
    
    func updateComment(postId: String) async throws -> Response {
        guard let url = URL(string: BASE_URL + "/comments/\(postId)") else { throw ApiErrors.invalidURL }
        
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = PUT
        urlRequest.addValue(Value, forHTTPHeaderField: Headers)
        urlRequest.addValue(token, forHTTPHeaderField: Authorization)
        
        let (data, response) = try await URLSession.shared.data(for: urlRequest)
        
        guard let httpResponse = response as? HTTPURLResponse else { throw ApiErrors.invalidHTTPResponse }
        guard httpResponse.statusCode != 400 else { throw ApiErrors.badRequest400 }
        guard httpResponse.statusCode != 401 else { throw ApiErrors.notAuthorized401 }
        guard httpResponse.statusCode != 403 else { throw ApiErrors.forbidden403 }
        guard httpResponse.statusCode != 404 else { throw ApiErrors.notFound404 }
        guard httpResponse.statusCode != 500 else { throw ApiErrors.internalServerError500 }
        
        return try JSONDecoder().decode(Response.self, from: data)
    }
    
    
    func deleteComment(postId: String) async throws -> Response {
        guard let url = URL(string: BASE_URL + "/comments/\(postId)") else { throw ApiErrors.invalidURL }
        
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = DELETE
        urlRequest.addValue(Value, forHTTPHeaderField: Headers)
        urlRequest.addValue(token, forHTTPHeaderField: Authorization)
        
        let (data, response) = try await URLSession.shared.data(for: urlRequest)
        
        guard let httpResponse = response as? HTTPURLResponse else { throw ApiErrors.invalidHTTPResponse }
        guard httpResponse.statusCode != 400 else { throw ApiErrors.badRequest400 }
        guard httpResponse.statusCode != 401 else { throw ApiErrors.notAuthorized401 }
        guard httpResponse.statusCode != 403 else { throw ApiErrors.forbidden403 }
        guard httpResponse.statusCode != 404 else { throw ApiErrors.notFound404 }
        guard httpResponse.statusCode != 500 else { throw ApiErrors.internalServerError500 }
        
        return try JSONDecoder().decode(Response.self, from: data)
    }
    
    func likeComment() async throws {
        
    }
    
    func unlikeComment() async throws {
        
    }
    
}
