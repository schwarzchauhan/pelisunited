//
//  HomeView.swift
//  pelisunited
//
//  Created by Harsh Chauhan on 12/15/25.
//

import SwiftUI

struct HomeView: View {
    let viewModel = FetchViewModel()
    @State private var titleDetailPath = NavigationPath()
                    
    var body: some View {
        NavigationStack(path: $titleDetailPath) {
            GeometryReader { geo in
                ScrollView {
                    switch viewModel.homeStatus {
                    case .notStarted:
                        EmptyView()
                    case .fetching:
                        ProgressView()
                            .frame(width: geo.size.width, height: geo.size.height)
                    case .success:
                        LazyVStack(spacing: 0) {
                            AsyncImage(url: URL(string: viewModel.heroTitle.posterPath ?? "")) { image in
                                image
                                    .resizable()
                                    .scaledToFit()
                            } placeholder: {
                                ProgressView()
                            }
                            .frame(width: geo.size.width, height: geo.size.height * 0.7)
                            .overlay {
                                LinearGradient(stops: [Gradient.Stop(color: .clear, location: 0.7),
                                                       Gradient.Stop(color: .gradient, location: 1)],
                                               startPoint: .top,
                                               endPoint: .bottom)
                            }
                            
                            
                            HStack {
                                Button {
                                    titleDetailPath.append(viewModel.heroTitle)
                                } label : {
                                    Text(HomeViewConstants.play)
                                        .playButton()
                                }
                                
                                Button {
                                    
                                } label : {
                                    Text(HomeViewConstants.download)
                                        .downloadButton()
                                }
                            }
                            .frame(maxWidth: .infinity)
                            .padding(EdgeInsets(top: 16, leading: 0, bottom: 16, trailing: 0))
                            
                            HorizontalListView(header: Constants.trendingMovies, titles: viewModel.trendingMovies)
                            HorizontalListView(header: Constants.trendingTV, titles: viewModel.trendingTV)
                            HorizontalListView(header: Constants.topRatedMovies, titles: viewModel.topRatedMovies)
                            HorizontalListView(header: Constants.topRatedTV, titles: viewModel.topRatedTV)
                        }
                        .navigationDestination(for: Title.self) { title in
                            TitleDetailView(title: title)
                        }
                        .padding(EdgeInsets(top: 0, leading: 0, bottom: 10, trailing: 0))
                        .background(Color.gray.opacity(0.3))
                    case .failed(let underlayingError):
                        Text("Error:\(underlayingError.localizedDescription)")
                    }
                }
                .task {
                    await viewModel.getTitles()
                }
            }
        }
    }
}

#Preview {
    HomeView()
}
