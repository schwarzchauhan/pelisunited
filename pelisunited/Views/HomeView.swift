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
        VStack(spacing: 0) {
            AsyncImage(url: URL(string: heroTestTitle)) { image in
                image
                    .resizable()
                    .scaledToFit()
            } placeholder: {
                ProgressView()
            }
            
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
        }
        .padding(EdgeInsets(top: 0, leading: 0, bottom: 10, trailing: 0))
        .background(Color.gray.opacity(0.3))
    }
}

#Preview {
    HomView()
}
