//
//  IndexViewController.swift
//  myblog
//
//  Created by chinaskin on 16/11/10.
//  Copyright © 2016年 wanghaifeng. All rights reserved.
//

import UIKit
import SCLAlertView
import Alamofire
import Foundation
import SwiftyJSON
import DGElasticPullToRefresh

class IndexViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
    
    let tableView=UITableView()
    var dataArray = NSMutableArray()
    let wb = (UIScreen.main.bounds.width) / 750
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        self.automaticallyAdjustsScrollViewInsets = false
        self.navigationController?.isNavigationBarHidden = true
        loadHomeInfo();

    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        self.rdv_tabBarController.setTabBarHidden(false, animated: false)
        self.navigationController?.isNavigationBarHidden = true
    }
    
    
    
    
    /// 获取首页数据
    func loadHomeInfo() -> () {
        Alamofire.request(article_url).responseJSON { response in
            if let JSON = response.result.value  {
                let dict : NSDictionary = (JSON as? NSDictionary)!
                let array = dict["data"] as? NSArray
                for i in 0 ..< array!.count {
                    let model = Indexmodel().setIndexmodelData(data: array?.object(at: i) as! NSDictionary)
                    self.dataArray.add(model)
                }
                self.makeUI();
                self.tableView.reloadData()
            }
        }
    }
    
    
    
    func makeUI(){
        
        self.tableView.frame = CGRect.init(x: 0, y: 0, width: self.view.frame.size.width, height: self.view.frame.size.height)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorStyle = UITableViewCellSeparatorStyle.none
        self.view.addSubview(tableView)
        tableView.register(IndexTableCell().classForCoder, forCellReuseIdentifier: "id")
        
        
        let loadingView = DGElasticPullToRefreshLoadingViewCircle()
        loadingView.tintColor = UIColor(red: 78/255.0, green: 221/255.0, blue: 200/255.0, alpha: 1.0)
        tableView.dg_addPullToRefreshWithActionHandler({
            self.loadHomeInfo()
            
            self.tableView.dg_stopLoading()
            }, loadingView: loadingView)
        
        tableView.dg_setPullToRefreshFillColor(UIColor.red)
        tableView.dg_setPullToRefreshBackgroundColor(UIColor.blue)
        
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return  self.dataArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        var cell = IndexTableCell()
        cell = tableView.dequeueReusableCell(withIdentifier: "id", for: indexPath) as! IndexTableCell
        
        
        cell.selectionStyle = UITableViewCellSelectionStyle.none
        cell.textLabel?.textColor = UIColor.black
        
        let num :Int = indexPath.row
        let a:Indexmodel = self.dataArray.object(at: num) as! Indexmodel
        cell.setData(model:a)
        
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 320*wb
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let num :Int = indexPath.row
        let model:Indexmodel = self.dataArray.object(at: num) as! Indexmodel
        let vc = IndexDetailViewController()
        vc.indexmodel = model
        self.navigationController?.pushViewController(vc, animated: true)
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

