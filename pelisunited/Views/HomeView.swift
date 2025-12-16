//
//  HomeView.swift
//  pelisunited
//
//  Created by Harsh Chauhan on 12/15/25.
//

import SwiftUI

struct HomView: View {
    var heroTestTitle = ConstantsUrl.testTitleUrl
                    
    var body: some View {
        GeometryReader { geo in
            ScrollView {
                LazyVStack(spacing: 0) {
                    AsyncImage(url: URL(string: heroTestTitle)) { image in
                        image
                            .resizable()
                            .scaledToFit()
                    } placeholder: {
                        ProgressView()
                    }
                    .frame(width: geo.size.width, height: geo.size.height * 0.7)
                    .background(.orange)
                    
                    HStack {
                        Button {
                            
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
                    
                    HorizontalListView(header: Constants.trendingMovies)
                    HorizontalListView(header: Constants.trendingTV)
                    HorizontalListView(header: Constants.topRatedMovies)
                    HorizontalListView(header: Constants.topRatedTV)
                }
                .padding(EdgeInsets(top: 0, leading: 0, bottom: 10, trailing: 0))
                .background(Color.gray.opacity(0.3))
            }
        }
    }
}

#Preview {
    HomView()
}
