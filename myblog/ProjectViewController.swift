//
//  MyProjectViewController.swift
//
//  Created by 王海峰 on 15/8/29.
//  Copyright (c) 2015年 云飞凌风. All rights reserved.
//

import UIKit
import Alamofire
import SCLAlertView
import SwiftyJSON


class ProjectViewController: DismissViewController{
    
    
    var titleArray = ["PP助手","开源中国","欧浦钢网","百度音乐","悦你社区"];
    
    var cellHeights = [CGFloat]();
    var projectlists = NSArray();
    
    var dataSource:[ProjectList] = []
    var tableView = UITableView()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        _reloadDataSource()
       
        self.title = "我的项目"
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}

extension ProjectViewController{
    
    func  _setupTableView(){
        
        tableView.frame = CGRect(x:0, y:0, width:mainScreenWidth, height:mainScreenHeight);
        tableView.register(ProjectTableViewCell.self, forCellReuseIdentifier: "companyCell");
        self.view.addSubview(self.tableView)
        
        let cell = ProjectTableViewCell(style: .default, reuseIdentifier: nil);
        self.cellHeights = [CGFloat]();
        self.cellHeights.append(cell.cellHeight());
        self.tableView.delegate = self
        self.tableView.dataSource = self
        
    }
    
    
    func _configureCell(cell: ProjectTableViewCell, forProject project: ProjectList) {
        print(project)
        let imageurl = server_url + (project.image as String)
        cell.imageURL = NSURL(string: imageurl);
        cell.title = project.title as String
        cell.subtitle = project.subtitle as String
        cell.starNumber = Int.init(project.rating)!
    }
    
    
    func _reloadDataSource() {
        let url = URL(string:project_url)!
        Alamofire.request(url,method:.get,parameters:nil).validate().responseJSON { response in
            switch response.result {
            case .success:
                if let value = response.result.value {
                    let json = JSON(value)["data"]
                    if (JSON(value)["code"] == 200){
                        for (_,subJson):(String, JSON) in json {
                            let pItem = ProjectList()
                            pItem.image = subJson["tg_img"].string!
                            pItem.title = subJson["tg_title"].string!
                            pItem.subtitle = subJson["tg_subtitle"].string!
                            pItem.rating = subJson["tg_rating"].string!
                            pItem.progress = subJson["tg_progress"].string!
                            self.dataSource.append(pItem)
                        }
                        self._setupTableView()
                    }else{
                        SCLAlertView().showWarning("温馨提示", subTitle:"用户资料获取失败", closeButtonTitle:"确定")
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

extension ProjectViewController:UITableViewDelegate,UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.dataSource.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "companyCell") as! ProjectTableViewCell;
        let project = dataSource[indexPath.row]
        _configureCell(cell: cell, forProject: project);
        return cell;
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return cellHeights[0]
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath){
        if(indexPath.row == 0){
            print("index")
        }
    }
    
    
    
}
