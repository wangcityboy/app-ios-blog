//
//  LifeAssistantViewController.swift
//  YunfeiBlogs
//
//  Created by 王海峰 on 15/8/14.
//  Copyright (c) 2015年 云飞凌风. All rights reserved.
//

import UIKit

class LifeAssistantViewController: UIViewController {
    
    var tableView = UITableView();
    var scrollView = UIScrollView()
    var pageC = UIPageControl()
    var headerView = UIView()
    
    
    
    var titleArray = ["快递查询","火车时刻查询","生活日历","天气预报","汇率查询","手机归属地查询","IP地址归属地","记事本","PM2.5查询"];
    var imageArray = ["user_info_detail","user_info_tweet","user_info_project","user_info_music","user_info_topic"];
    var images = ["tianqi.jpg","kuaidi.jpg","huoche.jpg","huilv.jpg","shenghuorili.jpg"]
    
    
    
    lazy  var toolBar: UIView = {
        let toolBar = UIView();
        toolBar.backgroundColor = UIColor.white;
        toolBar.alpha = 0.95;
        
        let backButton = UIButton(frame: CGRect(x:0, y:0, width:40, height:40));
        backButton.setTitle("❮", for: .normal);
        backButton.setTitleColor(UIColor.applicationMainColor(), for: .normal);
        backButton.titleLabel?.font = UIFont.systemFont(ofSize: 28);
        backButton.addTarget(self, action: #selector(backButtonAction), for: .touchUpInside);
        toolBar.addSubview(backButton);
        
        return toolBar;
    }()
    
    func backButtonAction() {
        self.dismiss(animated: true, completion: nil)
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "生活助手"
        let image = UIImageView(frame: self.view.bounds)
        image.image = UIImage(named: "launch")
        self.view.addSubview(image)
        
        
        headerView.frame = CGRect(x:0, y:0, width:mainScreenWidth, height:mainScreenHeight*2/5-20-44)
        self.view.addSubview(headerView)
        
        
        
        scrollView.frame = CGRect(x:0, y:0, width:mainScreenWidth, height:headerView.height)
        scrollView.contentSize = CGSize(width: mainScreenWidth * 6, height: scrollView.frame.height)
        scrollView.isPagingEnabled = true
        scrollView.bounces = true
        scrollView.showsHorizontalScrollIndicator = false
        headerView.addSubview(scrollView)
        
        
        
        
        
        pageC.frame = CGRect(x:0, y:self.scrollView.bottom-15, width:mainScreenWidth, height:15)
        pageC.numberOfPages = self.images.count
        pageC.pageIndicatorTintColor = UIColor.red
        pageC.currentPageIndicatorTintColor = UIColor.white
        headerView.addSubview(pageC)
        
        
        
        for i in 1...self.images.count {
            let imageView = UIImageView(image:UIImage(named: images[i-1]))
            imageView.frame = CGRect(x:mainScreenWidth * CGFloat(i), y:0, width:mainScreenWidth, height:scrollView.frame.height)
            scrollView.addSubview(imageView)
        }
        
        
        
        self.scrollView.scrollRectToVisible(CGRect(x:mainScreenWidth, y:0, width:mainScreenWidth, height:headerView.height), animated: true)
        self.scrollView.delegate = self;
        
        
        
        
        let view1 = UIView(frame: CGRect(x:0, y:headerView.bottom+5, width:mainScreenWidth*2/3, height:mainScreenHeight/5))
        view1.backgroundColor = UIColor.purple
        view1.layer.cornerRadius = 10
        view1.layer.masksToBounds = true
        self.view.addSubview(view1)
        let lable1 = UILabel(frame: CGRect(x:0, y:(view1.height-30)/2, width:view1.width, height:30))
        lable1.text = "火车时刻查询"
        lable1.textColor = UIColor.white
        lable1.textAlignment = NSTextAlignment.center
        lable1.font = UIFont.systemFont(ofSize: 20)
        view1.addSubview(lable1)
        
        
        
        
        let view2 = UIView(frame: CGRect(x:view1.right+5, y:headerView.bottom+5, width:mainScreenWidth/3-5, height:mainScreenHeight/5))
        view2.layer.cornerRadius = 10
        view2.layer.masksToBounds = true
        view2.backgroundColor = UIColor.green
        self.view.addSubview(view2)
        let lable2 = UILabel(frame: CGRect(x:0, y:(view2.height-30)/2, width:view2.width, height:30))
        lable2.text = "记事本"
        lable2.textColor = UIColor.white
        lable2.textAlignment = NSTextAlignment.center
        lable2.font = UIFont.systemFont(ofSize: 20)
        view2.addSubview(lable2)
        
        
        
        
        let view3 = UIView(frame: CGRect(x:0, y:(view1.bottom+5), width:mainScreenWidth*2/3, height:mainScreenHeight/5))
        view3.backgroundColor = UIColor.blue
        view3.layer.cornerRadius = 10
        view3.layer.masksToBounds = true
        self.view.addSubview(view3)
        let lable3 = UILabel(frame: CGRect(x:0, y:(view3.height-30)/2, width:view3.width, height:30))
        lable3.text = "手机归属地查询"
        lable3.textColor = UIColor.white
        lable3.textAlignment = NSTextAlignment.center
        lable3.font = UIFont.systemFont(ofSize: 20)
        view3.addSubview(lable3)
        
        
        
        let view4 = UIView(frame: CGRect(x:view3.right+5, y:view1.bottom+5, width:mainScreenWidth/3-5, height:mainScreenHeight/5))
        view4.backgroundColor = UIColor.darkGray
        view4.layer.cornerRadius = 10
        view4.layer.masksToBounds = true
        self.view.addSubview(view4)
        let lable4 = UILabel(frame: CGRect(x:0, y:(view4.height-30)/2, width:view4.width, height:30))
        lable4.text = "生活日历"
        lable4.textColor = UIColor.white
        lable4.textAlignment = NSTextAlignment.center
        lable4.font = UIFont.systemFont(ofSize: 20)
        view4.addSubview(lable4)
        
        
        
        
        let view5 = UIView(frame: CGRect(x:0, y:view3.bottom+5, width:mainScreenWidth/3-5, height:mainScreenHeight/5))
        view5.backgroundColor = UIColor.magenta
        view5.layer.cornerRadius = 10
        view5.layer.masksToBounds = true
        self.view.addSubview(view5)
        let lable5 = UILabel(frame: CGRect(x:0, y:(view5.height-30)/2, width:view5.width, height:30))
        lable5.text = "天气预报"
        lable5.textColor = UIColor.white
        lable5.textAlignment = NSTextAlignment.center
        lable5.font = UIFont.systemFont(ofSize: 20)
        view5.addSubview(lable5)
        
        
        
        let view6 = UIView(frame: CGRect(x:view5.right+5, y:view3.bottom+5, width:mainScreenWidth/3, height:mainScreenHeight/5))
        view6.backgroundColor = UIColor.cyan
        view6.layer.cornerRadius = 10
        view6.layer.masksToBounds = true
        self.view.addSubview(view6)
        let lable6 = UILabel(frame: CGRect(x:0, y:(view6.height-30)/2, width:view6.width, height:30))
        lable6.text = "快递查询"
        lable6.textColor = UIColor.white
        lable6.textAlignment = NSTextAlignment.center
        lable6.font = UIFont.systemFont(ofSize: 20)
        view6.addSubview(lable6)
        
        
        
        
        let view7 = UIView(frame: CGRect(x:view6.right+5, y:view4.bottom+5, width:mainScreenWidth/3-5, height:mainScreenHeight/10-2.5))
        view7.backgroundColor = UIColor.orange
        view7.layer.cornerRadius = 10
        view7.layer.masksToBounds = true
        self.view.addSubview(view7)
        let lable7 = UILabel(frame: CGRect(x:0, y:(view7.height-30)/2, width:view7.width, height:30))
        lable7.text = "汇率查询"
        lable7.textColor = UIColor.white
        lable7.textAlignment = NSTextAlignment.center
        lable7.font = UIFont.systemFont(ofSize: 20)
        view7.addSubview(lable7)
        
        
        
        
        
        let view8 = UIView(frame: CGRect(x:view6.right+5, y:view7.bottom+5, width:mainScreenWidth/3-5, height:mainScreenHeight/10-2.5))
        view8.backgroundColor = UIColor.brown
        view8.layer.cornerRadius = 10
        view8.layer.masksToBounds = true
        self.view.addSubview(view8)
        let lable8 = UILabel(frame: CGRect(x:0, y:(view8.height-30)/2, width:view8.width, height:30))
        lable8.text = "PM2.5查询"
        lable8.textColor = UIColor.white
        lable8.textAlignment = NSTextAlignment.center
        lable8.font = UIFont.systemFont(ofSize: 20)
        view8.addSubview(lable8)
        
        
        
        toolBar.frame = CGRect(x: 0, y: mainScreenHeight-40, width: mainScreenWidth, height: 40);
        view.addSubview(toolBar);
        let tLable = UILabel(frame: CGRect(x:0, y:(toolBar.height-30)/2, width:toolBar.width, height:30))
        tLable.text = "我的生活助手"
        tLable.textColor = UIColor.red
        tLable.textAlignment = NSTextAlignment.center
        tLable.font = UIFont.systemFont(ofSize: 20)
        toolBar.addSubview(tLable)
        
        
    }
    
    
    
    func trashClick(){
        self.dismiss(animated: true, completion: nil)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}


extension LifeAssistantViewController:UIScrollViewDelegate{
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView){
        let w = self.scrollView.frame.width;
        let h = self.scrollView.frame.height;
        
        let page:Int = Int(self.scrollView.contentOffset.x/w)
        if(page == 0 ){
            self.scrollView.scrollRectToVisible(CGRect(x:CGFloat(images.count) * w, y:0, width:w, height:h), animated: false)
        }else if(page == images.count + 1){
            self.scrollView.scrollRectToVisible(CGRect(x:w, y:0, width:w, height:h), animated: false)
        }
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let w = self.scrollView.frame.width
        let page = self.scrollView.contentOffset.x/w
        pageC.currentPage = Int(page - 1)
    }
    
}

