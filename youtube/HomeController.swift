//
//  ViewController.swift
//  youtube
//
//  Created by Vina Melody on 12/11/16.
//  Copyright © 2016 Vina Rianti. All rights reserved.
//

import UIKit

class HomeController: UICollectionViewController {
    
    var videos: [Video]?
    
    let cellId = "cellId"
    
    func fetchVideos() {
        ApiService.sharedInstance.fetchVideos {
            (videos: [Video]) in
            
            self.videos = videos
            self.collectionView?.reloadData()
        }
        
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        fetchVideos()
        
        
        navigationItem.title = "Home"
        navigationController?.navigationBar.isTranslucent = false
        
        // 32 is for the left spacing
        let titleLabel = UILabel(frame: CGRect(x: 0, y: 0, width: view.frame.width - 32, height: view.frame.height))
        titleLabel.text = "Home"
        titleLabel.textColor = UIColor.white
        titleLabel.font = UIFont.systemFont(ofSize: 20)
        navigationItem.titleView = titleLabel
        
        setupCollectionView()
        setupMenuBar()
        setupNavBar()
    }
    
    let menuBar: MenuBar = {
        let mb = MenuBar()
        return mb
    }()
    
    func setupCollectionView() {
        
        if let flowLayout = collectionView?.collectionViewLayout as? UICollectionViewFlowLayout {
            flowLayout.scrollDirection = .horizontal
        }
        
        collectionView?.backgroundColor = UIColor.white
//        collectionView?.register(VideoCell.self, forCellWithReuseIdentifier: "cellId")
        collectionView?.register(UICollectionViewCell.self, forCellWithReuseIdentifier: cellId)
        
        // bring this down a bit for the MenuBar..no auto complete for this
        collectionView?.contentInset = UIEdgeInsets(top: 50, left: 0, bottom: 0, right: 0)
        
        // for the scroll indicator on the right
        collectionView?.scrollIndicatorInsets = UIEdgeInsets(top: 50, left: 0, bottom: 0, right: 0)
    }
    
    func setupMenuBar() {
        
        navigationController?.hidesBarsOnSwipe = true
        
        let redView = UIView()
        redView.backgroundColor = UIColor.rgb(red: 230, green: 32, blue: 31)
        view.addSubview(redView)
        view.addConstraintsWithFormat(format: "H:|[v0]|", views: redView)
        view.addConstraintsWithFormat(format: "V:[v0(50)]", views: redView)
        
        view.addSubview(menuBar)
        view.addConstraintsWithFormat(format: "H:|[v0]|", views: menuBar)
        
        // Removed the pipe for top
        view.addConstraintsWithFormat(format: "V:[v0(50)]", views: menuBar)
        
        // Pin the menuBar below the status bar, but there will be gap between the sliding thus we create the redView
        menuBar.topAnchor.constraint(equalTo: topLayoutGuide.bottomAnchor).isActive = true
    }
    
    func setupNavBar() {
        
        let searchImage = UIImage(named: "search_icon")?.withRenderingMode(UIImageRenderingMode.alwaysOriginal)
        let searchBarButtonItem = UIBarButtonItem(image: searchImage, style: .plain, target: self, action: #selector(handleSearch))
        
        let moreButton = UIBarButtonItem(image: UIImage(named: "nav_more_icon")?.withRenderingMode(UIImageRenderingMode.alwaysOriginal), style: .plain, target: self, action: #selector(handleMore))
        
        navigationItem.rightBarButtonItems = [moreButton, searchBarButtonItem]
    }
    
    // this will be nil
    lazy var settingsLauncher: SettingsLauncher = {
        let launcher = SettingsLauncher()
        launcher.homeController = self
        return launcher
    }()
    
    func handleMore() {
        settingsLauncher.showSettings()
    }
    
    func showControllerForSetting(setting: Setting) {
        let dummySettingsViewController = UIViewController()
        dummySettingsViewController.navigationItem.title = setting.name.rawValue
        dummySettingsViewController.view.backgroundColor = UIColor.white
        navigationController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: UIColor.white]
        navigationController?.navigationBar.tintColor = UIColor.white
        navigationController?.pushViewController(dummySettingsViewController, animated: true)
    }
    
    func handleSearch() {
        
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 4
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath)
        
        cell.backgroundColor = UIColor.blue
        return cell
    }
    
    
//    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//        return videos?.count ?? 0
//    }
//    
//    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
//        
//        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cellId", for: indexPath) as! VideoCell
//        cell.video = videos?[indexPath.item]
//        
//        return cell
//    }

}

extension HomeController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width, height: view.frame.height)
    }
    
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
//        
//        // estimate the total height of entire cell. but this alone will squeeze the thumbnail image, therefore we add with some numbers below
//        let height = (view.frame.width - 16 - 16) * 9 / 16
//        
//        // the + 16 is from the top g ap
//        // + 68 is from the vertical constraints: "V:|-16-[v0]-8-[v1(44)]-16-[v2(1)]|" --> 8 + 44 + 16, ignore the 1
//        // now it becomes 80, extra 12 due to extra padding for the gap added at HomeController
//        return CGSize(width: view.frame.width, height: height + 16 + 88)
//    }
//    
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
//        return 0
//    }
}




