//
//  FavoriteCellViewModel.swift
//  PodcastApp
//
//  Created by Saleh Asadov 
//

import Foundation

class FavoriteCellViewModel {
    private let podcastCoreData: PodcastCoreData
    
    init(podcastCoreData: PodcastCoreData) {
        self.podcastCoreData = podcastCoreData
    }
    
    var podcastNameLabel: String {
        return podcastCoreData.trackName ?? "Unknown Title"
    }
    
    var podcastArtistName: String {
        return podcastCoreData.artistName ?? "Unknown Artist"
    }
    
    var imageUrlPodcast: URL? {
        return URL(string: podcastCoreData.artworkUrl600 ?? "")
    }
}

