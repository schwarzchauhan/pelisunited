//
//  HorizontalListView.swift
//  pelisunited
//
//  Created by Harsh Chauhan on 12/15/25.
//

import SwiftUI

struct HorizontalListView: View{
    let header: String
    let titles = [ConstantsUrl.testTitleUrl, ConstantsUrl.testTitleUrl2, ConstantsUrl.testTitleUrl3]
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            Text(header)
                .titleText()
            ScrollView(.horizontal) {
                LazyHStack(spacing: 20) {
                    ForEach(titles, id: \.self) { title in
                        AsyncImage(url: URL(string: title)) { image in
                            image
                                .standardImage()
                        } placeholder: {
                            ProgressView()
                        }
                        .frame(width: 200, height: 200)
                    }
                }
            }
        }
        .frame(height: 250)
        .padding(EdgeInsets(top: 0, leading: 16, bottom: 0, trailing: 16))
    }
}

#Preview {
    HorizontalListView(header: Constants.trendingMovies)
}
