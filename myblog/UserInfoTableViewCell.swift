//
//  UserInfoTableViewCell.swift
//  YunfeiBlogs
//
//  Created by 王海峰 on 15/9/4.
//  Copyright (c) 2015年 云飞凌风. All rights reserved.
//

import UIKit

class UserInfoTableViewCell: UITableViewCell {
    
    var titleLabel:UILabel!
    var valueLabel:UILabel!
    
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    
    func settags(tagStr:String){
        titleLabel.text = "个性签名"
        valueLabel.text = tagStr
        valueLabel.sizeToFit()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier);
        self.accessoryType = UITableViewCellAccessoryType.disclosureIndicator
        if(titleLabel == nil){
            titleLabel = UILabel()
            self.contentView.addSubview(titleLabel)
            titleLabel.font = UIFont.systemFont(ofSize: 16)
            titleLabel.textColor = UIColor.black
        }
        
        if(valueLabel == nil){
            valueLabel = UILabel()
            valueLabel.textAlignment = NSTextAlignment.right
            self.contentView.addSubview(valueLabel)
            valueLabel.font = UIFont.systemFont(ofSize: 15)
            valueLabel.textColor = UIColor.applicationMainColor()
        }
        
    }
        
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func layoutSubviews() {
        super.layoutSubviews();
        titleLabel.frame = CGRect(x:10, y:0, width:80, height:44)
        valueLabel.frame = CGRect(x:self.titleLabel.frame.width, y:0, width:mainScreenWidth-self.titleLabel.width-20, height:44)
    }
    
    

}
