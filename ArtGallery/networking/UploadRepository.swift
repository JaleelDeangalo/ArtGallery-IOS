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
    
    func uploadImage(newImage: String, newPostDescription: String, newTitle: String, completion: @escaping ((Result<Response, ApiErrors>) -> Void )) {
        
        guard let url = URL(string: BASE_URL + "/post") else {
            completion(.failure(ApiErrors.invalidURL))
            return }
        
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = POST
        urlRequest.addValue(Value, forHTTPHeaderField: Headers)
        urlRequest.addValue(token, forHTTPHeaderField: Authorization)
        urlRequest.httpBody = try? JSONEncoder().encode(PostInput(image: newImage, description: newPostDescription, details: newTitle))
        
        
        URLSession.shared.dataTask(with: urlRequest) { data, response, error in
            guard error == nil else { return }
            guard let data = data else { return }
            guard let httpReponse = response as? HTTPURLResponse else { return }
            guard httpReponse.statusCode != 400 else {
                completion(.failure(ApiErrors.badRequest400))
                return
            }
            guard httpReponse.statusCode != 401 else {
                completion(.failure(ApiErrors.notAuthorized401))
                return
            }
            guard httpReponse.statusCode != 403 else {
                completion(.failure(ApiErrors.forbidden403))
                return
            }
            
            guard httpReponse.statusCode != 404 else {
                completion(.failure(ApiErrors.notFound404))
                return
            }
            
            guard httpReponse.statusCode != 500 else {
                completion(.failure(ApiErrors.internalServerError500))
                return
            }
            
            do {
                let data = try JSONDecoder().decode(Response.self, from: data)
                completion(.success(data))
            } catch {
                completion(.failure(ApiErrors.internalServerError500))
                    
            }
      
        }.resume()
    }
    
}
