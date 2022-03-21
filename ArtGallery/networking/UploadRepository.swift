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
        case decodingError
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
                completion(.failure(ApiErrors.decodingError))
                    
            }
      
        }.resume()
    }
    
    func uploadUserData(newUsername: String, newEmail: String, newBio: String , newAvatar: String, completion: @escaping ((Result<Response, ApiErrors>)) -> Void)  {
        guard let url = URL(string: "https://artsketch.herokuapp.com/api/user/updateUser") else { return completion(.failure(ApiErrors.invalidURL))}
        
        var request = URLRequest(url: url)
        request.httpMethod = PUT
        request.addValue(Value, forHTTPHeaderField: Headers)
        request.addValue(token, forHTTPHeaderField: Authorization)
        request.httpBody = try? JSONEncoder().encode(UserInput(username: newUsername, email: newEmail, bio: newBio, avatar: newAvatar))
      
        URLSession.shared.dataTask(with: request) { data, response, error in
            
            guard error == nil, let data = data else { return completion(.failure(ApiErrors.invalidHTTPResponse))}
            guard let httpResponse = response as? HTTPURLResponse else { return completion(.failure(ApiErrors.invalidHTTPResponse)) }
            
            guard httpResponse.statusCode != 400 else {
                completion(.failure(ApiErrors.badRequest400))
                return
            }
            guard httpResponse.statusCode != 401 else {
                completion(.failure(ApiErrors.notAuthorized401))
                return
            }
            guard httpResponse.statusCode != 403 else {
                completion(.failure(ApiErrors.forbidden403))
                return
            }
            guard httpResponse.statusCode != 404 else {
                completion(.failure(ApiErrors.notFound404))
                return
            }
            guard httpResponse.statusCode != 500 else {
                completion(.failure(ApiErrors.internalServerError500))
                return
            }
            
            do {
                let jsonData = try JSONDecoder().decode(Response.self, from: data)
                completion(.success(jsonData))
            } catch {
                completion(.failure(ApiErrors.decodingError))
            }
            
        }.resume()
        
    }
    
    func deleteUser() async throws {
        guard let url = URL(string: "") else { throw ApiErrors.invalidURL }
        
        var request = URLRequest(url: url)
        request.httpMethod = DELETE
        request.addValue(Value, forHTTPHeaderField: Headers)
        request.addValue(token, forHTTPHeaderField: Authorization)
        
        let (_, response) = try await URLSession.shared.data(for: request)
        guard let httpResponse = response as? HTTPURLResponse else { throw ApiErrors.invalidHTTPResponse }
        guard httpResponse.statusCode != 400 else { throw ApiErrors.badRequest400 }
        guard httpResponse.statusCode != 401 else { throw ApiErrors.notAuthorized401 }
        guard httpResponse.statusCode != 403 else { throw ApiErrors.forbidden403 }
        guard httpResponse.statusCode != 404 else { throw ApiErrors.notFound404 }
        guard httpResponse.statusCode != 500 else { throw ApiErrors.internalServerError500 }
    }
    
}
