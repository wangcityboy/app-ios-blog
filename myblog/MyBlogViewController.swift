//
//  MyBlogViewController.swift
//  myblog
//
//  Created by chinaskin on 16/10/24.
//  Copyright © 2016年 wanghaifeng. All rights reserved.
//

import UIKit
import SCLAlertView

class MyBlogViewController: BaseViewController {
    
    var webView = UIWebView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "云飞凌风个人博客"
        webView.frame = self.view.bounds
        self.view.addSubview(webView)
        loadurl(url: "http://wanghaifeng.net")
        
        SCLAlertView().showWarning("温馨提示", subTitle:"请在PC端浏览器中访问『http://wanghaifeng.net』,显示效果会更好！", closeButtonTitle:"确定")
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
    }
    
    func loadurl(url:String){
        let _url = URL(string: url)
        let request = NSURLRequest(url: _url!)
        webView.loadRequest(request as URLRequest)
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    
    
    
}
