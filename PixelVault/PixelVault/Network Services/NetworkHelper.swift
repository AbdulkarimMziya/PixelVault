//
//  NetworkHelper.swift
//  PixelVault
//
//  Created by Abdulkarim Mziya on 2026-03-17.
//

import Foundation

class NetworkHelper {
    
    static let shared = NetworkHelper()
    
    private var session: URLSession
    
    private init() {
        session = URLSession(configuration: .default)
    }
    
    func performTask(urlRequest: URLRequest) async throws -> Data {
        let (data,response) = try await session.data(for: urlRequest)
        
        guard let httpResponse = response as? HTTPURLResponse else {
            throw AppError.noResponse
        }
        
        guard (200...299).contains(httpResponse.statusCode) else {
            throw AppError.badStatusCode(httpResponse.statusCode.description)
        }
        
        return data
    }
}
