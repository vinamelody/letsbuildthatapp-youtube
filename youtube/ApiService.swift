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
    
    func fetchVideos() {
        
        let url = URL(string: "https://s3-us-west-2.amazonaws.com/youtubeassets/home.json")
        
        URLSession.shared.dataTask(with: url!) { (data, response, error) in
            
            if error != nil {
                print(error)
                return
            }
            
            do {
                // this would create the dictionary type for variable json
                let json = try JSONSerialization.jsonObject(with: data!, options: JSONSerialization.ReadingOptions.mutableContainers)
                
                self.videos = [Video]()
                
                for dictionary in json as! [[String: AnyObject]] {
                    
                    let video = Video()
                    video.title = dictionary["title"] as? String
                    video.thumbnailImageName = dictionary["thumbnail_image_name"] as? String
                    
                    let channelDictionary = dictionary["channel"] as! [String: AnyObject]
                    
                    let channel = Channel()
                    channel.name = channelDictionary["name"] as? String
                    channel.profileImageName = channelDictionary["profile_image_name"] as? String
                    
                    video.channel = channel
                    
                    self.videos?.append(video)
                }
                
                DispatchQueue.main.async {
                    self.collectionView?.reloadData()
                }
                
                
            } catch let jsonError {
                print(jsonError)
            }
            
            }.resume()
        
    }
}