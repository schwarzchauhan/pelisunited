//
//  Title.swift
//  pelisunited
//
//  Created by Harsh Chauhan on 12/21/25.
//

import Foundation

struct APIObject: Decodable {
    var results: [Title] = []
}

struct Title: Decodable, Identifiable {
    var id: Int
    var title: String?
    var name: String?
    var overview: String
    var posterPath: String?
    
    static var previewTitles = [
        Title(id: 1, title: "BeetleJuice", name: "BeetleJuice", overview: "A move about BeetleJuice", posterPath: ConstantsUrl.testTitleUrl),
        Title(id: 2, title: "Pulp Fiction", name: "Pulp Fiction", overview: "A move about Pulp Fiction", posterPath: ConstantsUrl.testTitleUrl2),
        Title(id: 2, title: "The Dark Knight", name: "The Dark Knight", overview: "A move about The Dark Knight", posterPath: ConstantsUrl.testTitleUrl3)
    ]
}
