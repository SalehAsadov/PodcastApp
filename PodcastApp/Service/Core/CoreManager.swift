//
//  CoreManager.swift
//  PodcastApp
//
//  Created by Saleh Asadov 
//

import Foundation
import Alamofire

class CoreManager {
    static func request<T: Codable>(model: T.Type,
                                    url: String,
                                    parameters: [String: Any],
                                    completion: @escaping((T?, String?) -> Void)) {
        AF.request(url, parameters: parameters).responseDecodable(of: model) { response in
            switch response.result {
            case .success(let data):
                completion(data, nil)
            case .failure(let error):
                completion(nil, error.localizedDescription)
            }
        }
    }
}

