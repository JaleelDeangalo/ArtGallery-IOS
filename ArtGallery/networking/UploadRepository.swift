//
//  UploadRepository.swift
//  ArtGallery
//
//  Created by Jaleel Gilbert on 3/1/22.
//

import Foundation
import SwiftUI

struct UploadRepository {

    @AppStorage("token") var token = ""
    static let shared = UploadRepository()
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
    
    
    func uploadImage(newImage: String?, newPostDescription: String?, newTitle: String?, completion: @escaping ((Result<Response, Error>) -> Void)) {
        
        guard let url = URL(string: BASE_URL + "/post") else { return }
        
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = POST
        urlRequest.addValue(Value, forHTTPHeaderField: Headers)
        urlRequest.httpBody = try? JSONEncoder().encode(PostInput(newImage: newImage, newPostDescription: newPostDescription, newTitle: newTitle))
        
        
        URLSession.shared.dataTask(with: urlRequest) { data, response, error in
            
      
        }.resume()
    }
    
    func uploadImage(newImage: String?, newPostDescription: String?, newTitle: String?) async throws -> Response {
        guard let url = URL(string: BASE_URL + "/post") else { throw ApiErrors.invalidURL }
        
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = POST
        urlRequest.addValue(Value, forHTTPHeaderField: Headers)
        urlRequest.httpBody = try JSONEncoder().encode(PostInput(newImage: newImage, newPostDescription: newPostDescription, newTitle: newTitle))
        
        let (data, response) = try await URLSession.shared.data(for: urlRequest)
        guard let httpResponse = response as? HTTPURLResponse else { throw ApiErrors.invalidHTTPResponse }
        guard httpResponse.statusCode != 400 else { throw ApiErrors.badRequest400 }
        guard httpResponse.statusCode != 401 else { throw ApiErrors.notAuthorized401 }
        guard httpResponse.statusCode != 403 else { throw ApiErrors.forbidden403 }
        guard httpResponse.statusCode != 404 else { throw ApiErrors.notFound404 }
        guard httpResponse.statusCode != 500 else { throw ApiErrors.internalServerError500 }
        return try JSONDecoder().decode(Response.self, from: data)
    }
    
}
