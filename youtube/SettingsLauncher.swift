//
//  SettingsLauncher.swift
//  youtube
//
//  Created by Vina Melody on 26/11/16.
//  Copyright © 2016 Vina Rianti. All rights reserved.
//

import UIKit

class Setting: NSObject {
    let name: SettingName
    let imageName: String
    
    init(name: SettingName, imageName: String) {
        self.name = name
        self.imageName = imageName
    }
}

enum SettingName: String {
    case cancel = "Cancel"
    case settings = "Settings"
    case termsPrivacy = "Terms & privacy policy"
    case sendFeedback = "Send Feedback"
    case help = "Help"
    case switchAccount = "Switch Account"
}

class SettingsLauncher: NSObject {
    
    let blackView = UIView()
    
    let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.backgroundColor = UIColor.white
        return cv
    }()
    
    let cellHeight: CGFloat = 50
    
    var homeController: HomeController?
    
    func showSettings() {
        
        if let window = UIApplication.shared.keyWindow {
            
            blackView.backgroundColor = UIColor(white: 0, alpha: 0.5)
            
            blackView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleDismiss)))
            
            window.addSubview(blackView)
            window.addSubview(collectionView)
            
            let height: CGFloat = CGFloat(settings.count) * cellHeight
            let y = window.frame.height - height
            
            collectionView.frame = CGRect(x: 0, y: window.frame.height, width: window.frame.width, height: height)
            
            blackView.frame = window.frame
            blackView.alpha = 0
            
            UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: { 
                self.blackView.alpha = 1
                self.collectionView.frame = CGRect(x: 0, y: y, width: self.collectionView.frame.width, height: self.collectionView.frame.height)
                }, completion: nil)
            
        }
    }
    
    func handleDismiss(setting: Setting) {
        
        
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
            
            self.blackView.alpha = 0
            if let window = UIApplication.shared.keyWindow {
                self.collectionView.frame = CGRect(x: 0, y: window.frame.height, width: self.collectionView.frame.width, height: self.collectionView.frame.height)
            }
            
        }) { (complete: Bool) in
            
            // oh no, setting is actually a uitapgesture, see ep 9
            if setting.name != .cancel {
                
                self.homeController?.showControllerForSetting(setting: setting)
            }
            
        }
    }
    
    let cellId = "cellId"
    
    let settings: [Setting] = {
        let cancelSetting = Setting(name: .cancel, imageName: "cancel")
        return [Setting(name: .settings, imageName: "settings"),
                Setting(name: .termsPrivacy, imageName: "privacy"),
                Setting(name: .sendFeedback, imageName: "feedback"),
                Setting(name: .help, imageName: "help"),
                Setting(name: .switchAccount, imageName: "switch_account"),
                cancelSetting]
    }()
    
    override init() {
        super.init()
        
        collectionView.dataSource = self
        collectionView.delegate = self
        
        collectionView.register(SettingsCell.self, forCellWithReuseIdentifier: cellId)
    }
    
}

extension SettingsLauncher: UICollectionViewDataSource, UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return settings.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! SettingsCell
        
        cell.setting = settings[indexPath.item]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        // here need to use completion block coz we want to hide first then push new vc
        
        handleDismiss(setting: settings[indexPath.item])
    }
}

extension SettingsLauncher: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: cellHeight)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    
}
