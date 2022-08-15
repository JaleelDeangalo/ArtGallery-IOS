//
//  Constants.swift
//  ArtGallery
//
//  Created by Jaleel Gilbert on 3/1/22.
//
import Foundation

let BASE_URL = "https://artsketch.herokuapp.com/api/"
let GET = "GET"
let POST = "POST"
let PUT = "PUT"
let DELETE = "DELETE"
let Value = "application/json"
let Headers = "Content-Type"
let Authorization = "Authorization"


public enum APIError: Error {
    case invalidURL
    case invalidHTTPResponse
    case badRequest400
    case notAuthorized401
    case forbidden403
    case notFound404
    case internalServerError500
    case decodingError
    case encodingError
}
