//
//  Search.swift
//  PodcastApp
//
//  Created by Saleh Asadov 
//

import Foundation

struct Search: Codable {
    let resultCount: Int
    let results: [Podcast]
}
struct Podcast: Codable {
    var trackName: String?
    var artistName: String
    var trackCount: Int?
    var artworkUrl600: String?
    var feedUrl: String?
}
