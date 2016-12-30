//
//  SettingViewController.swift
//  YunFeiLingFeng
//
//  Created by 王海峰 on 15/8/11.
//  Copyright (c) 2015年 云飞凌风. All rights reserved.
//

import UIKit
import SCLAlertView
import Alamofire
import SwiftyJSON


class ProfileViewController:UIViewController{
    
    var titleArray = [["个人信息"],["生活助手","我的项目","音乐之声","我的收藏"],["系统设置"]];
    var imageArray = [["user_info_detail"],["user_info_tweet","user_info_project","user_info_music","user_info_topic"],["user_info_set"]];
    
    
    var profileHeaderView:ProfileHeaderView!
    var tableView: UITableView!
    var userSource:[UserList] = []
    var bgSource:[BackgroundList] = []
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        _setupTableView()
        _loadBackgroundImage()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        _initHeaderView()
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}


extension ProfileViewController:HeaderViewDelegate,UIScrollViewDelegate{
    

    func _setupTableView() {
        tableView = UITableView(frame:CGRect(x:0, y:0, width:mainScreenWidth, height:mainScreenHeight-49), style: UITableViewStyle.plain);
        tableView.backgroundColor = UIColor.white
        tableView.delegate = self;
        tableView.dataSource = self;
        tableView.separatorStyle = UITableViewCellSeparatorStyle.none;
        self.view.addSubview(tableView);
        tableView.register(ProfileTableViewCell.self, forCellReuseIdentifier: "CellIdentifier");
        
        let headerView = ProfileHeaderView(frame: CGRect(x:0, y:0, width:mainScreenWidth, height:250));
        self.tableView.tableHeaderView = headerView;
        self.tableView.tableFooterView = UIView()
    }
    
    
    
    
    
    public func _initHeaderView(){
        profileHeaderView = self.tableView.tableHeaderView as! ProfileHeaderView
        profileHeaderView.delegate = self

       
        //判断用户是否登录--用户未登录
        if(((userDefaults.object(forKey: "nickname") as? String)) == nil){
            self.profileHeaderView.avatarImageURL = nil
            self.profileHeaderView.nickname = "立即登录"
            self.profileHeaderView.sex = nil
        }else{
            _loadUserData()
            self.profileHeaderView.avatarImageURL = NSURL(string:server_url+"/"+(userDefaults.object(forKey: "face") as? String)!)
            self.profileHeaderView.nickname = userDefaults.object(forKey: "nickname") as? String
            self.profileHeaderView.sex = userDefaults.object(forKey: "sex") as? String
        }
    }
    
    
    func headerViewheadbuttonClick() {            //用户未登录
        if(((userDefaults.object(forKey: "nickname") as? String)) == nil){
            let login = LoginViewController()
            let nextNV = UINavigationController(rootViewController: login)
            self.present(nextNV, animated: true, completion: nil)
        }else{
            print("登录后修改用户头像功能暂未开发")
        }
    }
    
    
    //获取网络背景图片
    func _loadBackgroundImage(){
        let url = URL(string: background_url)!
        Alamofire.request(url).validate().responseJSON { response in
            switch response.result {
            case .success:
                if let value = response.result.value {
                    let json = JSON(value)["data"]
                    let bgItem = BackgroundList()
                    bgItem.dId = json["tg_id"].string!
                    bgItem.dImage = json["tg_img"].string!
                    self.bgSource.append(bgItem)
                }
                self.profileHeaderView.bgurl = self.bgSource[0].dImage as String
            case .failure:
                DispatchQueue.main.async {() -> Void in
                    SCLAlertView().showWarning("温馨提示", subTitle:"您的网络在开小差,赶紧制服它", closeButtonTitle:"去制服")
                }
            }
        }

    }


    
    //获取登录用户个人信息
    func _loadUserData(){
        let url = URL(string:userinfo_url)!
        let username = userDefaults.object(forKey: "username") as? String
        let parameters = [
            "username":username!
        ]
        Alamofire.request(url,method:.get,parameters:parameters).validate().responseJSON { response in
            switch response.result {
            case .success:
                if let value = response.result.value {
                    let json = JSON(value)["data"][0]
                    if (JSON(value)["code"] == 200){
                            let uItem = UserList()
                            uItem.dUsername = json["tg_username"].string!
                            uItem.dNickname = json["tg_nickname"].string!
                            uItem.dEmail = json["tg_email"].string!
                            uItem.dQQ = json["tg_qq"].string!
                            uItem.dUrl = json["tg_url"].string!
                            uItem.dSex = json["tg_sex"].string!
                            uItem.dFace = json["tg_face"].string!
                            uItem.dAutograph = json["tg_autograph"].string!
                            self.userSource.append(uItem)
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
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        self.profileHeaderView.scrollViewDidScroll(scrollView)
    }
    
}





extension ProfileViewController:UITableViewDataSource,UITableViewDelegate{
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return self.titleArray.count
    }
    
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 10
    }
    

    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.titleArray[section].count
    }
    
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "CellIdentifier") as! ProfileTableViewCell;
        cell.lineView.isHidden = true;
        
        
        if(indexPath.section == 1){
            cell.lineView.isHidden = false;
        }
        
        if(indexPath.section == 1 && indexPath.row == 3){
            cell.lineView.isHidden = true;
        }
        
        cell.accessoryType = UITableViewCellAccessoryType.disclosureIndicator
        cell.headImageView?.image = UIImage(named: self.imageArray[indexPath.section][indexPath.row] as String)
        cell.titleLabel?.text = self.titleArray[indexPath.section][indexPath.row] as String
        
        
        return cell
    }
    
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath){
        
        let section = indexPath.section
        let row = indexPath.row
        
        if(section == 0 && row == 0){
            if(userDefaults.object(forKey: "nickname") != nil){
                let userinfo = UserInfoViewController()
                userinfo.userList = self.userSource
                let nextNV = UINavigationController(rootViewController: userinfo)
                self.present(nextNV, animated: true, completion: nil)
            }else{
                let login = LoginViewController()
                let nextNV = UINavigationController(rootViewController: login)
                self.present(nextNV, animated: true, completion: nil)
            }
        }
        
        
        if(section == 1 && row == 0){
            let life = LifeAssistantViewController()
            self.present(life, animated: true, completion: nil)
        }
        
        
        if(section == 1 && row == 1){
            let project = ProjectViewController()
            let nextNV = UINavigationController(rootViewController: project)
            self.present(nextNV, animated: true, completion: nil)
        }
        
        if(section == 1 && row == 2){
            SCLAlertView().showInfo("温馨提示", subTitle:"对不起，音乐收听功能正在开发中，请持续关注我们！", closeButtonTitle:"我知道了")
        }
        
        if(section == 1 && row == 3){
            SCLAlertView().showInfo("温馨提示", subTitle:"对不起，日志收藏功能正在开发中，请持续关注我们！", closeButtonTitle:"我知道了")
        }
        
        
        if(section == 2 && row == 0){
            let setting = SettingViewController();
            let nextNV = UINavigationController(rootViewController: setting)
            self.present(nextNV, animated: true, completion: nil)
        }
        
    }
    
    
    
    
}



