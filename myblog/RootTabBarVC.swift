//
//  RootTabBarVC.swift
//  guest
//
//  Created by 王海峰 on 15/8/14.
//  Copyright (c) 2015年 云飞凌风. All rights reserved.
//

import UIKit
import RDVTabBarController


class RootTabBarVC: RDVTabBarController {
    
    var  HomeViewVC: IndexViewController?
    var  HomeViewNC: UINavigationController?
    
    var  ArticleViewVC: ArticleViewController?
    var  ArticleViewNC: UINavigationController?
    
    var  PhotoViewVC: ImageViewController?
    var  PhotoViewNC: UINavigationController?
    
    var  MyProfileVC: ProfileViewController?
    var  MyProfileNC: UINavigationController?
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        self.configureViewControllers()
        self.configureTabbar()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    static func normal(navigationController: UINavigationController) {
        navigationController.navigationBar.barTintColor = UIColor.red
        navigationController.navigationBar.isTranslucent = false;
        navigationController.navigationBar.tintColor = UIColor.white
        navigationController.navigationBar.titleTextAttributes = [NSFontAttributeName: UIFont.boldSystemFont(ofSize: 20),NSForegroundColorAttributeName: UIColor.white]
    }

    func configureViewControllers() {
    
        self.HomeViewVC = IndexViewController()
        self.HomeViewNC = UINavigationController(rootViewController: self.HomeViewVC!)
        
        self.ArticleViewVC = ArticleViewController()
        self.ArticleViewNC = UINavigationController(rootViewController: self.ArticleViewVC!)
        
        
        self.PhotoViewVC = ImageViewController()
        self.PhotoViewNC = UINavigationController(rootViewController: self.PhotoViewVC!)
        
        self.MyProfileVC = ProfileViewController()
        
        self.viewControllers = [self.HomeViewNC!, self.ArticleViewNC!, self.PhotoViewNC!, self.MyProfileVC!]
    }

    
    func configureTabbar() {
        
        let item_showBaby: RDVTabBarItem! = self.tabBar!.items[0] as! RDVTabBarItem
        item_showBaby.title = "首页"
        item_showBaby.setFinishedSelectedImage(UIImage(named: "tabbar_icon_home_selected"),withFinishedUnselectedImage:UIImage(named: "tabbar_icon_home_normal"))
        item_showBaby.selectedTitleAttributes = [NSForegroundColorAttributeName:UIColor(red: 235/255, green: 51/255, blue: 58/255, alpha: 1)]
        item_showBaby.unselectedTitleAttributes = [NSForegroundColorAttributeName:UIColor(red: 134/255, green: 135/255, blue: 136/255, alpha: 1)]
        item_showBaby.badgeTextFont = UIFont.systemFont(ofSize: 20)
        
        let item_juggle: RDVTabBarItem! = self.tabBar!.items[1] as! RDVTabBarItem
        item_juggle.title = "日志"
        item_juggle.setFinishedSelectedImage(UIImage(named: "tabbar_icon_reader_selected"),withFinishedUnselectedImage:UIImage(named: "tabbar_icon_reader_normal"))
        item_juggle.selectedTitleAttributes = [NSForegroundColorAttributeName:UIColor(red: 235/255, green: 51/255, blue: 58/255, alpha: 1)]
        item_juggle.unselectedTitleAttributes = [NSForegroundColorAttributeName:UIColor(red: 134/255, green: 135/255, blue: 136/255, alpha: 1)]
        
        let item_integral: RDVTabBarItem! = self.tabBar!.items[2] as! RDVTabBarItem
        item_integral.title = "相册"
        item_integral.setFinishedSelectedImage(UIImage(named: "tabbar_icon_photo_selected"),withFinishedUnselectedImage:UIImage(named: "tabbar_icon_photo_normal"))
        item_integral.selectedTitleAttributes = [NSForegroundColorAttributeName:UIColor(red: 235/255, green: 51/255, blue: 58/255, alpha: 1)]
        item_integral.unselectedTitleAttributes = [NSForegroundColorAttributeName:UIColor(red: 134/255, green: 135/255, blue: 136/255, alpha: 1)]
        
        let item_me: RDVTabBarItem! = self.tabBar!.items[3] as! RDVTabBarItem
        item_me.title = "我"
        item_me.setFinishedSelectedImage(UIImage(named: "tabbar_icon_me_selected"),withFinishedUnselectedImage:UIImage(named: "tabbar_icon_me_normal"))
        item_me.selectedTitleAttributes = [NSForegroundColorAttributeName:UIColor(red: 235/255, green: 51/255, blue: 58/255, alpha: 1)]
        item_me.unselectedTitleAttributes = [NSForegroundColorAttributeName:UIColor(red: 134/255, green: 135/255, blue: 136/255, alpha: 1)]
    }


    

}
