//
//  MakeProfileRequest.swift
//  ArtGallery
//
//  Created by Jaleel Gilbert on 6/27/22.
//
import Foundation

extension ProfileRepository {
    
    func makeUserRequest(param: String, method: String, token: String?, input: UserInput?) async throws -> User {
        guard let url = URL(string: BASE_URL + param) else { throw APIError.invalidURL }
        
        var request = URLRequest(url: url)
        request.httpMethod = method
        request.addValue(Value, forHTTPHeaderField: Headers)
         if let token = token {
             request.addValue(token, forHTTPHeaderField: Authorization)
         }
        
        if request.httpMethod == PUT {
            guard let input = input else {
                return User(id: "", username: "", email: "", avatar: "", bio: "", followers: [], following: [], posts: [], myPosts: [], date: "")
            }
            request.httpBody = try JSONEncoder().encode(input)
        }
        
        let (data, response) = try await URLSession.shared.data(for: request)
        guard let httpResponse = response as? HTTPURLResponse else { throw APIError.invalidHTTPResponse }
        
        guard httpResponse.statusCode < 299 else {
            switch httpResponse.statusCode {
                
            case 400:
                throw APIError.badRequest400
            case 401:
                throw APIError.notAuthorized401
            case 403:
                throw APIError.forbidden403
            case 404:
                throw APIError.notFound404
            case 500:
                throw APIError.internalServerError500
                
            default:
                print(httpResponse.statusCode)
                throw APIError.invalidHTTPResponse
                
            }
        }
     
        return try JSONDecoder().decode(User.self, from: data)
    }
    
    func makeProfileRequestVoid(param: String, method: String, token: String?, input: UserInput?) async throws {
        guard let url = URL(string: BASE_URL + param) else { throw APIError.invalidURL }
        
        var request = URLRequest(url: url)
        request.httpMethod = method
        request.addValue(Value, forHTTPHeaderField: Headers)
         if let token = token {
             request.addValue(token, forHTTPHeaderField: Authorization)
         }
        
        if request.httpMethod == PUT {
            guard let input = input else { return }
            request.httpBody = try JSONEncoder().encode(input)
        }
        
        let (_, response) = try await URLSession.shared.data(for: request)
        guard let httpResponse = response as? HTTPURLResponse else { throw APIError.invalidHTTPResponse }
        
        guard httpResponse.statusCode < 299 else {
            switch httpResponse.statusCode {
                
            case 400:
                throw APIError.badRequest400
            case 401:
                throw APIError.notAuthorized401
            case 403:
                throw APIError.forbidden403
            case 404:
                throw APIError.notFound404
            case 500:
                throw APIError.internalServerError500
                
            default:
                print(httpResponse.statusCode)
                throw APIError.invalidHTTPResponse
                
            }
        }
     
        
    }
    
}
