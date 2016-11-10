//
//  MyWebView.swift
//  swiftIdeas
//
//  Created by HYZ on 16/7/19.
//  Copyright © 2016年 HYZ. All rights reserved.
//

import UIKit
import JavaScriptCore
class MyWebView: UIView,UIWebViewDelegate {

   let webview = UIWebView()


     init(f: CGRect) {
         super.init(frame: f)
         webview.frame = f
         webview.delegate=self
         self.addSubview(webview)
    }
    
    required init?(coder aDecoder: NSCoder) {
      super.init(coder: aDecoder)
    }
   

    func loadMywebview(myUrl:String){
        if myUrl.isEqual("about:blank") {
            return
        }
        
        let request = NSURLRequest(url: NSURL(string: (myUrl as String))! as URL)
        webview.loadRequest(request as URLRequest)
    }
    
    func cancelMywebview()
    {
        if webview.isLoading {
            webview.stopLoading()
            webview.delegate=nil
            UIApplication.shared.isNetworkActivityIndicatorVisible = false
            
        }
    }
    
    func reloadMywebview(){
        if !webview.isLoading {
              UIApplication.shared.isNetworkActivityIndicatorVisible = true
            webview.reload()
        }
    }
    
    
//    func backBtnAction(backBtn:UIButton) {
//        webView.goBack()
//    }
//    
//    func forwardBtnAction(forwardBtn:UIButton)  {
//        webView.goForward()
//    }
    
    
    func webViewDidFinishLoad(_ webView: UIWebView) {
        
    }
    
    func webViewDidStartLoad(_ webView: UIWebView) {
        
    }
    
    func webView(_ webView: UIWebView, didFailLoadWithError error: Error) {
        setAlertShow(error: error as NSError?)
    }
    
    func setAlertShow(error: NSError?){
        let jsString = String(format:"alert(网络出错鸟)")
        webview.stringByEvaluatingJavaScript(from: jsString)

    }

    
}






