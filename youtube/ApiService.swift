//
//  ApiService.swift
//  youtube
//
//  Created by Vina Melody on 25/12/16.
//  Copyright © 2016 Vina Rianti. All rights reserved.
//

import UIKit


class ApiService: NSObject {
    
    static let sharedInstance = ApiService()
    let baseUrl = "https://s3-us-west-2.amazonaws.com/youtubeassets"
    
    func fetchFeedForUrlString(urlString: String, completion: @escaping ([Video]) -> ()) {
        
        let url = URL(string: urlString)
        URLSession.shared.dataTask(with: url!) { (data, response, error) in
            
            if error != nil {
                print(error)
                return
            }
            
            do {
                
                if let unwrappedData = data {
                    if let jsonDictionaries = try JSONSerialization.jsonObject(with: unwrappedData, options: JSONSerialization.ReadingOptions.mutableContainers) as? [[String: AnyObject]] {
                        var videos = [Video]()
                        
                        for dictionary in jsonDictionaries {
                            let video = Video(dictionary: dictionary)
                            videos.append(video)
                        }
                        
                        DispatchQueue.main.async {
                            completion(videos)
                        }
                    }
                    
                    
                }
                
            } catch let jsonError {
                print(jsonError)
            }
            
            }.resume()
    }
    
    func fetchSubscriptionFeed(completion: @escaping ([Video]) -> ()) {
        fetchFeedForUrlString(urlString: "\(baseUrl)/subscriptions.json", completion: completion)
    }
    
    func fetchTrendingFeed(completion: @escaping ([Video]) -> ()) {
        fetchFeedForUrlString(urlString: "\(baseUrl)/trending.json", completion: completion)
    }
    
    func fetchVideos(completion: @escaping ([Video]) -> ()) {
        fetchFeedForUrlString(urlString: "\(baseUrl)/home.json", completion: completion)
    }
}
