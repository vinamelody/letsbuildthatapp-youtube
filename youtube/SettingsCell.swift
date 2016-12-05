//
//  SettingCell.swift
//  youtube
//
//  Created by Vina Melody on 5/12/16.
//  Copyright © 2016 Vina Rianti. All rights reserved.
//

import UIKit

class SettingsCell: BaseCell {
    
    let nameLabel: UILabel = {
        let label = UILabel()
        label.text = "Settings"
        return label
    }()
    
    let iconImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "settings")
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    override func setupViews() {
        super.setupViews()
        
        addSubview(nameLabel)
        addSubview(iconImageView)
        
        addConstraintsWithFormat(format: "H:|-16-[v0(30)]-8-[v1]|", views: iconImageView, nameLabel)
        
        addConstraintsWithFormat(format: "V:|[v0]|", views: nameLabel)
        addConstraintsWithFormat(format: "V:|[v0(30)]|", views: iconImageView)
        
    }
}
