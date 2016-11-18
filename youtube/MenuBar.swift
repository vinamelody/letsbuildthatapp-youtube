//
//  MenuBar.swift
//  youtube
//
//  Created by Vina Melody on 18/11/16.
//  Copyright © 2016 Vina Rianti. All rights reserved.
//

import UIKit

class MenuBar: UIView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = UIColor.rgb(red: 230, green: 32, blue: 31)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
