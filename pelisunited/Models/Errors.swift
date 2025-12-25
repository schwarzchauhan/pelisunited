//
//  Errors.swift
//  pelisunited
//
//  Created by Harsh Chauhan on 12/22/25.
//

import Foundation

enum APIConfigError: Error, LocalizedError {
    case failedNotFound
    case dataLoadingFailed(underlyingError: Error)
    case decodingFailed(underlyingError: Error)
    
    var errorDescription: String? {
        switch self {
        case .failedNotFound:
            return "Data not found"
        case .dataLoadingFailed(underlyingError: let error):
            return "Failed to load data: \(error.localizedDescription)"
        case .decodingFailed(underlyingError: let error):
            return "Failed to decode data: \(error.localizedDescription)"
        }
    }
}

enum NetworkError: Error, LocalizedError {
    case badURLResponse(underlyingError: Error)
    case missinConfig
    
    var errorDescription: String? {
        switch self {
        case .badURLResponse(let underlyingError):
            return "Failed to parse URL response: \(underlyingError.localizedDescription)"
        case .missinConfig:
            return "Missing API configuration..."
        }
    }
}
