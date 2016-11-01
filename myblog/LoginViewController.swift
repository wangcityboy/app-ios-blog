//
//  LoginViewController.swift
//  quanzhan
//
//  Created by 王海峰 on 15/8/14.
//  Copyright (c) 2015年 云飞凌风. All rights reserved.
//

import UIKit
import SCLAlertView
import Alamofire
import SwiftyJSON

class LoginViewController: DismissViewController,UIAlertViewDelegate{
    
    var username, password: String?;
    var inputTableView: UITableView!;
    var backButton, loginButton, weiboLoginButton, weixinLoginButton,qqLoginButton, registerButton, resetPasswordButton: UIButton!;
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad();
        self.title = "用户登录"
        self.view.backgroundColor = UIColor.white
        initView()
    }
    
    
    //点击屏幕空白区域隐藏键盘
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    //关闭登陆界面
    func backButtonAction(button: UIButton) {
        dismiss(animated: true, completion: nil);
    }
    
    
    //点击登陆时判断用户名或密码是否为空
    func loginButtonAction(button: UIButton) {
        if (username == nil || username == ""  || password == nil || password == "") {
            SCLAlertView().showWarning("温馨提示", subTitle:"用户名或密码不能为空!", closeButtonTitle:"确定")
        } else {
            self.clickLogin()
        }
    }
    
    
    
    //用户注册
    func registerButtonAction(button: UIButton) {
        let nextVC = RegisterViewController();
        self.present(nextVC, animated: true, completion: nil)
    }
    
    //重置密码
    func resetPasswordButtonAction(button: UIButton) {
        let nextVC = ResetPasswordViewController();
        self.present(nextVC, animated: true, completion: nil)
    }
    
    
}

// MARk: - UITextFieldDelegate

extension LoginViewController: UITextFieldDelegate {
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        if (textField.tag == 0) {
            username = textField.text;
        }
        else if (textField.tag == 1) {
            password = textField.text;
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool{
        textField.resignFirstResponder()
        return true
    }
    
}

// MARK: - UITableViewDataSource

extension LoginViewController: UITableViewDataSource,UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2;
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = UITableViewCell(style: .default, reuseIdentifier: nil);
        cell.selectionStyle = .none;
        
        let imgView = UIImageView();
        imgView.translatesAutoresizingMaskIntoConstraints = false
        cell.contentView.addSubview(imgView);
        
        let textField = UITextField();
        textField.borderStyle = .none;
        textField.tag = indexPath.row;
        textField.delegate = self;
        textField.translatesAutoresizingMaskIntoConstraints = false
        cell.contentView.addSubview(textField);
        
        cell.contentView.addConstraints(NSLayoutConstraint.constraints(
            withVisualFormat: "H:|-8-[imgView(==22)]-10-[textField]-5-|",
            options: .alignAllCenterY,
            metrics: nil,
            views: ["textField": textField, "imgView": imgView]));
        
        cell.contentView.addConstraints(NSLayoutConstraint.constraints(
            withVisualFormat: "V:|-2-[textField]-2-|",
            options: NSLayoutFormatOptions(rawValue: 0),
            metrics: nil,
            views: ["textField": textField, "imgView": imgView]));
        
        cell.contentView.addConstraint(NSLayoutConstraint(item: imgView, attribute: .height, relatedBy: .equal, toItem: imgView, attribute: .height, multiplier: 1.0, constant: 0));
        
        if (indexPath.row == 0) {
            imgView.image = UIImage(named: "login_user");
            if(userDefaults.object(forKey: "username") != nil){
                username = (userDefaults.object(forKey: "username") as! String)
                textField.text = username
            }else{
                textField.placeholder = "请输入用户名"
            }
        }else if (indexPath.row == 1) {
            imgView.image = UIImage(named: "login_secret");
            textField.placeholder = "请输入用户密码"
            textField.isSecureTextEntry = true
        }
        
        return cell;
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 44;
    }
    
}




extension LoginViewController {
    
    func initView() {
        
        
        backButton = UIButton();
        backButton.frame = CGRect(x:8, y:30, width:28, height:28)
        backButton.setImage(UIImage(named: "login_back"), for: .normal);
        backButton.addTarget(self, action: #selector(LoginViewController.backButtonAction), for: .touchUpInside);
        view.addSubview(backButton);
        
        
        inputTableView = UITableView(frame: CGRect.zero, style: .plain);
        inputTableView.frame = CGRect(x:20, y:100, width:mainScreenWidth-40, height:88)
        inputTableView.delegate = self;
        inputTableView.dataSource = self;
        inputTableView.isScrollEnabled = true;
        inputTableView.layer.cornerRadius = 5;
        view.addSubview(inputTableView);
        
        
        loginButton = UIButton();
        loginButton.frame = CGRect(x:30, y:self.inputTableView.bottom+20, width:mainScreenWidth-60, height:40)
        loginButton.layer.cornerRadius = 5;
        loginButton.backgroundColor = RGB(r: 255, g: 76, b: 58, a: 1);
        loginButton.setTitle("立即登录", for: .normal);
        loginButton.setTitleColor(UIColor.white, for: .normal);
        loginButton.setTitleColor(UIColor.gray, for: .highlighted);
        loginButton.addTarget(self, action: #selector(LoginViewController.loginButtonAction), for: .touchUpInside);
        view.addSubview(loginButton);
        
        
        
        registerButton = UIButton();
        registerButton.frame = CGRect(x:30, y:self.loginButton.bottom + 15, width:(mainScreenWidth-90)/2, height:30)
        registerButton.setTitle("注册账号", for: .normal);
        registerButton.titleLabel?.font = UIFont.systemFont(ofSize: 14)
        registerButton.setTitleColor(UIColor.black, for: .normal);
        registerButton.setTitleColor(UIColor.red, for: .highlighted);
        registerButton.addTarget(self, action: #selector(LoginViewController.registerButtonAction), for: .touchUpInside);
        view.addSubview(registerButton);
        
        
        
        resetPasswordButton = UIButton();
        resetPasswordButton.frame = CGRect(x:self.registerButton.right+30, y:self.loginButton.bottom + 15, width:(mainScreenWidth-90)/2, height:30)
        resetPasswordButton.setTitle("忘记密码", for: .normal);
        resetPasswordButton.titleLabel?.font = UIFont.systemFont(ofSize: 14)
        resetPasswordButton.setTitleColor(UIColor.black, for: .normal);
        resetPasswordButton.setTitleColor(UIColor.red, for: .highlighted);
        resetPasswordButton.addTarget(self, action: #selector(LoginViewController.resetPasswordButtonAction), for: .touchUpInside);
        view.addSubview(resetPasswordButton);
        
        
        
        let otherLogin = UILabel(frame: CGRect(x:10, y:self.resetPasswordButton.bottom+30, width:mainScreenWidth, height:30))
        otherLogin.text = "你还可以选择以下方式登录:"
        otherLogin.font = UIFont.systemFont(ofSize: 16)
        otherLogin.textColor = UIColor.black
        view.addSubview(otherLogin)
        
        let label = UILabel(frame: CGRect(x:10, y:otherLogin.bottom+5, width:mainScreenWidth, height:2))
        label.backgroundColor = UIColor.black
        view.addSubview(label)
        
        
        weiboLoginButton = UIButton();
        weiboLoginButton.frame = CGRect(x:20, y:label.bottom+10,width:(mainScreenWidth-80)/3, height:(mainScreenWidth-80)/3)
        weiboLoginButton.setImage(UIImage(named: "sina_weibo_c"), for: .normal);
        weiboLoginButton.addTarget(self, action: #selector(backButtonAction), for: .touchUpInside);
        view.addSubview(weiboLoginButton);
        let weibo = UILabel(frame: CGRect(x:20, y:weiboLoginButton.bottom, width:(mainScreenWidth-80)/3, height:20))
        weibo.text = "新浪微博登录"
        weibo.textColor = UIColor.black
        weibo.textAlignment = NSTextAlignment.center
        weibo.font = UIFont.systemFont(ofSize: 14)
        view.addSubview(weibo)
        
        
        weixinLoginButton = UIButton();
        weixinLoginButton.frame = CGRect(x:self.weiboLoginButton.right+20, y:label.bottom+10, width:(mainScreenWidth-80)/3, height:(mainScreenWidth-80)/3)
        weixinLoginButton.setImage(UIImage(named: "wechat_c"), for: .normal);
        weixinLoginButton.addTarget(self, action: #selector(weixinButtonAction) ,for: .touchUpInside);
        view.addSubview(weixinLoginButton);
        let weixin = UILabel(frame: CGRect(x:self.weiboLoginButton.right+20, y:weixinLoginButton.bottom, width:(mainScreenWidth-80)/3, height:20))
        weixin.text = "微信账号登录"
        weixin.textColor = UIColor.black
        weixin.textAlignment = NSTextAlignment.center
        weixin.font = UIFont.systemFont(ofSize: 14)
        view.addSubview(weixin)
        
        qqLoginButton = UIButton();
        qqLoginButton.frame = CGRect(x:self.weixinLoginButton.right+20, y:label.bottom+10, width:(mainScreenWidth-80)/3, height:(mainScreenWidth-80)/3)
        qqLoginButton.setImage(UIImage(named: "qq_c"), for: .normal);
        qqLoginButton.addTarget(self, action: #selector(qqButtonAction), for: .touchUpInside);
        view.addSubview(qqLoginButton);
        let qq = UILabel(frame: CGRect(x:self.weixinLoginButton.right+20, y:qqLoginButton.bottom, width:(mainScreenWidth-80)/3, height:20))
        qq.text = "QQ账号登录"
        qq.font = UIFont.systemFont(ofSize: 14)
        qq.textAlignment = NSTextAlignment.center
        qq.textColor = UIColor.black
        view.addSubview(qq)
        
    }
    
    func clickLogin(){
        
        let parameters = [
            "username":username!,
            "password":password!
        ]
        
        let url = URL(string:login_url)!

        Alamofire.request(url,method:.get,parameters:parameters).validate().responseJSON { response in
            switch response.result {
            case .success:
                if let value = response.result.value {
                    let json = JSON(value)["data"]
                    if (JSON(value)["code"] == 200){
                            userDefaults.set(json["tg_username"].string!, forKey: "username")
                            userDefaults.set(json["tg_nickname"].string!, forKey: "nickname")
                            userDefaults.set(json["tg_face"].string!, forKey: "face")
                            userDefaults.synchronize()
                            SCLAlertView().showSuccess("温馨提示", subTitle: "登录成功", closeButtonTitle: "确定")
                            self.dismiss(animated: true, completion: nil)
                    }else{
                        SCLAlertView().showWarning("温馨提示", subTitle: "登录失败，请检查用户名和密码", closeButtonTitle: "确定")
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
    
    
    
    func weiboButtonAction(){
        print("weiboButtonAction")
    }

    func weixinButtonAction(){
        print("weixinButtonAction")
    }

    func qqButtonAction(){
        print("qqButtonAction")
    }
    
}

