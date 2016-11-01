//
//  TitleRImageMoreCell.swift
//  YunfeiBlogs
//
//  Created by 王海峰 on 15/9/6.
//  Copyright (c) 2015年 云飞凌风. All rights reserved.
//

import UIKit

class TitleRImageMoreCell: UITableViewCell {
    
    var titleLabel:UILabel!
    var userIconView:UIImageView!
    
    var bgUrl:String?{
        didSet {
            if(bgUrl != nil){
                userIconView.sd_setImage(with: NSURL(string: bgUrl!) as URL!)
            }else{
                userIconView.image = UIImage(named: "launch")
            }
        }
    }
    
    
    //用户名
    var name: String? {
        didSet {
            titleLabel.text = name;
        }
    }

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
        self.accessoryType = UITableViewCellAccessoryType.disclosureIndicator
        if(titleLabel == nil){
            titleLabel = UILabel()
            self.contentView.addSubview(titleLabel)
            titleLabel.font = UIFont.systemFont(ofSize: 16)
            titleLabel.textColor = UIColor.black
        }
        
        if(userIconView == nil){
            userIconView = UIImageView()
            self.contentView.addSubview(userIconView)
        }
        
    }
    
    
    override func layoutSubviews() {
        super.layoutSubviews();
        titleLabel.frame = CGRect(x:10, y:(70-20)/2, width:70, height:20)
        userIconView.frame = CGRect(x:mainScreenWidth-80, y:(70-60)/2, width:60, height:60)
        userIconView.layer.cornerRadius = self.frame.size.height * 0.5
        userIconView.layer.masksToBounds = true
    }
    

    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
