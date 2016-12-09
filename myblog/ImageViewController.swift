//
//  ImageViewController.swift
//  myblog
//
//  Created by chinaskin on 16/10/29.
//  Copyright © 2016年 wanghaifeng. All rights reserved.
//

import UIKit
import Alamofire
import DGElasticPullToRefresh
import SwiftyJSON
import SCLAlertView

class ImageViewController:BaseViewController,UITableViewDelegate,UITableViewDataSource,photoCellPushtoDetailDelegate{
    
    let tableView=UITableView()
    var dataArray = NSMutableArray()
    let wb = mainScreenWidth / 750

    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        RootTabBarVC.normal(navigationController: self.navigationController!)
        title = "个人相册"
        _setupTableView()
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        self.rdv_tabBarController.setTabBarHidden(false, animated: true)
    }
    
    
    func _setupTableView(){
        self.tableView.frame = CGRect.init(x: 0, y:0, width: mainScreenWidth, height: mainScreenHeight-44-64)
        tableView.delegate = self
        tableView.dataSource = self
        self.view.addSubview(tableView)
        tableView.register(PhotoTableViewCell().classForCoder, forCellReuseIdentifier:"photo")
        
        tableView.separatorStyle = UITableViewCellSeparatorStyle.none
        
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
        loadPhotoData(offset: PAGE_NUM,size: SHOW_NUM)
        
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
        loadPhotoData(offset: PAGE_NUM,size: SHOW_NUM)
        let delayInSeconds:Int64 = 1000000000 * 2
        let time = DispatchTime.now() + Double(delayInSeconds) / Double(NSEC_PER_SEC)
        DispatchQueue.main.asyncAfter(deadline: time) {
            self.tableView.reloadData()
            self.tableView.footer.endRefreshing();
            UIApplication.shared.isNetworkActivityIndicatorVisible = false
        }
    }
    
    
    func  loadPhotoData(offset:Int, size:Int){
        let parameters = [
            "page":offset,
            "pageSize":size
        ]
        Alamofire.request(photos_url,method:.get,parameters:parameters).validate().responseJSON { response in
            switch response.result {
                case .success:
                    if let value = response.result.value  {
                        let data : NSDictionary = (value as? NSDictionary)!
                        let array = data["data"] as? NSArray
                        if(self.PAGE_NUM == 1){
                            self.dataArray.removeAllObjects()
                        }
                    
                        if (JSON(value)["code"] == 200){
                            for i in 0 ..< array!.count {
                                let model = PhotosModel().setPhotomodelData(data: array?.object(at: i) as! NSDictionary)
                                self.dataArray.add(model)
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
    
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return  self.dataArray.count/2
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = PhotoTableViewCell()
        cell = tableView.dequeueReusableCell(withIdentifier:"photo", for: indexPath) as! PhotoTableViewCell
        
        cell.selectionStyle = .none
        cell.textLabel?.textColor = UIColor.black
        cell.delegate = self
        
        let num :Int = indexPath.row
        
        let left:PhotosModel = self.dataArray.object(at:num*2) as! PhotosModel
        cell.setliftView(model: left)
        
        let right:PhotosModel = self.dataArray.object(at:num*2+1) as! PhotosModel
        cell.setrightView(model: right)
        
        cell.tag = indexPath.row
        
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 350 * wb
    }

    
    func photoCellPushtoDetail(isleft: Bool, tag: Int) {
        let vc = PhotoDetailViewController()
        if(isleft){
            let leftModel:PhotosModel = self.dataArray.object(at:tag*2) as! PhotosModel
            vc.model = leftModel
        }else{
            let rightModel:PhotosModel = self.dataArray.object(at:tag*2+1) as! PhotosModel
            vc.model = rightModel
        }
        self.navigationController?.pushViewController(vc, animated: true)
    }

    
    
}
