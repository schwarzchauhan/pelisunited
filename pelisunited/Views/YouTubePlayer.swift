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
    let videoId: String
    let youtubeBaseURL: String? = APIConfig.shared?.youtubeBaseURL
    
    func makeUIView(context: Context) -> WKWebView {
        // 1. Create a configuration
        let configuration = WKWebViewConfiguration()
        configuration.allowsInlineMediaPlayback = true // Vital for iOS
        configuration.mediaTypesRequiringUserActionForPlayback = []
        
        // 2. Init webView with configuration
        let webView = WKWebView(frame: .zero, configuration: configuration)
        return webView
    }
    
//    func updateUIView(_ uiView: UIViewType, context: Context) {
//        guard let baseURLString = youtubeBaseURL else { return }
//        
//        let videoID = videoId
//        print("\(baseURLString)\(videoID)")
//
//        let html = """
//        <!DOCTYPE html>
//        <html>
//        <head>
//        <meta name="viewport" content="width=device-width, initial-scale=1.0">
//        <style>
//        body {
//            margin: 0;
//            padding: 0;
//        }
//        iframe {
//            position: absolute;
//            top: 0;
//            left: 0;
//            width: 100%;
//            height: 100%;
//        }
//        </style>
//        </head>
//        <body>
//        <iframe
//            src="\(baseURLString)\(videoID)?playsinline=1&enablejsapi=1"
//            frameborder="0"
//            allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture"
//            allowfullscreen>
//        </iframe>
//        </body>
//        </html>
//        """
//
//        uiView.loadHTMLString(html, baseURL: URL(string: "https://www.youtube.com"))
//    }
    
    func updateUIView(_ uiView: WKWebView, context: Context) {
        guard let baseURLString = youtubeBaseURL else { return }
        
        // 1. Construct the full URL string
        let fullURLString = "\(baseURLString)\(videoId)?playsinline=1&enablejsapi=1"
        
        // 2. Ensure it's a valid URL
        guard let url = URL(string: fullURLString) else { return }
        print(url)
        // 3. Check if we are already loading this video to prevent infinite reloads
        if uiView.url?.absoluteString == url.absoluteString {
            return
        }
        
        // 4. Load the request directly
        let request = URLRequest(url: url)
        uiView.load(request)
    }
    
    
}
