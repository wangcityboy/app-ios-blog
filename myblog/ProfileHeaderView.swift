//
//  UserAvatarView.swift
//  quanzhan
//
//  Created by 王海峰 on 15/8/14.
//  Copyright (c) 2015年 云飞凌风. All rights reserved.
//

import UIKit

protocol HeaderViewDelegate: NSObjectProtocol {
    func headerViewheadbuttonClick()
}

class ProfileHeaderView: UIView {
    var dataSource:[BackgroundList] = []
    
    //背景图像
    var bgurl:String?{
        didSet {
            if(bgurl != nil){
                let url = URL(string:server_url + bgurl!)
                _profileBg.sd_setImage(with: url)
            }
        }
    }
    
    //性别
    var sex:String?{
        didSet {
            if(sex != nil){
                if(sex == "男"){
                    _sexView.image = UIImage(named: "n_sex_man_icon")
                }else{
                    _sexView.image = UIImage(named: "n_sex_woman_icon")
                }
            }
        }
    }
    
    //个人头像
    var avatarImageURL: NSURL? {
        didSet {
            if (avatarImageURL != nil) {
                _avatarImageView.sd_setImage(with: avatarImageURL as URL!)
            } else {
                _avatarImageView.image = UIImage(named: "profile_default")
            }
        }
    }
    
    //用户名
    var nickname: String? {
        didSet {
            _nameLabel.text = nickname;
        }
    }
    
    var _profileBg: UIImageView!
    var _avatarImageView: AvatarImageView!
    var _sexView:UIImageView!
    var _nameLabel: UILabel!;
    var _titleView:UIView!
    
    weak var delegate :HeaderViewDelegate?
    
    var initialFrame:CGRect!;
    var initialHeight:CGFloat!;
    


    
    override init(frame: CGRect) {
        super.init(frame: frame);
        //首先蓝色的背景，如果网络请求通过，会用一个背景头像进行覆盖
        self.backgroundColor = UIColor.applicationMainColor();
        self._initViews()
    }
    
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews();
        _avatarImageView.size = CGSize(width:80,height:80)
        _avatarImageView.center = center;
    
        _titleView.frame = CGRect(x:0, y:_avatarImageView.bottom+10, width:mainScreenWidth, height:20)
        
        
        if(sex == nil){
            _nameLabel.frame = CGRect(x:(mainScreenWidth-100)/2, y:0, width:100, height:20)
            _nameLabel.textColor = UIColor.white
            _nameLabel.textAlignment = NSTextAlignment.center;
            _sexView.frame = CGRect(x:self._nameLabel.frame.width+self._nameLabel.origin.x+4, y:2, width:16, height:16)
            _sexView.isHidden = true
        }else{
            _nameLabel.frame = CGRect(x:(mainScreenWidth-160)/2, y:0, width:100, height:20)
            _nameLabel.textAlignment = NSTextAlignment.right;
            _sexView.frame = CGRect(x:self._nameLabel.frame.width+self._nameLabel.origin.x+4, y:2, width:16, height:16)
            _sexView.isHidden = false
        }
        
    }

    
    func headimageClick(){
        delegate?.headerViewheadbuttonClick()
    }

}


extension ProfileHeaderView:UIGestureRecognizerDelegate{
    

    
    func scrollViewDidScroll(_ scrollView: UIScrollView){
        if scrollView.contentOffset.y < 0 {
            let OffsetY:CGFloat = scrollView.contentOffset.y + scrollView.contentInset.top
            initialFrame.origin.y = OffsetY;
            initialFrame.size.height = initialHeight + (OffsetY * -1)
            _profileBg.frame = initialFrame
        }
    }
    
    public func _initViews() {
        

  
        _profileBg = UIImageView()
        _profileBg.frame = self.frame
        _profileBg.isUserInteractionEnabled = true
        addSubview(_profileBg)
        
        
        _titleView = UIView()
        _profileBg.addSubview(_titleView)
       
        initialFrame = _profileBg.frame;
        initialHeight = initialFrame.size.height;
        
        
        _avatarImageView = AvatarImageView(frame: CGRect.zero)
        _profileBg.addSubview(_avatarImageView);
        
        let tap = UITapGestureRecognizer(target:self,action:#selector(headimageClick))
        _avatarImageView.isUserInteractionEnabled = true
        _avatarImageView.addGestureRecognizer(tap)
        
        
        _nameLabel = UILabel();
        _nameLabel.font = UIFont.systemFont(ofSize: 15);
        _nameLabel.textColor = UIColor.white
        _titleView.addSubview(_nameLabel);
        
        let tap2 = UITapGestureRecognizer(target:self,action:#selector(headimageClick))
        self._nameLabel.isUserInteractionEnabled = true
        self._nameLabel.addGestureRecognizer(tap2)
        
        
        _sexView = UIImageView()
        _sexView.contentMode = UIViewContentMode.scaleAspectFit
       
        _titleView.addSubview(_sexView)
        
    }
    
  
    
    
    override func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
        return true
    }
 
}
