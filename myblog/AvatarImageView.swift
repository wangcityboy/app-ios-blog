//
//  AvatarImageView.swift
//  quanzhan
//
//  Created by 王海峰 on 15/8/14.
//  Copyright (c) 2015年 云飞凌风. All rights reserved.
//

import UIKit

class AvatarImageView: UIImageView {
    
  

    override init(frame: CGRect) {
        super.init(frame: frame);
        backgroundColor = UIColor.clear;
    }

    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    

    
    override func layoutSubviews() {
        super.layoutSubviews();
        
        let height = bounds.height;
        let width = bounds.width;
        
        let length = height > width ? width : height;
        
        layer.cornerRadius = length*0.5;
        layer.masksToBounds = true;
    }
    
    


}

