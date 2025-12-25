//
//  ContentView.swift
//  pelisunited
//
//  Created by Harsh Chauhan on 12/14/25.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        TabView {
            Tab(Constants.home, systemImage: SystemImageConstants.house) {
                HomeView()
            }
            Tab(Constants.upcoming, systemImage: SystemImageConstants.upcoming) {
                Text(Constants.upcoming)
            }
            Tab(Constants.search, systemImage: SystemImageConstants.search) {
                Text(Constants.search)
            }
            Tab(Constants.download, systemImage: SystemImageConstants.download) {
                Text(Constants.download)
            }
        }
        .onAppear {
            if let apiConfig = APIConfig.shared {
                print(apiConfig.tmdbBaseURL)
                print(apiConfig.tmdbAPIKey)
            }
        }
    }
}

#Preview {
    ContentView()
}
