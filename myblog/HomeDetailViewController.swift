//
//  HomeDetailViewController.swift
//  myblog
//
//  Created by chinaskin on 16/10/18.
//  Copyright © 2016年 wanghaifeng. All rights reserved.
//

import UIKit
import Alamofire

class HomeDetailViewController:UIViewController{
    
    var articleList:ArticleLists?
    var webView = UIWebView()

    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "日志详情"
        webView.frame = CGRect(x:0, y:0, width:mainScreenWidth, height:mainScreenHeight-64);
        self.view.addSubview(webView)
        
        self.showHUD()
        
        self.loadDataSource()
        self.webView.delegate = self
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
    
    
    func setButtonAction(button: UIButton) {
//        let saimg = UIImage(data: NSData(contentsOf: NSURL(string: Home_url + image)! as URL)! as Data)
//        UMSocialData.default().extConfig.title = self.atitle
//        
//        //微信分享
//        UMSocialWechatHandler.setWXAppId("wx3e74bb9503858db0", appSecret: "ae896a753b8b896986cddd78ac610c3a", url: "\(shareUrl)" + "\(articleId)")
//        //新浪微博分享
//        UMSocialDataService.default().requestAddFollow(UMShareToSina, followedUsid:
//            ["3784955924"], completion: nil)
//        
//        
//        
//        let snsArray = [UMShareToSina,UMShareToWechatSession,UMShareToQQ,UMShareToQzone,UMShareToWechatTimeline,UMShareToFacebook,UMShareToTwitter,UMShareToEmail]
//        
//        //友盟社会化分享组件
//        UMSocialSnsService.presentSnsIconSheetView(self, appKey: "55d9083367e58e3267003db4", shareText:atitle+"  "+shareUrl + "\(articleId)", shareImage: saimg, shareToSnsNames: snsArray, delegate: nil)
    }
    
    
    func loadDataSource(){
        
        if let item: ArticleLists = articleList {
            let aId = item.aId as String
            let aTitle = item.aTitle as String
            let aContent = item.aContent as String
            let aUsername = item.aUsername as String
            let aDate = item.aDate as String
            
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
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}

extension HomeDetailViewController:UIWebViewDelegate{
    private func webView(webView: UIWebView, shouldStartLoadWithRequest request: NSURLRequest, navigationType: UIWebViewNavigationType) -> Bool {
        if navigationType == UIWebViewNavigationType.linkClicked {
            UIApplication.shared.openURL(request.url!)
            return false
        }else if navigationType == UIWebViewNavigationType.other {
            let scheme = "hyb-image-preview:"
            // 由于我们注入了JS，在点击HTML中的图片时，就会跳转，然后在此处就可以拦截到
            if ((request.url?.scheme?.hasPrefix(scheme)) != nil) {
                // 获取原始图片的URL
//                let src = request.URL?.absoluteString.stringByReplacingOccurrencesOfString(scheme, withString: "")
                let src = request.url?.absoluteString.replacingOccurrences(of: scheme, with: "")
                if let imageUrl = src {
                    // 原生API展开图片
                    // 这里已经拿到所点击的图片的URL了，剩下的部分，自己处理了
                    // 有时候会感觉点击无响应，这是因为webViewDidFinishLoad,还没有调用。
                    // 调用很晚的原因，通常是因为H5页面中有比较多的内容在加载
                    // 因此，若是原生APP与H5要交互，H5要尽可能地提高加载速度
                    // 不相信？在webViewDidFinishLoad加个断点就知道了
                    print(imageUrl)
                }
            }
        }
        return true
    }
    
    private func webViewDidFinishLoad(webView: UIWebView) {
        // 在H5页面加载完成时，注入图片点击的JS代码
        let js = "function addImgClickEvent() { " +
            "var imgs = document.getElementsByTagName('img');" +
            // 遍历所有的img标签，统一加上点击事件
            "for (var i = 0; i < imgs.length; ++i) {" +
            "var img = imgs[i];" +
            "img.onclick = function () {" +
            // 给图片添加URL scheme，以便在拦截时可能识别跳转
            "window.location.href = 'hyb-image-preview:' + this.src;" +
            "}" +
            "}" +
        "}"
        // 注入JS代码
        self.webView.stringByEvaluatingJavaScript(from: js)
        
        // 执行所注入的JS
        self.webView.stringByEvaluatingJavaScript(from: "addImgClickEvent();")
    }

}
