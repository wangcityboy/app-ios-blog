//
//  WeixinViewController.swift
//  myblog
//
//  Created by chinaskin on 16/10/24.
//  Copyright © 2016年 wanghaifeng. All rights reserved.
//

import UIKit

class WeixinViewController: BaseViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        self.title = "添加本人微信"
        let image = UIImageView(frame: self.view.bounds)
        image.image = UIImage(named: "bg22.jpg")
        self.view.addSubview(image)
        let label = UILabel(frame: CGRect(x:20, y:64, width:mainScreenWidth-20, height:50))
        
        label.text = "请扫描下面的微信二维码添加我的微信,或者搜索我微信号添加我微信:lovelyfeng"
        label.numberOfLines = 0
        label.textColor = UIColor.white
        self.view.addSubview(label)
        
        let weixinImage = UIImageView(frame: CGRect(x:10, y:label.bottom, width:mainScreenWidth-20,height:mainScreenHeight-label.bottom))
        weixinImage.contentMode = .scaleAspectFit
        weixinImage.image = UIImage(named: "weixin.jpg")
        self.view.addSubview(weixinImage)
        
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

