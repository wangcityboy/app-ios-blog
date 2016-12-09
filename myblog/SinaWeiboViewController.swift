//
//  SinaWeiboViewController.swift
//  myblog
//
//  Created by chinaskin on 16/10/24.
//  Copyright © 2016年 wanghaifeng. All rights reserved.
//

import UIKit

class SinaWeiboViewController: BaseViewController {
    
    lazy var webView: UIWebView = {
        let webView = UIWebView();
        webView.backgroundColor = UIColor.white;
        webView.frame = CGRect(x:0, y:64, width:mainScreenWidth, height:mainScreenHeight-64)
        webView.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(webView);
        return webView;
    }();
    
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "关注微博";
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true);
        self.showHUD()
        let request = NSURLRequest(url: NSURL(string: "http://weibo.com/wangcityboy")! as URL, cachePolicy: .returnCacheDataElseLoad, timeoutInterval: 30);
        webView.loadRequest(request as URLRequest);
        self.hideHUD()
    }
    
}
