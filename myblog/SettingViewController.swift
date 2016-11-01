//
//  SettingViewController.swift
//
//  Created by 王海峰 on 15/8/11.
//  Copyright (c) 2015年 云飞凌风. All rights reserved.


import UIKit
import MessageUI
import SDWebImage



class SettingViewController: DismissViewController,MFMailComposeViewControllerDelegate {
    
    lazy  var tableView: UITableView = {
        let tableView = UITableView(frame: CGRect.zero, style: UITableViewStyle.grouped)
        tableView.delegate = self;
        tableView.dataSource = self;
        tableView.isScrollEnabled = false;
        return tableView;
    }();
    
    
    
    lazy  var logoutButton: UIButton = {
        let button = UIButton();
        button.layer.cornerRadius = 5;
        button.backgroundColor = UIColor.applicationMainColor();
        button.setTitle("注销登录", for: .normal);
        button.setTitleColor(UIColor.white, for: .normal);
        button.setTitleColor(UIColor.gray, for: .selected);
        button.addTarget(self, action: #selector(logoutButtonAction), for: .touchUpInside);
        return button;
    }();
    
    
    override func viewDidLoad() {
        super.viewDidLoad();
        self.title = "系统设置";
        automaticallyAdjustsScrollViewInsets = false;
        self.view.backgroundColor = UIColor.applicationBackgroundColor();
        
        layoutViews();
    }
    
    
    
}

extension SettingViewController: UITableViewDelegate,UITableViewDataSource {
    
    public func numberOfSections(in tableView: UITableView) -> Int{
        return 2
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 44;
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if(section == 0){
            return 4
        }else{
            return 6
        }
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = UITableViewCell(style: UITableViewCellStyle.default, reuseIdentifier: nil);
        cell.selectionStyle = .none;
        cell.accessoryType = .disclosureIndicator;
        cell.textLabel?.frame = CGRect(x:10, y:0, width:100, height:44)
        
        var title: String = "";
        
        if (indexPath.section == 0  && indexPath.row == 0) {
            title = "意见反馈"
        }else if (indexPath.section == 0  && indexPath.row == 1) {
            title = "我去好评"
        }else if (indexPath.section == 0  && indexPath.row == 2) {
            title = "清除缓存"
            cell.accessoryType = UITableViewCellAccessoryType.none
            
            let  cacheLabel = UILabel()
            cacheLabel.frame = CGRect(x:mainScreenWidth-90, y:14/2, width:60, height:30.0);
            cacheLabel.textAlignment = NSTextAlignment.right
            cacheLabel.font = UIFont.systemFont(ofSize: 16)
            cell.addSubview(cacheLabel)
            let cacheSize = FileUtils.calcFoldSize()
            cacheLabel.text = StringUtils.formatFileSize(sizeInB: cacheSize)
            
        }else if (indexPath.section == 0  && indexPath.row == 3){
            title = "当前版本"
            cell.accessoryType = UITableViewCellAccessoryType.none
            
            let  version = UILabel()
            version.frame = CGRect(x:mainScreenWidth-90, y:14/2, width:60, height:30.0);
            version.text = "1.0.0"
            version.textAlignment = NSTextAlignment.right
            version.font = UIFont.systemFont(ofSize: 16)
            cell.addSubview(version)
        }
        
        if (indexPath.section == 1  && indexPath.row == 0) {
            title = "新浪微博"
            
            let  sina = UILabel()
            sina.frame = CGRect(x:120, y:14/2, width:mainScreenWidth-170, height:30.0);
            sina.text = "@云飞凌风"
            sina.textAlignment = NSTextAlignment.right
            sina.font = UIFont.systemFont(ofSize: 14)
            cell.addSubview(sina)
            
        }else if(indexPath.section == 1  && indexPath.row == 1){
            title = "微信账号"
            
            let  weixin = UILabel()
            weixin.frame = CGRect(x:120, y:14/2, width:mainScreenWidth-170, height:30.0);
            weixin.text = "lovelyfeng"
            weixin.textAlignment = NSTextAlignment.right
            weixin.font = UIFont.systemFont(ofSize: 14)
            cell.addSubview(weixin)
            
        }else if(indexPath.section == 1  && indexPath.row == 2){
            title = "个人博客"
            
            let  boke = UILabel()
            boke.frame = CGRect(x:120, y:14/2, width:mainScreenWidth-170, height:30.0);
            boke.text = "http://wanghaifeng.net"
            boke.textAlignment = NSTextAlignment.right
            boke.font = UIFont.systemFont(ofSize: 14)
            cell.addSubview(boke)
            
        }else if(indexPath.section == 1  && indexPath.row == 3){
            title = "关于作者"
            let  concact = UILabel()
            concact.frame = CGRect(x:120, y:14/2, width:mainScreenWidth-170, height:30.0);
            concact.text = "查看了解更多"
            concact.textAlignment = NSTextAlignment.right
            concact.font = UIFont.systemFont(ofSize: 14)
            cell.addSubview(concact)
            
        }
        
        cell.textLabel?.text = title;
        return cell;
    }
    
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        var nextViewController  = UIViewController();
        
        if (indexPath.section == 0 && indexPath.row == 0) {
            //意见反馈
            sendEmailAction()
            
        }else if (indexPath.section == 0 && indexPath.row == 1) {
            //我去好评
            let evaluateString = "http://itunes.apple.com/WebObjects/MZStore.woa/wa/viewContentsUserReviews?id=94671730&pageNumber=0&sortOrdering=2&type=Purple+Software&mt=8"
            UIApplication.shared.openURL(URL(string: evaluateString)!)
            
        }else if(indexPath.section == 0 && indexPath.row == 2){
            //清除缓存
            let preferredStyle = self.traitCollection.userInterfaceIdiom == .phone ? UIAlertControllerStyle.actionSheet : UIAlertControllerStyle.alert
            let alertController = UIAlertController(title: "清除缓存", message: "您确定要清除缓存吗？", preferredStyle: preferredStyle)
            
            let cancelAction = UIAlertAction(title: "取消", style: .cancel, handler: nil)
            let deleteAction = UIAlertAction(title: "清除", style: .destructive, handler: { (_) -> Void in
                FileUtils.removeFiles()
                self.tableView.reloadData()
            })
            alertController.addAction(cancelAction)
            alertController.addAction(deleteAction)
            self.present(alertController, animated: true, completion: nil)
            tableView.deselectRow(at: indexPath as IndexPath, animated: true)
        }
        
        
        if (indexPath.section == 1 && indexPath.row == 0) {
            //关注新浪微博
            nextViewController = SinaWeiboViewController()
            navigationController?.pushViewController(nextViewController, animated: true);
            
        }else if(indexPath.section == 1 && indexPath.row == 1){
            //添加微信
            nextViewController = WeixinViewController()
            navigationController?.pushViewController(nextViewController, animated: true);
            
        }else if(indexPath.section == 1 && indexPath.row == 2){
            //浏览博客
            nextViewController = MyBlogViewController()
            navigationController?.pushViewController(nextViewController, animated: true);
            
        }
        
    }

}



// MARK: - init
extension SettingViewController {
    
    func logoutButtonAction(button: UIButton) {
        userDefaults.removeObject(forKey: "nickname")
        userDefaults.removeObject(forKey: "face")
        userDefaults.removeObject(forKey: "sex")
        self.logoutButton.isHidden = true
        self.dismiss(animated: true, completion: nil)
    }
    
    func layoutViews() {
        
        tableView.frame = CGRect(x: 8, y: 44, width: mainScreenWidth-16, height: 416);
        self.view.addSubview(tableView);
        
        logoutButton.frame = CGRect(x: 20, y: tableView.bottom+20, width: tableView.width-30, height: 44);
        self.view.addSubview(logoutButton);
        
        if(((userDefaults.object(forKey: "nickname") as? String)) != nil){
            self.logoutButton.isHidden = false
        }else{
            self.logoutButton.isHidden = true
        }
    }
    
}


extension SettingViewController{
    //发送邮件功能
    func sendEmailAction(){
        let mailComposeViewController = configuredMailComposeViewController()
        if MFMailComposeViewController.canSendMail() {
            self.present(mailComposeViewController, animated: true, completion: nil)
        }
    }
    
    func configuredMailComposeViewController() -> MFMailComposeViewController {
        let mailComposerVC = MFMailComposeViewController()
        mailComposerVC.mailComposeDelegate = self
        //设置收件人
        mailComposerVC.setToRecipients(["wangcityboy@163.com"])
        //设置主题
        mailComposerVC.setSubject("云飞凌风个人博客反馈")
        //邮件内容
        let info:Dictionary = Bundle.main.infoDictionary!
        let appName = info["CFBundleName"] as! String
        mailComposerVC.setMessageBody("</br></br></br></br></br>基本信息：</br></br>\(appName)</br> \(UIDevice.current.name)</br>iOS \(UIDevice.current.systemVersion)", isHTML: true)
        return mailComposerVC
    }
    // MARK: MFMailComposeViewControllerDelegate Method
    func mailComposeController(controller: MFMailComposeViewController, didFinishWithResult result: MFMailComposeResult, error: NSError?) {
        controller.dismiss(animated: true, completion: nil)
    }
}
