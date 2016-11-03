//
//  PhotoViewCell.swift
//  myblog
//
//  Created by chinaskin on 16/11/3.
//  Copyright © 2016年 wanghaifeng. All rights reserved.
//

import UIKit

class PhotoViewCell: UIView {
    let wb = mainScreenWidth / 750
    let logo = UIImageView()
    let name = UILabel()
    let date = UILabel()


    
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
        
        
        logo.frame = CGRect.init(x: 0, y: 0, width: 355*wb, height: 265*wb)
        self.addSubview(logo)
        
        name.frame = CGRect.init(x: 0, y: logo.bottom, width: 300*wb, height: 50*wb)
        name.textColor = UIColor.black
        name.textAlignment = NSTextAlignment.left
        name.numberOfLines = 2;
        name.lineBreakMode = .byTruncatingTail
        name.font = UIFont.italicSystemFont(ofSize: 14)
        self.addSubview(name)
        
        
        date.frame = CGRect.init(x: 0, y: name.bottom, width: 300*wb, height: 25*wb)
        date.textColor = UIColor.init(red: 215/255, green: 94/255, blue: 99/255, alpha: 1)
        date.textAlignment = .left
        date.font = UIFont.italicSystemFont(ofSize: 13)
        self.addSubview(date)
 
        
    }
    
}

