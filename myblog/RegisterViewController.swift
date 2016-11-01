//
//  RegisterViewController.swift
//  quanzhan
//
//  Created by 王海峰 on 15/8/14.
//  Copyright (c) 2015年 云飞凌风. All rights reserved.
//

import UIKit
import SCLAlertView


class RegisterViewController: UIViewController {
    
    var  phoneNumber, messageCode, nickName, password: String?;
    
    var backButton, registerButton: UIButton!;
    var inputTableView: UITableView!;
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad();
        
        let image = UIImageView(frame: self.view.bounds)
        image.image = UIImage(named: "launch")
        self.view.addSubview(image)
        
        initViews();
        layoutViews();
    }
    
    func backButtonAction(button: UIButton) {
        dismiss(animated: true, completion: nil);
    }
    
    func registerButtonAction(button: UIButton) {
        
        if (phoneNumber == nil || phoneNumber == "" || messageCode == nil || messageCode == "" || nickName == nil || nickName == "" || password == nil || password == "") {
            
            SCLAlertView().showWarning("温馨提示", subTitle:"请完善您的信息!", closeButtonTitle:"确定")
            
        } else {
            
            // 开始注册
            
        }
        
    }
    
    func resendMessageButtonAction(button: UIButton) {
        
    }
    
}

// MARk: - UITextFieldDelegate

extension RegisterViewController: UITextFieldDelegate {
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        if (textField.tag == 0) {
            phoneNumber = textField.text;
        }
        else if (textField.tag == 1) {
            messageCode = textField.text;
        }
        else if (textField.tag == 2) {
            nickName = textField.text;
        }
        else if (textField.tag == 2) {
            password = textField.text;
        }
    }
    
}



// MARK: - UITableViewDataSource

extension RegisterViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4;
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
        
        if (indexPath.row == 1) {
            
            let resendMessageButton = UIButton();
            resendMessageButton.layer.cornerRadius = 5;
            resendMessageButton.backgroundColor = UIColor.applicationMainColor();
            resendMessageButton.setTitle("发送验证码", for: .normal);
            resendMessageButton.titleLabel?.font = UIFont.systemFont(ofSize: 14);
            resendMessageButton.setTitleColor(UIColor.white, for: .normal);
            resendMessageButton.setTitleColor(UIColor.gray, for: .highlighted)
            resendMessageButton.translatesAutoresizingMaskIntoConstraints = false
            resendMessageButton.addTarget(self, action: #selector(resendMessageButtonAction), for: .touchUpInside);
            cell.contentView.addSubview(resendMessageButton);
            
            cell.contentView.addConstraints(NSLayoutConstraint.constraints(
                withVisualFormat: "H:|-8-[imgView(==22)]-10-[textField]-10-[resendMessageButton]-5-|",
                options: .alignAllCenterY,
                metrics: nil,
                views: ["textField": textField, "imgView": imgView, "resendMessageButton": resendMessageButton]));
            
        } else {
            cell.contentView.addConstraints(NSLayoutConstraint.constraints(
                withVisualFormat: "H:|-8-[imgView(==22)]-10-[textField]-5-|",
                options: .alignAllCenterY,
                metrics: nil,
                views: ["textField": textField, "imgView": imgView]));
        }
        
        cell.contentView.addConstraints(NSLayoutConstraint.constraints(
            withVisualFormat: "V:|-2-[textField]-2-|",
            options: NSLayoutFormatOptions(rawValue: 0),
            metrics: nil,
            views: ["textField": textField, "imgView": imgView]));
        
        cell.contentView.addConstraint(NSLayoutConstraint(item: imgView, attribute: .height, relatedBy: .equal, toItem: imgView, attribute: .height, multiplier: 1.0, constant: 0));
        
        
        if (indexPath.row == 0) {
            imgView.image = UIImage(named: "login_phone");
            textField.placeholder = "输入用户名"
        }
        else if (indexPath.row == 1) {
            imgView.image = UIImage(named: "login_message");
            textField.placeholder = "输入用户密码"
        }
        else if (indexPath.row == 2) {
            imgView.image = UIImage(named: "login_user");
            textField.placeholder = "写下您的名字"
        }
        else if (indexPath.row == 3) {
            imgView.image = UIImage(named: "login_secret");
            textField.placeholder = "创建一个密码"
        }
        
        return cell;
    }
    
}


// MARK: - UITableViewDelegate

extension RegisterViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 44;
    }
    
}

// MARK: - init

extension RegisterViewController {
    
    func initViews() {
        
        backButton = UIButton();
        backButton.setImage(UIImage(named: "login_back"), for: .normal);
        backButton.translatesAutoresizingMaskIntoConstraints = false
        backButton.addTarget(self, action: #selector(backButtonAction), for: .touchUpInside);
        view.addSubview(backButton);
        
        inputTableView = UITableView(frame: CGRect.zero, style: .plain);
        inputTableView.delegate = self;
        inputTableView.dataSource = self;
        inputTableView.isScrollEnabled = false;
        inputTableView.layer.cornerRadius = 5;
        inputTableView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(inputTableView);
        
        registerButton = UIButton();
        registerButton.layer.cornerRadius = 5;
        registerButton.backgroundColor = RGB(r: 255, g: 76, b: 58, a: 1);
        registerButton.setTitle("立即注册", for: .normal);
        registerButton.setTitleColor(UIColor.white, for: .normal);
        registerButton.setTitleColor(UIColor.gray, for: .highlighted);
        registerButton.translatesAutoresizingMaskIntoConstraints = false
        registerButton.addTarget(self, action: #selector(registerButtonAction), for: .touchUpInside);
        view.addSubview(registerButton);
        
    }
    
    func layoutViews() {
        
        view.addConstraints(NSLayoutConstraint.constraints(
            withVisualFormat: "H:|-8-[backButton(==30)]",
            options: NSLayoutFormatOptions(rawValue:0),
            metrics: nil,
            views: views));
        
        view.addConstraints(NSLayoutConstraint.constraints(
            withVisualFormat: "V:|-28-[backButton(==30)]",
            options: NSLayoutFormatOptions(rawValue:0),
            metrics: nil,
            views: views));
        
        view.addConstraints(NSLayoutConstraint.constraints(
            withVisualFormat: "H:|-20-[inputTableView]-20-|",
            options: NSLayoutFormatOptions(rawValue:0),
            metrics: nil,
            views: views));
        
        view.addConstraints(NSLayoutConstraint.constraints(
            withVisualFormat: "H:|-20-[registerButton]-20-|",
            options: NSLayoutFormatOptions(rawValue:0),
            metrics: nil,
            views: views));
        
        // 垂直
        view.addConstraints(NSLayoutConstraint.constraints(
            withVisualFormat: "V:[backButton]-30-[inputTableView(==176)]-30-[registerButton(==44)]",
            options: NSLayoutFormatOptions(rawValue:0),
            metrics: nil,
            views: views));
        
    }
    
    var views: [String: UIView] {
        get {
            return [
                "inputTableView": inputTableView,
                "backButton"    : backButton,
                "registerButton": registerButton,
            ];
        }
    }
    
}
