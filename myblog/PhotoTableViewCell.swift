//
//  PhotoTableViewCell.swift
//  myblog
//
//  Created by chinaskin on 16/10/29.
//  Copyright © 2016年 wanghaifeng. All rights reserved.
//

import UIKit

class PhotoTableViewCell:UIView{
    let wb = (UIScreen.main.bounds.width) / 750
    let logo = UIImageView()
    let name = UILabel()
    let price = UILabel()
    let islikd = UIButton()
    let islikednum = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.makeUI()
        self.backgroundColor = UIColor.white
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
    func  makeUI()  {
        
        self.layer.masksToBounds = true
        self.layer.cornerRadius = 5
        
        //325* 360
        
        logo.frame = CGRect.init(x: 0, y: 0, width: 355*wb, height: 360*wb)
        self.addSubview(logo)
        
        name.frame = CGRect.init(x: 0, y: 370*wb, width: 325*wb, height: 80*wb)
        name.textColor = UIColor.black
        name.textAlignment = NSTextAlignment.left
        name.numberOfLines = 2;
        name.lineBreakMode = .byTruncatingTail
        name.font = UIFont.italicSystemFont(ofSize: 14)
        self.addSubview(name)
        
        price.frame = CGRect.init(x: 10*wb, y: 460*wb, width: 210*wb, height: 40*wb)
        price.textColor = UIColor.init(red: 215/255, green: 94/255, blue: 99/255, alpha: 1)
        price.textAlignment = .left
        price.font = UIFont.italicSystemFont(ofSize: 12)
        self.addSubview(price)
        
        islikd.frame = CGRect.init(x: 230*wb, y: 460*wb, width: 32*wb, height: 32*wb)
        islikd.setImage(UIImage.init(named: "content-details_like_16x16_"), for: .normal)
        islikd.setImage(UIImage.init(named: "content-details_like_selected_16x16_"), for: .selected)
        self.addSubview(islikd)
        
        
        islikednum.frame = CGRect.init(x:265*wb, y: 456*wb, width: 90*wb, height: 40*wb)
        islikednum.textAlignment = .center
        islikednum.textColor = UIColor.black
        islikednum.font = UIFont.italicSystemFont(ofSize: 12)
        self.addSubview(islikednum)
        
        
        
    }

}
