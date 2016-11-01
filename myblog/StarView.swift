//
//  StarView.swift
//  quanzhan
//
//  Created by 王海峰 on 15/8/14.
//  Copyright (c) 2015年 云飞凌风. All rights reserved.
//

import UIKit

class StarView: UIView {
    
    var totalNumber: Int = 0 {
        didSet {
            setNeedsLayout();
        }
    }
    
    var starNumber: Int = 0 {
        didSet {
            setNeedsLayout();
        }
    }
    
    override func layoutSubviews() {
        updateUI();
    }

}



extension StarView {
    
     func updateUI() {

        if (starNumber > totalNumber) {
            return;
        }

        var label = viewWithTag(1001) as! UILabel!;
        if (label == nil) {
            label = UILabel();
            label?.tag = 1001;
            addSubview(label!);
        }
        
        let str = NSMutableAttributedString();
        
        for _ in 0..<self.starNumber {
            
            let attributes = [
                NSFontAttributeName: UIFont.systemFont(ofSize: self.bounds.height),
                NSForegroundColorAttributeName: UIColor.red
            ];
            
            str.append(NSAttributedString(string: "★", attributes: attributes));
        }
        
        for _ in self.starNumber..<self.totalNumber {
            
            let attributes = [
                NSFontAttributeName: UIFont.systemFont(ofSize: self.bounds.height),
                NSForegroundColorAttributeName: UIColor.gray
            ];
            
            str.append(NSAttributedString(string: "★", attributes: attributes));
        }
    
        label?.frame = self.bounds;
        label?.attributedText = str;
        label?.adjustsFontSizeToFitWidth = true;
        
    }
    
}

