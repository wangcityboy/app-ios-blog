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

class ImageViewController:UIViewController,UITableViewDelegate,UITableViewDataSource,photoCellPushtoDetailDelegate{
    
    let limit:Int = 20
    var offset:Int = 0
    let tableView=UITableView()
    var dataArray = NSMutableArray()
    let wb = (UIScreen.main.bounds.width) / 750
    let refresh = UIRefreshControl()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        RootTabBarVC.normal(navigationController: self.navigationController!)
        title = "个人相册"
        loadPhotoData(fresh: false)
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        self.rdv_tabBarController.setTabBarHidden(false, animated: true)
    }
    
    
    func makeUI(){
        self.tableView.frame = CGRect.init(x: 0, y:0, width: self.view.frame.size.width, height: self.view.frame.size.height)
        tableView.delegate = self
        tableView.dataSource = self
        self.view.addSubview(tableView)
        tableView.register(PhotoTableViewCell().classForCoder, forCellReuseIdentifier:"photo")
        
        tableView.separatorStyle = UITableViewCellSeparatorStyle.none
        
        refresh.addTarget(self, action: #selector(ImageViewController.myrefresh), for: UIControlEvents.valueChanged)
        tableView.addSubview(refresh)
        
        
    }
    func myrefresh(){
        self.offset = self.offset + self.limit
        refresh.beginRefreshing()
        loadPhotoData(fresh: true)
    }
    
    
    func  loadPhotoData(fresh:Bool){
        Alamofire.request(photos_url,method:.get).validate().responseJSON { response in
            if let JSON = response.result.value  {
                let data : NSDictionary = (JSON as? NSDictionary)!
                 let array = data["data"] as? NSArray
                if(fresh){
                    self.dataArray.removeAllObjects()
                }
                for i in 0 ..< array!.count {
                    let model = PhotosModel().setPhotomodelData(data: array?.object(at: i) as! NSDictionary)
                    self.dataArray.add(model)
                }
                self.makeUI();
                self.tableView.reloadData()
                self.refresh.endRefreshing()
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
