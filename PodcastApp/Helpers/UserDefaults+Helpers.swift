//
//  UserDefaults+Helpers.swift
//  PodcastApp
//
//  Created by Saleh Asadov 
//

import Foundation

extension UserDefaults {
    static let downloadKey = "downloadedKey"
    static func downloadEpisodeWrite(episode: Episode){
        do{
            var resultEpisodes = downloadEpisodeRead()
            resultEpisodes.append(episode)
            let data = try JSONEncoder().encode(resultEpisodes)
            UserDefaults.standard.set(data, forKey: UserDefaults.downloadKey)
        }catch{
            
        }
    }
    
    static func downloadEpisodeRead() -> [Episode]{
        guard let data = UserDefaults.standard.data(forKey: UserDefaults.downloadKey) else { return [] }
        do{
            let resultData = try JSONDecoder().decode([Episode].self, from: data)
            return resultData
        }catch{
            
        }
        
        return []
    }
    
}

extension UserDefaults {
    static func deleteDownloadedEpisode(episode: Episode) {
        var downloadedEpisodes = downloadEpisodeRead()
        if let index = downloadedEpisodes.firstIndex(where: { $0.streamUrl == episode.streamUrl }) {
            downloadedEpisodes.remove(at: index)
            do {
                let data = try JSONEncoder().encode(downloadedEpisodes)
                UserDefaults.standard.set(data, forKey: downloadKey)
            } catch {
                
            }
        }
    }
}
