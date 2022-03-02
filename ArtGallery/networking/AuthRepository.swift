//
//  AuthRepository.swift
//  ArtGallery
//
//  Created by Jaleel Gilbert on 3/1/22.
//

import Foundation
import SwiftUI

struct AuthRepository {
    
    static let shared = AuthRepository()
    private init() {}
    
    enum ApiErrors: Error {
        case invalidURL
        case invalidHTTPResponse
        case badRequest400
        case notAuthorized401
        case forbidden403
        case notFound404
        case internalServerError500
    }
    
    func login(email: String, password: String) async throws -> Token {
        guard let url = URL(string: BASE_URL + "/login") else { throw ApiErrors.invalidURL }
        
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = POST
        urlRequest.addValue(Value, forHTTPHeaderField: Headers)
        urlRequest.httpBody = try JSONEncoder().encode(LoginInput(email: email, password: password))
        
        let (data, response) = try await URLSession.shared.data(for: urlRequest)
        guard let httpResponse = response as? HTTPURLResponse else { throw ApiErrors.invalidHTTPResponse }
        guard httpResponse.statusCode != 400 else { throw ApiErrors.badRequest400 }
        guard httpResponse.statusCode != 401 else { throw ApiErrors.notAuthorized401 }
        guard httpResponse.statusCode != 403 else { throw ApiErrors.forbidden403 }
        guard httpResponse.statusCode != 404 else { throw ApiErrors.notFound404 }
        guard httpResponse.statusCode != 500 else { throw ApiErrors.internalServerError500 }
        
        return try JSONDecoder().decode(Token.self, from: data)
    }
    
    func signup(username: String, email: String, password: String) async throws -> Token {
        guard let url = URL(string: BASE_URL + "/signup") else { throw ApiErrors.invalidURL }
        
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = POST
        urlRequest.addValue(Value, forHTTPHeaderField: Headers)
        urlRequest.httpBody = try JSONEncoder().encode(SignupInput(username: username, email: email, password: password))
        
        let (data, response) = try await URLSession.shared.data(for: urlRequest)
        guard let httpResponse = response as? HTTPURLResponse else { throw ApiErrors.invalidHTTPResponse }
        guard httpResponse.statusCode != 400 else { throw ApiErrors.badRequest400 }
        guard httpResponse.statusCode != 401 else { throw ApiErrors.notAuthorized401 }
        guard httpResponse.statusCode != 403 else { throw ApiErrors.forbidden403 }
        guard httpResponse.statusCode != 404 else { throw ApiErrors.notFound404 }
        guard httpResponse.statusCode != 500 else { throw ApiErrors.internalServerError500 }
        
        return try JSONDecoder().decode(Token.self, from: data)
    }
    
}
