//
//  BaseViewController.swift
//  guest
//
//  Created by 王海峰 on 15/8/14.
//  Copyright (c) 2015年 云飞凌风. All rights reserved.
//

import UIKit

class BaseViewController: UIViewController {
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //点击返回上一层
    func trashClick(){
         self.navigationController!.popToRootViewController(animated: true)
    }

    //页码
    var PAGE_NUM  = 1
    
    //一页要现实的数量
    var SHOW_NUM = 20
    
}
