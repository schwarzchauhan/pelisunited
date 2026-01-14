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
        
        do {  
            trendingMovies = try await dataFetcher.fetchTitle(for: "movie", by: "trending")
            trendingTV = try await dataFetcher.fetchTitle(for: "tv", by: "trending")
            
            topRatedMovies = try await dataFetcher.fetchTitle(for: "movie", by: "top_rated")
            topRatedTV = try await dataFetcher.fetchTitle(for: "tv", by: "top_rated")
            
            homeStatus = .success
        } catch {
            print(error)
            homeStatus = .failed(underlayingError: error)
        }
    }
}
