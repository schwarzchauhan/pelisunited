//
//  DataFetcher.swift
//  pelisunited
//
//  Created by Harsh Chauhan on 12/25/25.
//

import Foundation

let tmdbBaseURL = APIConfig.shared?.tmdbAPIKey
let tmdbAPIKey =  APIConfig.shared?.tmdbAPIKey

func fetchTitle(for media: String) async throws -> [Title] {
    guard let baseURL = tmdbAPIKey else {
        throw NetworkError.missinConfig
    }
    guard let apiKey = tmdbAPIKey else {
        throw NetworkError.missinConfig
    }
    let fetchTitleURL = URL(string: baseURL)?
        .appending(path: "3/trending/\(media)/day")
        .appending(queryItems: [
            URLQueryItem(name: "api_key", value: apiKey)
        ])
    
    return []
}
