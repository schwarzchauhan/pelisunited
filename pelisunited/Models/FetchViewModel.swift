//
//  FetchViewModel.swift
//  pelisunited
//
//  Created by Harsh Chauhan on 1/10/26.
//

import Foundation



@Observable
class FetchViewModel {
    enum FetchStatus {
        case notStarted
        case fetching
        case success
        case failed(underlayingError: Error)
    }
    private(set) var homeStatus: FetchStatus = .notStarted
    private let dataFetcher = DataFetcher()
    var trendingMovies: [Title] = []
    var trendingTV: [Title] = []
    var topRatedMovies: [Title] = []
    var topRatedTV: [Title] = []
    
    func getTitles() async {
        homeStatus = .fetching
        
//        if trendingMovies.isEmpty, trendingTV.isEmpty, topRatedTV.isEmpty, topRatedMovies.isEmpty {
//            
//        }
        
        if trendingMovies.isEmpty {
            do {
                async let tMovies = try await dataFetcher.fetchTitle(for: "movie", by: "trending")
                async let tTV = try await dataFetcher.fetchTitle(for: "tv", by: "trending")
                async let tRMovies = try await dataFetcher.fetchTitle(for: "movie", by: "top_rated")
                async let tRTV = try await dataFetcher.fetchTitle(for: "tv", by: "top_rated")
                
                trendingMovies = try await tMovies
                trendingTV = try await tTV
                topRatedMovies = try await tRMovies
                topRatedTV = try await tRTV
                
                homeStatus = .success
            } catch {
                print(error)
                homeStatus = .failed(underlayingError: error)
            }
        }
        
        
    }
}
