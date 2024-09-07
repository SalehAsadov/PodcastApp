//
//  SearchService.swift
//  PodcastApp
//
//  Created by Saleh Asadov 
//

import Foundation
import Alamofire

class SearchService {
    static func fetchData(searchText: String, completion: @escaping([Podcast])->Void){
        let mainUrl = "https://itunes.apple.com/search"
        let parameters = ["media": "podcast", "term": searchText]
        AF.request(mainUrl, parameters: parameters).responseData { response in
            if let error = response.error{
                print(error.localizedDescription)
                return
            }
            guard let data = response.data else{ return }
            do {
                let searchResult = try JSONDecoder().decode(Search.self, from: data)
                completion(searchResult.results)
            } catch {
                
            }
        }
    }
    
    static func fetchItems(searchText: String, completion: @escaping(Search?, String?)->Void) {
        let mainUrl = CoreHelper.baseURL + "search"
        let parameters = ["media": "podcast", "term": searchText]
        CoreManager.request(model: Search.self, url: mainUrl, parameters: parameters, completion: completion)
    }
}
