//
//  DataFetcher.swift
//  pelisunited
//
//  Created by Harsh Chauhan on 12/25/25.
//

import Foundation

struct DataFetcher {
    let tmdbBaseURL = APIConfig.shared?.tmdbAPIKey
    let tmdbAPIKey =  APIConfig.shared?.tmdbAPIKey
    
    func fetchTitle(for media: String) async throws -> [Title] {
        guard let baseURL = tmdbAPIKey else {
            throw NetworkError.missinConfig
        }
        guard let apiKey = tmdbAPIKey else {
            throw NetworkError.missinConfig
        }
        guard let fetchTitleURL = URL(string: baseURL)?
            .appending(path: "3/trending/\(media)/day")
            .appending(queryItems: [
                URLQueryItem(name: "api_key", value: apiKey)
            ]) else {
            throw NetworkError.urlBuildFailed
        }
        
        print(fetchTitleURL)
        
        let (data, urlResponse) = try await URLSession.shared.data(from: fetchTitleURL)
        
        guard let response = urlResponse as? HTTPURLResponse, response.statusCode == 200 else {
            throw NetworkError.badURLResponse(underlyingError: NSError(
                domain: "DataFetcher",
                code: (urlResponse as? HTTPURLResponse)?.statusCode ?? -1,
                userInfo: [NSLocalizedDescriptionKey: "Invalid HTTP Response"]
            ))
        }
        
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        var titles =   try decoder.decode(APIObject.self, from: data).results
        ConstantsUrl.addPosterPath(to: &titles)
        return titles
        
    }
}
