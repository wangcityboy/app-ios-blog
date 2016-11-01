//
//  PhotoViewController.swift

//
//  Created by 王海峰 on 15/8/5.
//  Copyright (c) 2015年 云飞凌风. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
import SCLAlertView

class PhotoViewController:BaseViewController,UIWebViewDelegate {
    
    var dataSource:[PhotoDirList] = []
    var tableView:UITableView!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        RootTabBarVC.normal(navigationController: self.navigationController!)
        title = "个人相册"
        _setupTableView();
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
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


extension PhotoViewController{

    func _setupTableView() {
        tableView = UITableView()
        tableView.frame = CGRect(x:0, y:0, width:mainScreenWidth, height:mainScreenHeight);
        tableView.register(UITableViewCell.self, forCellReuseIdentifier:"CellIdentifier");
        self.view.addSubview(tableView)
        
        self.tableView.delegate = self
        self.tableView.dataSource = self
        
        self.tableView.addLegendHeader { () -> Void in
            self.loadNewData()
        }
        
        self.tableView.legendHeader.beginRefreshing()
        
        self.tableView.addLegendFooter { () -> Void in
            self.loadMoreData()
        }
        
        self.tableView.footer.isHidden = true
        
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
    
    func loadDataSource(offset:Int, size:Int){
        let url = dir_url + "?page=\(offset)&pageSize=\(size)"
        Alamofire.request(url,method:.get).validate().responseJSON { response in
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
                            let dirItem = PhotoDirList()
                            dirItem.dId = subJson["tg_id"].string!
                            dirItem.dName = subJson["tg_name"].string!
                            dirItem.dType = subJson["tg_type"].string!
                            dirItem.dContent = subJson["tg_content"].string!
                            dirItem.dFace = subJson["tg_face"].string!
                            dirItem.dDir = subJson["tg_dir"].string!
                            dirItem.dDate = subJson["tg_date"].string!
                            self.dataSource.append(dirItem)
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



extension PhotoViewController:UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSource.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = UITableViewCell(style: UITableViewCellStyle.default, reuseIdentifier:"CellIdentifier")
        
        let label1 = UILabel()
        label1.frame = CGRect(x: mainScreenWidth/3, y:0, width: mainScreenWidth*3/4, height: 70*3/5)
        label1.font = UIFont.boldSystemFont(ofSize: 15)
        label1.text = (dataSource[indexPath.row] as PhotoDirList).dName  as String
        cell.contentView.addSubview(label1)
        
        
        let label2 = UILabel()
        label2.frame = CGRect(x: mainScreenWidth/3, y: 60*3/5, width: mainScreenWidth*2/3, height: 70*2/5)
        label2.font = UIFont.boldSystemFont(ofSize: 12)
        label2.textColor = UIColor.gray
        let dateString = (dataSource[indexPath.row] as PhotoDirList).dDate as String
        label2.text = StringUtils.formatStrDate(strDate: dateString)
        cell.contentView.addSubview(label2)
        
        let url = (dataSource[indexPath.row] as PhotoDirList).dFace as String
        let _url = URL(string: server_url + url)
        let imageView = UIImageView();
        imageView.frame = CGRect(x: 5, y:10, width: mainScreenWidth/4, height: 50)
        imageView.sd_setImage(with: _url, placeholderImage: UIImage(named:"AppIcon"))
        imageView.layer.cornerRadius = 5.0;
        imageView.layer.masksToBounds = true
        cell.addSubview(imageView);
        
        return cell
    }
    
}


extension PhotoViewController:UITableViewDelegate{
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        let layout = ZLBalancedFlowLayout()
//        layout.sectionInset = UIEdgeInsets(top: 5, left: 5, bottom: 5, right: 5)
//        let newsitem  = dataSource[indexPath.row] as PhotoDirList
//        sid = newsitem.dId
//        
//        let viewController = PhotoCollectionViewController(collectionViewLayout: layout)
//        self.navigationController?.pushViewController(viewController, animated: true)
    }
}
