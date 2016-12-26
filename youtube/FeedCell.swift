//
//  FeedCell.swift
//  youtube
//
//  Created by Vina Melody on 26/12/16.
//  Copyright © 2016 Vina Rianti. All rights reserved.
//

import UIKit

class FeedCell: BaseCell {
    
    var videos: [Video]?
    
    lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.backgroundColor = .white
        cv.delegate = self
        cv.dataSource = self
        return cv
    }()
    
    let cellId = "cellId"
    
    override func setupViews() {
        super.setupViews()
        
        fetchVideos()
        
        addSubview(collectionView)
        addConstraintsWithFormat(format: "H:|[v0]|", views: collectionView)
        addConstraintsWithFormat(format: "V:|[v0]|", views: collectionView)
        
        collectionView.register(VideoCell.self, forCellWithReuseIdentifier: cellId)
        
    }
    
    func fetchVideos() {
        ApiService.sharedInstance.fetchVideos {
            (videos: [Video]) in
            
            self.videos = videos
            self.collectionView.reloadData()
        }
        
    }
}

extension FeedCell: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return videos?.count ?? 0
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! VideoCell
        cell.video = videos?[indexPath.item]

        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {

        // estimate the total height of entire cell. but this alone will squeeze the thumbnail image, therefore we add with some numbers below
        let height = (frame.width - 16 - 16) * 9 / 16

        // the + 16 is from the top g ap
        // + 68 is from the vertical constraints: "V:|-16-[v0]-8-[v1(44)]-16-[v2(1)]|" --> 8 + 44 + 16, ignore the 1
        // now it becomes 80, extra 12 due to extra padding for the gap added at HomeController
        return CGSize(width: frame.width, height: height + 16 + 88)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
}

