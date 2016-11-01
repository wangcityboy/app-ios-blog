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

class ImageViewController:UIViewController{
    
    let limit:Int = 20
    var offset:Int = 0
    let tableView=UITableView()
    var dateArray = NSMutableArray()
    let wb = (UIScreen.main.bounds.width) / 750
    let refresh = UIRefreshControl()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        RootTabBarVC.normal(navigationController: self.navigationController!)
        title = "个人相册"
        loaddanpinData()
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        self.tableView.frame = CGRect(x:0, y:0, width:mainScreenWidth, height:mainScreenHeight-64-49);
        self.rdv_tabBarController.setTabBarHidden(false, animated: true)
    }
    
    
    func makeUI(){
        self.tableView.frame = CGRect.init(x: 0, y:64, width: self.view.frame.size.width, height: self.view.frame.size.height-64-44)
//        tableView.delegate = self
//        tableView.dataSource = self
        self.view.addSubview(tableView)
        tableView.register(PhotoTableViewCell().classForCoder, forCellReuseIdentifier:"photo")
        
        tableView.separatorStyle = UITableViewCellSeparatorStyle.none
        
        refresh.addTarget(self, action: #selector(ImageViewController.myrefresh), for: UIControlEvents.valueChanged)
        tableView.addSubview(refresh)
        
        
    }
    func myrefresh(){
        self.offset = self.offset + self.limit
        refresh.beginRefreshing()
        
    }
    
    
    func  loaddanpinData(){
//        let url = photos_url + "?page=\(offset)&pageSize=\(size)"
        Alamofire.request(photos_url,method:.get).validate().responseJSON { response in
//            switch response.result {
//            case .success:
//                if let value = response.result.value {
//                    let json = JSON(value)["data"]
////                    print(json)
//                    if (JSON(value)["code"] == 200){
//                        
//                        for i in 0 ..< json.count {
//                            print(json[i])
//                            
////                            let arr = Array?.object(at: i)
//                            let arr = json[i] as! NSArray
//                            
//                            let model = PhotosModel.setPhotomodelData(arr)
//                        }
//                        
////                        for (_,subJson):(String, JSON) in json {
////                                let model = PhotosModel.setPhotomodelData(subJson)
////                                print(model)
////                                self.dateArray.add(model)
////                        }
//                    }
//                }
//            case .failure:
//                DispatchQueue.main.async {() -> Void in
//                    SCLAlertView().showWarning("温馨提示", subTitle:"您的网络在开小差,赶紧制服它", closeButtonTitle:"去制服")
//                    UIApplication.shared.isNetworkActivityIndicatorVisible = false
//                    return
//                }
//            }
        
            
            //  print(response.request)  // original URL request
            //  print(response.response) // HTTP URL response
            // print(response.data)     // server data
            // print(response.result)   // result of response serialization
            if let JSON = response.result.value  {
                let dict : NSDictionary = (JSON as? NSDictionary)!
                 let json = dict["data"] as! NSArray
                
                print(json)
                
                for i in 0 ..< json.count {
                        print(json[i])
                        let arr = json[i] as! NSDictionary
                    print(arr["tg_face"] as?String)
                        let model = PhotosModel.setPhotomodelData(json[i]?.object(at: i) as! NSDictionary)
                    print(model)
                    }
            
//                for (_,subJson):(String, JSON) in json {
//                    let model = PhotosModel.setPhotomodelData(data: subJson)
//                    print(model)
//                    self.dateArray.add(model)
//                    
//                }

                
//                let model = giftModel().setgiftModelData(data: dict["data"])
//                print(model)
//                self.dateArray.add(model)
                self.makeUI();
                self.tableView.reloadData()
                self.refresh.endRefreshing()
            }
        }
    }
    
    
    
//    func numberOfSections(in tableView: UITableView) -> Int {
//        return 1
//    }
//    
//    
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        //print(self.dateArray.count*10)
//        return  self.dateArray.count * 10
//        
//    }
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        var cell = PhotoTableViewCell()
//        cell = tableView.dequeueReusableCell(withIdentifier:"photo", for: indexPath) as! PhotoDetailCell
//        
//        
//        cell.selectionStyle = .none
//        cell.textLabel?.textColor = UIColor.black
//        cell.delegate = self
//        
//        let num :Int = indexPath.row/10
//        let model:giftModel = self.dateArray.object(at: num) as! giftModel
//        // let a :giftInnerModel = model.items?.object(at:indexPath.row%20) as! giftInnerModel
//        
//        
//        // cell.textLabel?.text = a.name
//        //因为一次请求20个 所以单个情况暂时不写
//        if ((model.items?.count)!*(self.dateArray.count)) > indexPath.row*2 {
//            let  row = indexPath.row*2;
//            let a :giftInnerModel = model.items?.object(at:row%20) as! giftInnerModel
//            cell.setliftView(model: a)
//            cell.liftView.tag = row
//            cell.tag = indexPath.row
//            
//            //cell.liftView.name.text = String(indexPath.row)
//        }
//        
//        if ((model.items?.count)!*(self.dateArray.count)) > (indexPath.row*2 + 1) {
//            let  row = indexPath.row*2 + 1;
//            let a :giftInnerModel = model.items?.object(at:row%20) as! giftInnerModel
//            cell.setrightView(model: a)
//            cell.rightView.tag = row
//            cell.tag = indexPath.row
//        }
//        
//        //print(a.mydescription)
//        
//        return cell
//    }
//    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//        return 520 * wb
//    }

    
    
    
}
