//
//  DismissViewController.swift
//  guest
//
//  Created by 王海峰 on 15/8/14.
//  Copyright (c) 2015年 云飞凌风. All rights reserved.
//

import UIKit

class DismissViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.leftBarButtonItem = UIBarButtonItem.init(image: UIImage(named: "navigationbar_back"), style: .plain, target: self, action: #selector(DismissViewController.trashClick))
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func initNavigationItem() {
        let setButton = UIButton(frame: CGRect(x:0, y:0, width:44, height:44));
        setButton.setImage(UIImage(named: "navigationbar_back"), for: .normal);
        setButton.setImage(UIImage(named: "navigationbar_back_highlighted"), for:UIControlState.highlighted)
        setButton.imageEdgeInsets = UIEdgeInsetsMake(12, 12, 12, 12);
        setButton.addTarget(self, action: #selector(DismissViewController.trashClick), for: .touchUpInside);
        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: setButton);
    }
    
    func trashClick(){
        self.dismiss(animated: true, completion: nil)
    }
    

}
