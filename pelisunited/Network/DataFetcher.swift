//
//  DataFetcher.swift
//  pelisunited
//
//  Created by Harsh Chauhan on 12/25/25.
//

import Foundation

struct DataFetcher {
    let tmdbBaseURL = APIConfig.shared?.tmdbBaseURL
    let tmdbAPIKey =  APIConfig.shared?.tmdbAPIKey
    
    // https://api.themoviedb.org/3/trending/movie/day?api_key=<API_KEY>
    // https://api.themoviedb.org/3/movie/top_rated?api_key=<API_KEY>
    
    func fetchTitle(for media: String, by type: String) async throws -> [Title] {
        
        guard let fetchTitleURL = try? buildURL(media: media, type: type) else {
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
        var titles = try decoder.decode(APIObject.self, from: data).results
        ConstantsUrl.addPosterPath(to: &titles)
        return titles
        
    }
    
    private func buildURL(media: String, type: String) throws -> URL? {
        guard let baseURL = tmdbBaseURL else {
            throw NetworkError.missinConfig
        }
        guard let apiKey = tmdbAPIKey else {
            throw NetworkError.missinConfig
        }
        
        var path: String
        
        if type == "trending" {
            path = "3/trending/\(media)/day"
        } else if type == "top_rated" {
            path = "3/\(media)/top_rated"
        } else {
            throw NetworkError.urlBuildFailed
        }
        
        guard let fetchTitleURL = tmdbBaseURL?
            .appending(path: path)
            .appending(queryItems: [
                URLQueryItem(name: "api_key", value: apiKey)
            ]) else {
            throw NetworkError.urlBuildFailed
        }
        
        return fetchTitleURL
    }
}
