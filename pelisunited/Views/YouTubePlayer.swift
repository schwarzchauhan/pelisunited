//
//  YouTubePlayer.swift
//  pelisunited
//
//  Created by Harsh Chauhan on 2/4/26.
//

import SwiftUI
import WebKit
import Foundation


struct YouTubePlayer: UIViewRepresentable {
    let webView = WKWebView()
    let videoId: String
    let youtubeBaseURL: String? = APIConfig.shared?.youtubeBaseURL
    
    func makeUIView(context: Context) -> some UIView {
        webView
    }
    
    func updateUIView(_ uiView: UIViewType, context: Context) {
        guard let baseURLString = youtubeBaseURL,
              let baseURL = URL(string: baseURLString) else { return }
//        let fullURL = baseURL.appending(path: videoId)
//        print(fullURL)
        
        let videoID = "videoId"

        let html = """
        <!DOCTYPE html>
        <html>
        <head>
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <style>
        body {
            margin: 0;
            padding: 0;
        }
        iframe {
            position: absolute;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
        }
        </style>
        </head>
        <body>
        <iframe
            src="https://www.youtube.com/embed/\(videoID)?playsinline=1"
            frameborder="0"
            allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture"
            allowfullscreen>
        </iframe>
        </body>
        </html>
        """

        webView.loadHTMLString(html, baseURL: nil)

//        webView.load(URLRequest(url: fullURL))
    }
}
