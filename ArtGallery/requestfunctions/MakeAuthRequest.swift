//
//  MakeAuthRequest.swift
//  ArtGallery
//
//  Created by Jaleel Gilbert on 6/27/22.
//
import Foundation

extension AuthRepository {
    
    
    func makeAuthRequest(param: String, method: String, token: String?, input: AuthInput) async throws -> Token {
        
        guard let url = URL(string: BASE_URL + param) else { throw APIError.invalidURL }
        
        var request = URLRequest(url: url)
        request.httpMethod = method
        request.addValue(Value, forHTTPHeaderField: Headers)
        request.httpBody = try JSONEncoder().encode(input)
        
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
        
        return try JSONDecoder().decode(Token.self, from: data)
    }
}
