//
//  UserInfoViewController.swift
//  YunfeiBlogs
//
//  Created by 王海峰 on 15/8/14.
//  Copyright (c) 2015年 云飞凌风. All rights reserved.
//

import UIKit
import SCLAlertView


class UserInfoViewController: DismissViewController,UIImagePickerControllerDelegate,UINavigationControllerDelegate,UIActionSheetDelegate{
    
    var userList:[UserList] = []
    
    lazy private var tableView: UITableView = {
        let tableView = UITableView(frame: CGRect.zero, style: UITableViewStyle.grouped)
        tableView.delegate = self;
        tableView.dataSource = self;
        tableView.register(UserInfoTableViewCell.self, forCellReuseIdentifier: "UserInfoCell")
        tableView.register(TitleRImageCell.self, forCellReuseIdentifier: "TitleRImageCell")
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
            let cell = tableView.dequeueReusableCell(withIdentifier: "TitleRImageCell") as! TitleRImageCell;
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
            myheadViewheadbuttonCLick()
        }
    }
    
    
    func myheadViewheadbuttonCLick() {
        let alertController = UIAlertController()
        //是否支持相机
        if UIImagePickerController.isSourceTypeAvailable(.camera) {
            alertController.addAction(UIAlertAction.init(title: "从相册中选取", style: .default, handler: { (action1:UIAlertAction) in
                let imagePickerController1 = UIImagePickerController()
                imagePickerController1.delegate = self
                imagePickerController1.allowsEditing = true
                imagePickerController1.sourceType = .photoLibrary
                self.present(imagePickerController1, animated: true, completion: nil)
            }))
            //相机
            alertController.addAction(UIAlertAction.init(title: "拍照", style: .default, handler: { (action2:UIAlertAction ) in
                let imagePickerController2 = UIImagePickerController()
                imagePickerController2.delegate = self
                imagePickerController2.allowsEditing = true
                imagePickerController2.sourceType = .camera
                self.present(imagePickerController2, animated: true, completion: nil)
            }))
            //取消
            alertController.addAction(UIAlertAction.init(title: "取消", style: .cancel, handler: { (action3:UIAlertAction ) in
                return
            }))
            self.present(alertController, animated: true, completion: nil)
        }else{
             SCLAlertView().showWarning("温馨提示", subTitle: "你的设备不支持手机拍照功能", closeButtonTitle: "确定")
        }
        
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        picker.dismiss(animated: true, completion: nil)
        let image:UIImage = info[UIImagePickerControllerEditedImage] as! UIImage
        
//        headview.headimage.setImage(image, for: .normal)
        
        picker.dismiss(animated: true, completion: nil)
        self .saveImage(image: image, name: "headView.png")
        
        
    }
    
    func saveImage(image:UIImage, name:String){
        let ImageData:Data = UIImageJPEGRepresentation(image, 0.8)!
        let fullPath:String = NSHomeDirectory() + "/Documents/" + name
        
        let imageNSDate: NSData = NSData.init(data: ImageData)
        imageNSDate.write(toFile: fullPath, atomically: true)
        
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


