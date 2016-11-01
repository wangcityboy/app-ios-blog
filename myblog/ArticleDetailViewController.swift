//
//  ArticleDetailViewController.swift
//  YunFeiLingFeng
//
//  Created by 王海峰 on 15/8/4.
//  Copyright (c) 2015年 云飞凌风. All rights reserved.
//

import UIKit
import Alamofire


class ArticleDetailViewController:BaseViewController {

    
    var articleList:ArticleLists?
    var webView = UIWebView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "文章详情"
        webView.frame = CGRect(x:0, y:0, width:mainScreenWidth, height:mainScreenHeight-64)
        self.view.addSubview(webView)
        self.showHUD()
        loadDataSource()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.rdv_tabBarController.setTabBarHidden(true, animated: true)
        self.navigationItem.leftBarButtonItem = UIBarButtonItem.init(image: UIImage(named: "navigationbar_back"), style: .plain, target: self, action: Selector(("trashClick")))
    }
    
    
    func loadDataSource(){
        
        if let item: ArticleLists = articleList {
            let aId = item.aId as String
            let aTitle = item.aTitle as String
            let aContent = item.aContent as String
            let aUsername = item.aUsername as String
            let aDate = item.aDate as String
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
            let dateFromString = dateFormatter.date(from: aDate)
            dateFormatter.dateFormat = "yyyy-MM-dd"
            let dataFormat = dateFormatter.string(from: dateFromString!)

            
            let baseurl = URL(string: server_url)

            let topHtml = "<html lang='zh-CN'><head><meta charset='utf-8'><meta http-equiv='X-UA-Compatible' content='IE=edge,chrome=1'><style>img{width:\(mainScreenWidth-20) !important;}</style><title>\(aTitle)</title><meta name='apple-itunes-app' content='app-id=639087967, app-argument=zhihudaily://story/4074215'><meta name='viewport' content='user-scalable=no, width=device-width'><link rel='stylesheet' href='http://wanghaifeng.net/styles/1/webView.css'><script src='http://wanghaifeng.net/js/jquery.1.9.1.js'></script><base target='_blank'></head><body> <div class='main-wrap content-wrap'> <div class='content-inner'> <div class='question'> <h2 class='question-title'>\(aTitle)</h2> <div class='answer'> <div class='meta' style='padding-bottom:10px;border-bottom:1px solid #e7e7eb'><span class='bio'>\(dataFormat)</span> &nbsp;<span class='bio'>\(aUsername)</span></div><div class='content'>"
            
            let footHtml = " </div> </div> </div> </boby></script> </body> <script>$('img').attr('style', '');$('img').attr('width', '');$('img').attr('height', '');$('img').attr('class', '');$('img').attr('title', '');$('p').attr('style', '');</script></html>"
            
            self.hideHUD()
            
            
            let parameters = ["id":aId]
            
            let res = Alamofire.request(detail_url,method:.get,parameters: parameters);
            print(res)
        
            self.webView.loadHTMLString("\(topHtml)\(aContent)\(footHtml)", baseURL: baseurl)
            UIApplication.shared.isNetworkActivityIndicatorVisible = false
        }
    }


    
    //    func setButtonAction(button: UIButton) {
    //        let saimg = UIImage(data: NSData(contentsOfURL: NSURL(string: Home_url + image)!)!)
    //        UMSocialData.defaultData().extConfig.title = self.atitle
    //
    //        //微信分享
    //        UMSocialWechatHandler.setWXAppId("wx3e74bb9503858db0", appSecret: "ae896a753b8b896986cddd78ac610c3a", url: "\(shareUrl)" + "\(articleId)")
    //        //新浪微博分享
    //        UMSocialDataService.defaultDataService().requestAddFollow(UMShareToSina, followedUsid:
    //            ["3784955924"], completion: nil)
    //
    //        let snsArray = [UMShareToSina,UMShareToWechatSession,UMShareToQQ,UMShareToQzone,UMShareToWechatTimeline,UMShareToEmail]
    //
    //        //友盟社会化分享组件
    //        UMSocialSnsService.presentSnsIconSheetView(self, appKey: "55d9083367e58e3267003db4", shareText:atitle+"  "+shareUrl + "\(articleId)", shareImage: saimg, shareToSnsNames: snsArray, delegate: nil)
    //    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}
