//
//  ViewController.swift
//  guest
//
//  Created by 王海峰 on 15/8/14.
//  Copyright (c) 2015年 云飞凌风. All rights reserved.
//

import UIKit
import SCLAlertView
import Alamofire
import Foundation
import SwiftyJSON

class HomeViewController: UIViewController,SliderGalleryControllerDelegate {
    
    //首页日志列表
    var dataSource:[ArticleLists] = []
    var tableView = UITableView()
    
    //图片轮播组件
    var sliderGallery : SliderGalleryController!
    var images = Array<String>()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        RootTabBarVC.normal(navigationController: self.navigationController!)
        self.title = "首页"
        _setupTableView();
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.rdv_tabBarController.setTabBarHidden(false, animated: false)
        self.tableView.frame = CGRect(x:0, y:0, width:mainScreenWidth, height:mainScreenHeight-64-49);
        
    }
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    




     func _setupTableView() {
        tableView.frame = CGRect(x:0, y:0, width:mainScreenWidth, height:mainScreenHeight);
        tableView.register(UITableViewCell.self, forCellReuseIdentifier:"CellIdentifier");
        self.view.addSubview(tableView)
        self.tableView.delegate = self
        self.tableView.dataSource = self
        
        /* 进入刷新状态就会自动调用这个block (下拉刷新) */
        self.tableView.addLegendHeader { () -> Void in
            self.loadNewData();
        }
        
        /* 进入刷新状态 */
        self.tableView.legendHeader.beginRefreshing()
        
        
        /* 进入刷新状态就会自动调用这个block （上拉刷新） */
        self.tableView.addLegendFooter { () -> Void in
            self.loadMoreData()
        }
        
        self.tableView.footer.isHidden = true
    }
    
    
    // mark: 下拉刷新数据
    func loadNewData(){
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        loadDataSource(from: "header",fresh: true)
        loadAdvertiseData(fresh: true)
    }
    
    // mark: 上拉加载更多数据，首页只能最多显示20条，第一次加载就已经加载所有数据
    func loadMoreData(){
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        loadDataSource(from: "footer",fresh: true)
    }
    
    // 加载tableview广告轮播图
    func loadHeadView(){
        
        //初始化图片轮播组件
        sliderGallery = SliderGalleryController()
        sliderGallery.delegate = self
        sliderGallery.view.frame = CGRect(x: 0, y: 0, width: screenWidth,height: screenHeight/3);
        
        //将图片轮播组件添加到当前视图
        self.addChildViewController(sliderGallery)
        tableView.tableHeaderView = sliderGallery.view
        
        //添加组件的点击事件
        let tap = UITapGestureRecognizer(target: self,action: #selector(handleTapAction))
        sliderGallery.view.addGestureRecognizer(tap)

    }
    
    //图片轮播组件协议方法：获取内部scrollView尺寸
    func galleryScrollerViewSize() -> CGSize {
        return CGSize(width: screenWidth, height: mainScreenHeight/3)
    }
    


    //图片轮播组件协议方法：获取数据集合
    func galleryDataSource() -> [String] {
        return self.images
    }
    
    //点击事件响应
    func handleTapAction(_ tap:UITapGestureRecognizer)->Void{
        //获取图片索引值
        let index = sliderGallery.currentIndex
        //弹出索引信息
        let alertController = UIAlertController(title: "您点击的图片索引是：",message: "\(index)", preferredStyle: .alert)
        let cancelAction = UIAlertAction(title: "确定", style: .cancel, handler: nil)
        alertController.addAction(cancelAction)
        self.present(alertController, animated: true, completion: nil)
    }
    
    

    //获取首页日志页面数据
    func loadDataSource(from:String,fresh:Bool){
        let url = URL(string:article_url)!
        Alamofire.request(url).validate().responseJSON { response in
            switch response.result.isSuccess {
            case true:
                if let value = response.result.value {
                    let json = JSON(value)["data"]
                    if(fresh){
                        self.dataSource.removeAll(keepingCapacity: false)
                    }
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
                    DispatchQueue.main.async {() -> Void in
                        self.tableView.reloadData()
                        if from == "header" {
                            // 拿到当前的下拉刷新控件，结束刷新状态
                            self.tableView.header.endRefreshing()
                            self.tableView.footer.isHidden = false
                        }else {
                            self.tableView.footer.endRefreshing();
                            self.tableView.footer.noticeNoMoreData()
                        }
                        UIApplication.shared.isNetworkActivityIndicatorVisible = false
                    }
                }
            case false:
                DispatchQueue.main.async {() -> Void in
                    SCLAlertView().showWarning("温馨提示", subTitle:"您的网络在开小差,赶紧制服它", closeButtonTitle:"去制服")
                    UIApplication.shared.isNetworkActivityIndicatorVisible = false
                    return
                }
            }
        }
    }

    

    
    
    //获取网络广告轮播图
    func loadAdvertiseData(fresh:Bool){
        let loadURL = URL(string: advertise_url)!
        Alamofire.request(loadURL).validate().responseJSON { response in
            switch response.result.isSuccess {
            case true:
                if let value = response.result.value {
                    let json = JSON(value)["data"]
                    if (fresh){
                        self.images.removeAll(keepingCapacity: false)
                    }
                    for (_,subJson):(String, JSON) in json {
                        let advertiseItem = AdvertiseList()
                        advertiseItem.dId = subJson["tg_id"].string!
                        advertiseItem.dImage = subJson["tg_image"].string!
                        advertiseItem.dContent = subJson["tg_content"].string!
                        advertiseItem.dUrl = subJson["tg_url"].string!
                        self.images.append(server_url + (advertiseItem.dImage as String))
                    }
                    //异步处理，并返回主线程
                    DispatchQueue.main.async {() -> Void in
                        self.loadHeadView()
                        self.tableView.reloadData()
                        UIApplication.shared.isNetworkActivityIndicatorVisible = false
                    }
                }
            case false:
                DispatchQueue.main.async {() -> Void in
                    SCLAlertView().showWarning("温馨提示", subTitle:"您的网络在开小差,赶紧制服它", closeButtonTitle:"去制服")
                    UIApplication.shared.isNetworkActivityIndicatorVisible = false
                    self.tableView.header.endRefreshing()
                }
            }
        }

    }
    
    
}
    

extension HomeViewController:UITableViewDelegate,UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat{
        return 70
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSource.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: UITableViewCellStyle.subtitle, reuseIdentifier: "CellIdentifier")
        let label1 = UILabel()
        label1.frame = CGRect(x: mainScreenWidth/4, y:0, width: mainScreenWidth*3/4, height: 70*3/5)
        label1.font = UIFont.boldSystemFont(ofSize: 15)
        label1.text = (dataSource[indexPath.row] as ArticleLists).aTitle as String
        cell.contentView.addSubview(label1)
        
        
        let label2 = UILabel()
        label2.frame = CGRect(x: mainScreenWidth/4, y: 70*3/5, width: mainScreenWidth/4, height: 70*2/5)
        label2.font = UIFont.boldSystemFont(ofSize: 12)
        label2.textColor = UIColor.gray
        label2.text = (dataSource[indexPath.row] as ArticleLists).aUsername as String
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
        label4.text = ((dataSource[indexPath.row] as ArticleLists).aReadcount as String) + "浏览"
        cell.contentView.addSubview(label4)
        
        let url = (dataSource[indexPath.row] as ArticleLists).aImage as String
        let _url = NSURL(string: server_url + url)
        let imageView = UIImageView();
        imageView.frame = CGRect(x: 5, y:5, width: mainScreenWidth/4-10, height: 60)
        imageView.contentMode = UIViewContentMode.scaleAspectFit
        imageView.sd_setImage(with: _url as URL!)
        cell.addSubview(imageView);
        return cell
        
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let newsitem = self.dataSource[indexPath.row] as ArticleLists
        let detailCtrl = HomeDetailViewController()
        detailCtrl.articleList = newsitem
        self.navigationController?.pushViewController(detailCtrl, animated: true)
    }
}









    


