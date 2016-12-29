//
//  Video.swift
//  youtube
//
//  Created by Vina Melody on 19/11/16.
//  Copyright © 2016 Vina Rianti. All rights reserved.
//

import UIKit

class Video: NSObject {
    
    var thumbnail_image_name: String?
    var title: String?
    var number_of_views: NSNumber?
    var uploadDate: Date?
    var duration: NSNumber?
    
    var channel: Channel?
    
    override func setValue(_ value: Any?, forKey key: String) {
        if key == "channel" {
            self.channel = Channel()
            self.channel?.setValuesForKeys(value as! [String: AnyObject])
        } else {
            super.setValue(value, forKey: key)
        }
        
    }
}

class Channel: NSObject {
    
    var name: String?
    var profile_image_name: String?
}
