//
//  IndexDetailViewController.swift
//  myblog
//
//  Created by 王海峰 on 16/11/10.
//  Copyright © 2016年 wanghaifeng. All rights reserved.
//


import UIKit
import Alamofire

class IndexDetailViewController: UIViewController {
    var indexmodel = Indexmodel()
    var webView = UIWebView()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.isNavigationBarHidden = false
        RootTabBarVC.normal(navigationController: self.navigationController!)
        self.title = "日志详情"
        webView.frame = CGRect(x:0, y:0, width:mainScreenWidth, height:mainScreenHeight-64);
        self.view.addSubview(webView)

        self.loadDataSource()

    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.rdv_tabBarController.setTabBarHidden(true, animated: true)
        self.navigationItem.leftBarButtonItem = UIBarButtonItem.init(image: UIImage(named: "navigationbar_back"), style: .plain, target: self, action: #selector(trashClick))
    }
    
    
    
    //点击返回上一层
    func trashClick(){
        self.navigationController!.popToRootViewController(animated: true)
    }
    

    
    func loadDataSource(){
        
            let aId = indexmodel.aId! as String
            let aTitle = indexmodel.aTitle! as String
            let aContent = indexmodel.aContent! as String
            let aUsername = indexmodel.aUsername! as String
            let aDate = indexmodel.aDate! as String
            
            let topHtml = "<html lang='zh-CN'> <head><meta charset='utf-8'><meta http-equiv='X-UA-Compatible' content='IE=edge,chrome=1'>  <style>img{width:\(mainScreenWidth-20) !important;}</style> <title>\(aTitle)</title>   <meta name='apple-itunes-app' content='app-id=639087967, app-argument=zhihudaily://story/4074215'><meta name='viewport' content='user-scalable=no, width=device-width'> <link rel='stylesheet' href='http://wanghaifeng.net/styles/1/webView.css'> <script src='http://wanghaifeng.net/js/jquery.1.9.1.js'></script> <base target='_blank'></head>   <body> <div class='main-wrap content-wrap'> <div class='content-inner'> <div class='question'> <h2 class='question-title'>\(aTitle)</h2> <div class='answer'> <div class='meta' style='padding-bottom:10px;border-bottom:1px solid #e7e7eb'><span class='bio'>\(aDate)</span> &nbsp;<span class='bio'>\(aUsername)</span></div><div class='content'>"
            
            let footHtml = " </div> </div> </div> </boby></script> </body> <script>$('img').attr('style', '');$('img').attr('width', '');$('img').attr('height', '');$('img').attr('class', '');$('img').attr('title', '');$('p').attr('style', '');</script></html>"
            
            self.hideHUD()
            self.webView.loadHTMLString("\(topHtml)\(aContent)\(footHtml)", baseURL: URL(string: server_url))
            let parameters = ["id":aId]
            let result = Alamofire.request(detail_url, method: .get,parameters: parameters)
            print(result)
            UIApplication.shared.isNetworkActivityIndicatorVisible = false
    }
    
}
