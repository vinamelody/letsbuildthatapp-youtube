//
//  SubscriptionCell.swift
//  youtube
//
//  Created by Vina Melody on 29/12/16.
//  Copyright © 2016 Vina Rianti. All rights reserved.
//

import UIKit

class SubscriptionCell: FeedCell {

    override func fetchVideos() {
        ApiService.sharedInstance.fetchSubscriptionFeed() {
            (videos: [Video]) in
            
            self.videos = videos
            self.collectionView.reloadData()
        }
        
        
    }

}
