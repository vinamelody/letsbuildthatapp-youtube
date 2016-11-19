//
//  Video.swift
//  youtube
//
//  Created by Vina Melody on 19/11/16.
//  Copyright © 2016 Vina Rianti. All rights reserved.
//

import UIKit

class Video: NSObject {
    
    var thumbnailImageName: String?
    var title: String?
    var numberOfViews: NSNumber?
    var uploadDate: Date?
    
    var channel: Channel?
}

class Channel: NSObject {
    
    var name: String?
    var profileImageName: String?
}
