//
//  MainTabBarViewController.swift
//  TestDemo
//
//  Created by mike liu on 2023/6/15.
//

import UIKit

class MainTabBarViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        //        view.backgroundColor = .systemYellow
        
        let vc1 = UINavigationController(rootViewController: SiteViewController())
        let vc2 = UINavigationController(rootViewController: PlentViewController())

        
        vc1.tabBarItem.image = UIImage(systemName: "tortoise.fill")
        vc2.tabBarItem.image = UIImage(systemName: "camera.macro")

        
        vc1.title = "動物館區"
        vc2.title = "植物資料"

        tabBar.tintColor = .label
        
        setViewControllers([vc1, vc2], animated: true)
    }
    
}
