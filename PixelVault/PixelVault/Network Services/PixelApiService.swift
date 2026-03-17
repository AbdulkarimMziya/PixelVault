//
//  PixelApiService.swift
//  PixelVault
//
//  Created by Abdulkarim Mziya on 2026-03-17.
//

import Foundation

class PixelApiService {
    
    enum HTTTPMethod: String {
        case get = "GET"
    }
    
    private func makeURL(searchQuery: String) -> URL? {
        var components = URLComponents()
        components.scheme = "https"
        components.host = "pixabay.com"
        components.path = "/api/"
        
        components.queryItems = [
            URLQueryItem(name: "key", value: Secret.ApiKey),
            URLQueryItem(name: "q", value: searchQuery),
            URLQueryItem(name: "orientation", value: "vertical")
        ]
        
        return components.url
    }
    
    
    func fetchAllPosts(with searchQuery: String?) async throws -> PixelAPIModel {
        guard let query = searchQuery else {
            throw AppError.noSearchQuery
        }
        
        guard let url = makeURL(searchQuery: query) else {
            throw AppError.invalidURL("Invalid url")
        }
        
        let request = URLRequest(url: url)
        
        let data = try await NetworkHelper.shared.performTask(urlRequest: request)
        
        do {
            let decoder = JSONDecoder()
            return try decoder.decode(PixelAPIModel.self, from: data)
        } catch {
            throw AppError.decodingError(error)
        }
    }
}

