//
//  ComputedAsyncLearnView.swift
//  pelisunited
//
//  Created by Harsh Chauhan on 2/17/26.
//
import SwiftUI

extension URLSession {
    static let noCacheSession: URLSession = {
        let config = URLSessionConfiguration.default
        config.requestCachePolicy = .reloadIgnoringLocalAndRemoteCacheData
        return URLSession(configuration: config)
    }()
}

struct RemoteFile<T: Decodable> {
    let url: URL
    let type: T.Type
    
    // MARK: - LEARN  computed var can be declared async
    var contents: T {
        get async throws {
            let (data, _) = try await URLSession.noCacheSession.data(from: url)
            return try JSONDecoder().decode(T.self, from: data)
        }
    }
}

struct Message: Decodable, Identifiable {
    let id: Int
    var user: String
    var text: String
}

struct ComputedAsyncLearnView: View {
    let source = RemoteFile(url: URL(string: "https://hws.dev/inbox.json")!, type: [Message].self)
    @State private var message =  [Message]()
    
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            Text("ComputedAsyncLearnView")
            if message.isEmpty {
                ProgressView()
            }
            LazyVStack {
                ForEach(message) { msg in
                    VStack(alignment: .leading) {
                        Text(msg.user)
                            .font(.headline)
                            .padding(.all, 0)
                        Text(msg.text)
                            .padding(.all, 0)
                    }
                }
            }
        }
        .toolbar {
            Button("Refresh", systemImage: "arrow.clockwise", action: refresh)
        }
        .onAppear(perform: refresh)
        .padding(.all, 0)
    }
    
    func refresh() {
        debugPrint("refresh")
        Task {
            do {
                message = try await self.source.contents
//                debugPrint(message)
                debugPrint(message.count)
            } catch {
                print("Failed to fetch messages: \(error)")
            }
        }
    }
    
}
