//
//  SettingTableViewCell.swift
//  YunfeiBlogs
//
//  Created by 王海峰 on 15/8/21.
//  Copyright (c) 2015年 云飞凌风. All rights reserved.
//

import UIKit

class ProfileTableViewCell: UITableViewCell {

    var headImageView:UIImageView!
    var titleLabel:UILabel!
    var lineView:UIView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier);
        
        prepareUI();
    }

    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func layoutSubviews() {
        super.layoutSubviews();
        
        self.headImageView!.frame = CGRect(x:20.0, y:(44-28)/2, width:28.0, height:28.0);
        self.titleLabel!.frame = CGRect(x:20.0 + 28 + 20, y:(44-28)/2, width:mainScreenWidth, height:28.0);
        self.lineView!.frame = CGRect(x:20.0 + 28.0 + 20, y:43.5, width:mainScreenWidth-88.0, height:0.5);
    }

    
    func prepareUI(){
        self.headImageView = UIImageView()
        headImageView!.contentMode = UIViewContentMode.scaleAspectFit;
        headImageView!.clipsToBounds = true;
        self.addSubview(headImageView!)
        
        self.titleLabel = UILabel()
        self.titleLabel!.textColor = UIColor.black
        self.titleLabel!.textAlignment = NSTextAlignment.left
        self.titleLabel!.font = UIFont.systemFont(ofSize: 16)
        self.addSubview(titleLabel!)

        
        self.lineView = UIView()
        self.lineView!.backgroundColor = UIColor.gray
        self.addSubview(lineView!)
    }

}
