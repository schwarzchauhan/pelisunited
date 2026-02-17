//
//  TitleDetailView.swift
//  pelisunited
//
//  Created by Harsh Chauhan on 1/14/26.
//

import SwiftUI

struct TitleDetailView: View {
    var title: Title
    
    var body: some View {
        GeometryReader { geometry in
            ScrollView {
                LazyVStack(alignment: .leading) {
                    //                    YouTubePlayer(videoId: "9wv8_n-VuOc")
                    YouTubePlayer(videoId: "dQw4w9WgXcQ")
                        .aspectRatio(1.3, contentMode: .fit)
                        .frame(width: geometry.size.width, height: geometry.size.height * 0.85)
                    
                    Text(title.name ?? title.title ?? "")
                        .bold()
                        .font(.title2)
                        .padding(5)
                    
                    Text(title.overview)
                        .padding(5)
                }
            }
        }
    }
}

#Preview {
    TitleDetailView(title: Title.previewTitles[0])
}
