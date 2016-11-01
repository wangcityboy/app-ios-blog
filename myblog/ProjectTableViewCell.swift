//
//  MyProjectTableViewCell.swift
//  YunfeiBlogs
//
//  Created by 王海峰 on 15/8/14.
//  Copyright (c) 2015年 云飞凌风. All rights reserved.
//

import UIKit


class ProjectTableViewCell: UITableViewCell {

    var imageURL: NSURL? {
        didSet {
            if (imageURL != nil) {
                imgView.sd_setImage(with: imageURL! as URL!)
            } else {
                imgView.image = nil;
            }
        }
    };
    var title: String? {
        didSet {
            titleLabel.text = title;
        }
    };
    var subtitle: String? {
        didSet {
            subtitleLabel.text = subtitle;
        }
    };
    var starNumber: Int = 0 {
        didSet {
            starView.starNumber = starNumber;
        }
    }
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier);
        _addConstraints();
    }
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func cellHeight() -> CGFloat {
        return mainScreenHeight/3
    }
    
    lazy var imgView: UIImageView = {
        let imageView = UIImageView();
        imageView.contentMode = .scaleToFill;
        self.contentView.addSubview(imageView);
        return imageView;
        }();
    
    lazy  var titleLabel: UILabel = {
        let label = UILabel();
        label.textColor = UIColor.applicationMainColor();
        label.font = UIFont.systemFont(ofSize: 16);
        self.contentView.addSubview(label);
        return label;
        }();
    
    lazy  var subtitleLabel: UILabel = {
        let label = UILabel();
        label.textColor = UIColor.blue
        label.font = UIFont.systemFont(ofSize: 14);
        label.numberOfLines = 0
        self.contentView.addSubview(label);
        return label;
        }();
    
    lazy  var starView: StarView = {
        let starView = StarView();
        starView.totalNumber = 5;
        self.contentView.addSubview(starView);
        return starView;
        }();
    
    override func prepareForReuse() {
        super.prepareForReuse();
        imgView.sd_cancelCurrentImageLoad()
        imgView.image = nil
    }
    
}


extension ProjectTableViewCell {
    
    func _addConstraints() {

        imgView.frame = CGRect(x:0,y:0,width:mainScreenWidth,height:mainScreenHeight/5)
        titleLabel.frame = CGRect(x:10,y:imgView.frame.height+3,width:100,height:30)
        starView.frame = CGRect(x:mainScreenWidth-120,y:imgView.frame.height+3,width:100,height:30)
        subtitleLabel.frame = CGRect(x:10,y:imgView.frame.height+36,width:mainScreenWidth-20,height:60)
        
    }


}
