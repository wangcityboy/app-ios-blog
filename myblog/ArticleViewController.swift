

//
//  ArticleViewController.swift
//  guest
//
//
//
//  Created by 王海峰 on 15/8/7.
//  Copyright (c) 2015年 云飞凌风. All rights reserved.
//

import UIKit
import Alamofire
import SCLAlertView
import SwiftyJSON

class ArticleViewController:BaseViewController{
    
    var dataSource:[ArticleLists] = []
    var menuView: DropdownMenu!
    var tableView:UITableView!
    var classfyId:Int = 10006
    
    struct cellIdentifier {
        static let normalCell = "CellIdentifier";
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //添加导航栏
        RootTabBarVC.normal(navigationController: self.navigationController!)
        //初始化tableview
        _setupTableView()
        //初始化分类栏
        _initMenuView()
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        self.tableView.frame = CGRect(x:0, y:0, width:mainScreenWidth, height:mainScreenHeight-64-49);
        self.rdv_tabBarController.setTabBarHidden(false, animated: true)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}


extension ArticleViewController{
    
    func _initMenuView(){
        let items = ["全部日志", "iOS开发", "安卓开发","后台开发","前端开发", "测试开发", "IT技术","生活随笔","网络文摘"]
        
        self.navigationController?.navigationBar.isTranslucent = false
        self.navigationController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: UIColor.white]

        
        let menuView = DropdownMenu(navigationController: self.navigationController!, title: items.first!,items: items as [AnyObject])
        
        menuView.cellBackgroundColor = self.navigationController?.navigationBar.barTintColor
        menuView.cellSelectionColor = UIColor(red: 0.0/255.0, green:160.0/255.0, blue:195.0/255.0, alpha: 1.0)
        menuView.cellTextLabelColor = UIColor.white
        menuView.cellTextLabelFont = UIFont(name: "Avenir-Heavy", size: 20)
        menuView.arrowPadding = 15
        menuView.animationDuration = 0.5
        menuView.maskBackgroundColor = UIColor.black
        menuView.maskBackgroundOpacity = 0.3
        
        menuView.didSelectItemAtIndexHandler = {(indexPath: Int) -> () in
            self.classfyId = 10006+indexPath
            self.tableView.legendHeader.beginRefreshing()
            self.tableView.footer.isHidden = true
        }
        
        self.navigationItem.titleView = menuView
    }
    
    
    
    func _setupTableView() {
        tableView = UITableView()
        tableView.frame = CGRect(x:0, y:0, width:mainScreenWidth, height:mainScreenHeight);
        tableView.register(UITableViewCell.self, forCellReuseIdentifier:cellIdentifier.normalCell);
        self.view.addSubview(self.tableView)
        
        tableView.delegate = self
        tableView.dataSource = self
        
        self.tableView.addLegendHeader { () -> Void in
            self.tableView.footer.isHidden = true
            self.loadNewData()
        }
        
        self.tableView.legendHeader.beginRefreshing()
        
        self.tableView.addLegendFooter { () -> Void in
            self.loadMoreData()
            
        }
    }
    
    
    
    // MARK: 下拉刷新数据
    func loadNewData(){
        PAGE_NUM = 1
        loadDataSource(offset: PAGE_NUM,size: SHOW_NUM)
        
        let delayInSeconds:Int64 = 1000000000 * 1
        let time = DispatchTime.now() + Double(delayInSeconds) / Double(NSEC_PER_SEC)
        DispatchQueue.main.asyncAfter(deadline: time) {
                self.tableView.reloadData()
                // 拿到当前的下拉刷新控件，结束刷新状态
                self.tableView.header.endRefreshing()
                self.tableView.footer.isHidden = false
                UIApplication.shared.isNetworkActivityIndicatorVisible = false
        }
        
    }
    
    // MARK: 上拉加载数据
    func loadMoreData(){
        PAGE_NUM += 1
        loadDataSource(offset: PAGE_NUM,size: SHOW_NUM)
        let delayInSeconds:Int64 = 1000000000 * 2
        let time = DispatchTime.now() + Double(delayInSeconds) / Double(NSEC_PER_SEC)
        DispatchQueue.main.asyncAfter(deadline: time) {
            self.tableView.reloadData()
            self.tableView.footer.endRefreshing();
            UIApplication.shared.isNetworkActivityIndicatorVisible = false
        }

    }
    
    
    
    
    //抓取首页日志页面数据
    func loadDataSource(offset:Int, size:Int){
        let url = URL(string:classify_url)!
        let parameters = [
            "classify_id":self.classfyId,
            "page":offset,
            "pageSize":size
        ]
        Alamofire.request(url,method:.get,parameters:parameters).validate().responseJSON { response in
            switch response.result {
            case .success:
                if let value = response.result.value {
                    let json = JSON(value)["data"]
                    if self.PAGE_NUM == 1{
                        if !self.dataSource.isEmpty{
                            self.dataSource.removeAll(keepingCapacity: false)
                        }
                    }
                    if (JSON(value)["code"] == 200){
                        for (_,subJson):(String, JSON) in json {
                            let aItem = ArticleLists()
                            aItem.aId = subJson["tg_id"].string!
                            aItem.aTitle = subJson["tg_title"].string!
                            aItem.aImage = subJson["tg_image"].string!
                            aItem.aContent = subJson["tg_content"].string!
                            aItem.aUsername = subJson["tg_username"].string!
                            aItem.aReadcount = subJson["tg_readcount"].string!
                            aItem.aDate = subJson["tg_date"].string!
                            self.dataSource.append(aItem)
                        }
                    }else{
                        self.tableView.footer.isHidden = false
                        self.tableView.footer.noticeNoMoreData()
                        self.tableView.footer.setTitle("亲，加载完毕了，没有数据了", for: MJRefreshFooterStateNoMoreData)
                    }
                }
            case .failure:
                DispatchQueue.main.async {() -> Void in
                    SCLAlertView().showWarning("温馨提示", subTitle:"您的网络在开小差,赶紧制服它", closeButtonTitle:"去制服")
                    UIApplication.shared.isNetworkActivityIndicatorVisible = false
                    return
                }
            }
            
        }
        
    }
    

    
}



extension ArticleViewController:UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSource.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let article = dataSource[indexPath.row] as ArticleLists
        let cell = UITableViewCell(style: UITableViewCellStyle.default, reuseIdentifier:cellIdentifier.normalCell)
        
        let label1 = UILabel()
        label1.frame = CGRect(x: mainScreenWidth/4, y:0, width: mainScreenWidth*3/4, height: 70*3/5)
        label1.font = UIFont.boldSystemFont(ofSize: 15)
        label1.text = article.aTitle  as String
        cell.contentView.addSubview(label1)
        
        
        let label2 = UILabel()
        label2.frame = CGRect(x: mainScreenWidth/4, y: 70*3/5, width: mainScreenWidth/4, height: 70*2/5)
        label2.font = UIFont.boldSystemFont(ofSize: 12)
        label2.textColor = UIColor.gray
        label2.text = article.aUsername as String
        cell.contentView.addSubview(label2)
        
        
        let label3 = UILabel()
        label3.frame = CGRect(x: mainScreenWidth/2, y: 70*3/5, width:mainScreenWidth/4, height: 70*2/5)
        label3.font = UIFont.boldSystemFont(ofSize: 12)
        label3.textColor = UIColor.gray
        let dateString = (dataSource[indexPath.row] as ArticleLists).aDate as String
        label3.text = StringUtils.formatStrDate(strDate: dateString)
        cell.contentView.addSubview(label3)
        
        
        let label4 = UILabel()
        label4.frame = CGRect(x: mainScreenWidth-50, y: 70*3/5, width: 50, height: 70*2/5)
        label4.font = UIFont.boldSystemFont(ofSize: 12)
        label4.textColor = UIColor.gray
        label4.text = (article.aReadcount as String) + "浏览"
        cell.contentView.addSubview(label4)
        
        
        
        let url = article.aImage as String
        let _url = NSURL(string: server_url + url)
        let imageView = UIImageView();
        imageView.frame = CGRect(x: 5, y:5, width: mainScreenWidth*1/4-10, height: 60)
        imageView.contentMode = UIViewContentMode.scaleAspectFit
        imageView.sd_setImage(with: _url as URL!)
        cell.addSubview(imageView);
        
        return cell
    }
    
}

extension ArticleViewController:UITableViewDelegate{
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let detailCtrl = ArticleDetailViewController()
        let newsitem = self.dataSource[indexPath.row] as ArticleLists
        detailCtrl.articleList = newsitem
        detailCtrl.hidesBottomBarWhenPushed = true
        navigationController?.pushViewController(detailCtrl, animated: true)
    }
    
}

