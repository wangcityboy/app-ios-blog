//
//  UserInfoViewController.swift
//  YunfeiBlogs
//
//  Created by 王海峰 on 15/8/14.
//  Copyright (c) 2015年 云飞凌风. All rights reserved.
//

import UIKit


class UserInfoViewController: DismissViewController{
    
    var userList:[UserList] = []
    
    lazy private var tableView: UITableView = {
        let tableView = UITableView(frame: CGRect.zero, style: UITableViewStyle.grouped)
        tableView.delegate = self;
        tableView.dataSource = self;
        tableView.register(UserInfoTableViewCell.self, forCellReuseIdentifier: "UserInfoCell")
        tableView.register(TitleRImageMoreCell.self, forCellReuseIdentifier: "TitleRImageCell")
        return tableView;
    }();
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        print(userList)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "个人信息"
        
        self.tableView.frame = CGRect(x:0, y:0, width:mainScreenWidth, height:mainScreenHeight)
        self.view.addSubview(tableView)
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}


extension UserInfoViewController:UITableViewDelegate,UITableViewDataSource{
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        var row:NSInteger
        switch (section) {
        case 0:
            row = 7;
            break;
        default:
            row = 1;
            break;
        }
        return row;
    }
    
    
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if (indexPath.section == 0 && indexPath.row == 0) {
            let cell = tableView.dequeueReusableCell(withIdentifier: "TitleRImageCell") as! TitleRImageMoreCell;
            cell.accessoryType = .none
            cell.bgUrl = server_url + "/" + (userList[0].dFace)
            cell.name = "用户头像"
            return cell
        }else{
            let cell = tableView.dequeueReusableCell(withIdentifier: "UserInfoCell") as! UserInfoTableViewCell;
            cell.accessoryType = .none
            switch(indexPath.section){
            case 0:
                switch (indexPath.row) {
                case 1:
                    cell.titleLabel.text = "用户名"
                    cell.valueLabel.text = userList[0].dUsername as String
                case 2:
                    cell.titleLabel.text = "昵称"
                    cell.valueLabel.text = userList[0].dNickname as String
                    break;
                case 3:
                    cell.titleLabel.text = "性别"
                    if (userList[0].dSex as String) == "1" {
                        cell.valueLabel.text = "男"
                    }else{
                        cell.valueLabel.text = "女"
                    }
                    break;
                case 4:
                    cell.titleLabel.text = "Email"
                    cell.valueLabel.text = userList[0].dEmail as String
                    break;
                case 5:
                    cell.titleLabel.text = "QQ"
                    cell.valueLabel.text = userList[0].dQQ as String
                    break;
                case 6:
                    cell.titleLabel.text = "主页"
                    cell.valueLabel.text = userList[0].dUrl as String
                    break;
                default:
                    break;
                }
                break;
                
            case 1:
                cell.titleLabel.text = "个性签名"
                cell.valueLabel.text = userList[0].dAutograph as String
                break;
            default:
                break;
            }
            return cell;
        }
        
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 10
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 5
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        var cellHeight:CGFloat
        if (indexPath.section == 0 && indexPath.row == 0) {
            cellHeight = 70
        }else{
            cellHeight = 44
        }
        return cellHeight
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if(indexPath.section == 0 && indexPath.row == 0){
            showAlertDefault()
        }
    }
    
    
    func showAlertReset(){
        let alertControl = UIAlertController(title: "弹窗的标题", message: "Hello,showAlertReset ", preferredStyle: UIAlertControllerStyle.alert)
        let cancelAction = UIAlertAction(title: "取消操作", style: UIAlertActionStyle.destructive, handler: nil)
        let okAction     = UIAlertAction(title: "好的", style: UIAlertActionStyle.default, handler: nil)
        alertControl.addAction(cancelAction)
        alertControl.addAction(okAction)
        self.present(alertControl, animated: true, completion: nil)
    }
    
    
    func showAlertDefault(){
        let alertController = UIAlertController(title: "弹窗标题", message: "Hello, 这个是UIAlertController的默认样式", preferredStyle: UIAlertControllerStyle.alert)
        
        let cancelAction = UIAlertAction(title: "取消", style: UIAlertActionStyle.cancel, handler: nil)
        let okAction = UIAlertAction(title: "好的", style: UIAlertActionStyle.default, handler: nil)
        let resetAction = UIAlertAction(title: "重置", style: UIAlertActionStyle.destructive, handler: nil)
        
        alertController.addAction(resetAction)
        alertController.addAction(cancelAction)
        alertController.addAction(okAction)
        
        self.present(alertController, animated: true, completion: nil)
    }
    
}


