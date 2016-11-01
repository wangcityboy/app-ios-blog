//
//  UIViewController+HUD.swift
//
//  Created by 王海峰 on 15/8/14.
//  Copyright (c) 2015年 云飞凌风. All rights reserved.
//

import UIKit


extension UIViewController {
    
    private var HUD: UIActivityIndicatorView {
        get {
            var activityView = view.viewWithTag(98786) as? UIActivityIndicatorView;
            
            if (activityView == nil) {
                activityView = UIActivityIndicatorView(activityIndicatorStyle: UIActivityIndicatorViewStyle.whiteLarge);
                activityView!.color = UIColor.black
                activityView!.tag = 98786;
                
                view.addSubview(activityView!);
            }
            activityView!.center = view.center;
            return activityView!;
        }
        
    }
    
    private var errorLabel: UILabel {
        get {
            var label = view.viewWithTag(982375) as? UILabel
            if (label == nil) {
                label = UILabel();
                label!.frame = CGRect(x:0, y:64, width:self.view.bounds.width, height:20);
                label!.textAlignment = NSTextAlignment.center;
                label!.backgroundColor = UIColor.white
                label!.tag = 982375;
                label!.textColor = UIColor.black;
                view.addSubview(label!);
            }
            return label!;
        }
    }
    
    func showHUD() {
        HUD.startAnimating();
    }
    
    func showHUDWithText(text: NSString) {
        HUD.startAnimating();
    }
    
    func showWarningWithDescription(description: NSString) {
        errorLabel.alpha = 1;
        errorLabel.text = description as String;
        
        let delayInSeconds:Int64 = 1000000000 * 1
        let dispatchTime = DispatchTime.now() + Double(delayInSeconds) / Double(NSEC_PER_SEC)
        DispatchQueue.main.asyncAfter(deadline: dispatchTime, execute: {
            UIView.animate(withDuration: 0.5, animations: { () -> Void in
                self.errorLabel.alpha = 0;
                }, completion: { (_) -> Void in
                    self.errorLabel.alpha = 0;
            })
        })
    }
    
    func hideHUD() {
        HUD.stopAnimating();
    }
    
}
