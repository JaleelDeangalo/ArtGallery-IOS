//
//  MakeFeedRequest.swift
//  ArtGallery
//
//  Created by Jaleel Gilbert on 6/27/22.
//
import Foundation
import SwiftUI


extension FeedRepository {
    
    func makeFeedRequest(param: String, method: String, token: String?) async throws -> [Post] {
     
        guard let url = URL(string: BASE_URL + param) else { throw APIError.invalidURL }

            
            var request = URLRequest(url: url)
            request.httpMethod = method
            request.addValue(Value, forHTTPHeaderField: Headers)
            if let token = token {
                request.addValue(token, forHTTPHeaderField: Authorization)
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
            
            return try JSONDecoder().decode([Post].self, from: data)
        
    }
    
    
    func toggleLikes(param: String, method: String, token: String?) async throws {
        
               guard let url = URL(string: BASE_URL + param) else { throw APIError.invalidURL }
               
               var request = URLRequest(url: url)
               request.httpMethod = method
               request.addValue(Value, forHTTPHeaderField: Headers)
                if let token = token {
                    request.addValue(token, forHTTPHeaderField: Authorization)
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
    
    
    func toggleFollow(param: String, method: String, token: String?) async throws {
        
        guard let url = URL(string: BASE_URL + param) else { throw APIError.invalidURL }
        
        var request = URLRequest(url: url)
        request.httpMethod = method
        request.addValue(Value, forHTTPHeaderField: Headers)
         if let token = token {
             request.addValue(token, forHTTPHeaderField: Authorization)
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
