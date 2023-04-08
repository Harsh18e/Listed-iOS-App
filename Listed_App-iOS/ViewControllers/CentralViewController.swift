//
//  CentralViewController.swift
//  Listed_App-iOS
//
//  Created by Harsh Kumar Agrawal on 08/04/23.
//

import UIKit
import Foundation

class CentralViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
    setTabBarItem()
        
    }
    private func setTabBarItem() {
        let myTabBarItem = UITabBarItem(title: " ", image: UIImage(named: "plus_image"), tag: 2)
        myTabBarItem.setTitleTextAttributes([.foregroundColor: UIColor.black], for: .selected)
        myTabBarItem.setTitleTextAttributes([.foregroundColor: UIColor.black], for: .normal)
        myTabBarItem.badgeColor = .black
        
        myTabBarItem.selectedImage = UIImage(named: "plus_image")?.withRenderingMode(.alwaysOriginal)
        myTabBarItem.image = UIImage(named: "plus_image")?.withRenderingMode(.alwaysOriginal)
        self.tabBarItem = myTabBarItem
    }
}
