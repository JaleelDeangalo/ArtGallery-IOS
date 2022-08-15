//
//  UploadRepository.swift
//  ArtGallery
//
//  Created by Jaleel Gilbert on 3/1/22.
//
import Foundation
import SwiftUI

struct UploadRepository: UploadService {
    
    @AppStorage("token") public var token = ""
    
    func uploadImage(image: String, description: String, title: String, completion: @escaping (Result<Response, APIError>) -> ()) {
    
        
        guard let url = URL(string: BASE_URL + "post") else {
            completion(.failure(APIError.invalidURL))
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = POST
        request.addValue(Value, forHTTPHeaderField: Headers)
        request.addValue(token, forHTTPHeaderField: Authorization)
        
        do {
            request.httpBody = try JSONEncoder().encode(PostInput(description: description, image: image, details: title))
        } catch {
            completion(.failure(APIError.encodingError))
        }
        
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            guard error == nil, let data = data else{ return }
            guard let httpResponse = response as? HTTPURLResponse else {
                completion(.failure(APIError.invalidHTTPResponse))
                return
            }
            
            guard httpResponse.statusCode != 400 else {
                completion(.failure(APIError.badRequest400))
                return
            }
            guard httpResponse.statusCode != 401 else {
                completion(.failure(APIError.notAuthorized401))
                return
            }
            guard httpResponse.statusCode != 403 else {
                completion(.failure(APIError.forbidden403))
                return
            }
            
            guard httpResponse.statusCode != 404 else {
                completion(.failure(APIError.notFound404))
                return
            }
            
            guard httpResponse.statusCode != 500 else {
                completion(.failure(APIError.internalServerError500))
                return
            }
            
            do {
                let data = try JSONDecoder().decode(Response.self, from: data)
                completion(.success(data))
            } catch {
                completion(.failure(APIError.decodingError))
                    
            }
      
        }.resume()
    }
    
    func uploadUserData(newUsername: String, newEmail: String, newBio: String, newAvatar: String, completion: @escaping (Result<Response, APIError>) -> ()) {
        guard let url = URL(string: BASE_URL + "user/updateUser") else { return completion(.failure(APIError.invalidURL))}
        
        var request = URLRequest(url: url)
        request.httpMethod = PUT
        request.addValue(Value, forHTTPHeaderField: Headers)
        request.addValue(token, forHTTPHeaderField: Authorization)
        do {
            request.httpBody = try JSONEncoder().encode(UserInput(username: newUsername, email: newEmail, bio: newBio, avatar: newAvatar))
        } catch {
            completion(.failure(APIError.encodingError))
        }
      
        URLSession.shared.dataTask(with: request) { data, response, error in
            
            guard error == nil, let data = data else { return completion(.failure(APIError.invalidHTTPResponse)) }
            guard let httpResponse = response as? HTTPURLResponse else { return completion(.failure(APIError.invalidHTTPResponse)) }
            
            guard httpResponse.statusCode != 400 else {
                completion(.failure(APIError.badRequest400))
                return
            }
            guard httpResponse.statusCode != 401 else {
                completion(.failure(APIError.notAuthorized401))
                return
            }
            guard httpResponse.statusCode != 403 else {
                completion(.failure(APIError.forbidden403))
                return
            }
            guard httpResponse.statusCode != 404 else {
                completion(.failure(APIError.notFound404))
                return
            }
            guard httpResponse.statusCode != 500 else {
                completion(.failure(APIError.internalServerError500))
                return
            }
            
            do {
                let jsonData = try JSONDecoder().decode(Response.self, from: data)
                completion(.success(jsonData))
            } catch {
                completion(.failure(APIError.decodingError))
            }
            
        }.resume()
        
    }
    
    
    func deleteUser() async throws {
        guard let url = URL(string: BASE_URL) else { throw APIError.invalidURL }
        
        var request = URLRequest(url: url)
        request.httpMethod = DELETE
        request.addValue(Value, forHTTPHeaderField: Headers)
        request.addValue(token, forHTTPHeaderField: Authorization)
        
        let (_, response) = try await URLSession.shared.data(for: request)
        guard let httpResponse = response as? HTTPURLResponse else { throw APIError.invalidHTTPResponse }
        guard httpResponse.statusCode != 400 else { throw APIError.badRequest400 }
        guard httpResponse.statusCode != 401 else { throw APIError.notAuthorized401 }
        guard httpResponse.statusCode != 403 else { throw APIError.forbidden403 }
        guard httpResponse.statusCode != 404 else { throw APIError.notFound404 }
        guard httpResponse.statusCode != 500 else { throw APIError.internalServerError500 }
    }
    
}
