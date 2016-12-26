//
//  FeedCell.swift
//  youtube
//
//  Created by Vina Melody on 26/12/16.
//  Copyright © 2016 Vina Rianti. All rights reserved.
//

import UIKit

class FeedCell: BaseCell {
    
    let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.backgroundColor = .white
        return cv
    }()
    
    override func setupViews() {
        super.setupViews()
        
        addSubview(collectionView)
        addConstraintsWithFormat(format: "H:|[v0]|", views: collectionView)
        addConstraintsWithFormat(format: "V:|[v0]|", views: collectionView)
        
    }
}
