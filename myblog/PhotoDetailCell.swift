//
//  giftTableViewCell.swift
//  dantang
//
//  Created by HYZ on 16/10/19.
//  Copyright © 2016年 HYZ. All rights reserved.
//

import UIKit
import Kingfisher


protocol giftCellPushtoDetailDelegate :NSObjectProtocol {
    func giftCellPushtoDetail(isleft:Bool, tag:Int)
}

class PhotoDetailCell: UITableViewCell {
    let wb = (UIScreen.main.bounds.width) / 750
    let liftView = PhotoTableViewCell()
    let rightView = PhotoTableViewCell()
    weak var delegate : giftCellPushtoDetailDelegate?
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        
        super.init(style: UITableViewCellStyle.default, reuseIdentifier: String?.none)
        self.makeCellUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    
    func  makeCellUI(){
       
        liftView.frame = CGRect.init(x: 10*wb, y: 10*wb, width: 355*wb, height: 500*wb)
        self.addSubview(liftView)
        
        let  gesturnL :UITapGestureRecognizer = UITapGestureRecognizer.init(target: self, action:#selector(PhotoDetailCell.liftPush))
        liftView.addGestureRecognizer(gesturnL)
        
        
        
        rightView.frame = CGRect.init(x: 385*wb, y: 10*wb, width: 355*wb, height: 500*wb)
        self.addSubview(rightView)
        
        let  gesturnR :UITapGestureRecognizer = UITapGestureRecognizer.init(target: self, action:  #selector(rightPush))
        rightView.addGestureRecognizer(gesturnR)
        
        
        self.backgroundColor = UIColor.gray
        
        
    }
    func liftPush(){
    
        //print("left")
        delegate?.giftCellPushtoDetail(isleft: true, tag: self.tag)
        
    }
    
    func rightPush(){
        //print("right")
        delegate?.giftCellPushtoDetail(isleft: false, tag: self.tag)
    }
    func setliftView(model:PhotosModel){
//        let url = URL(string: model.cover_image_url!)
//        self.myimageView.kf.setImage(with: url)
//        self.mytitle.text = model.title
    
        let url = URL(string: server_url + model.dFace!)
        self.liftView.logo.kf.setImage(with: url)
        
        self.liftView.name.text = model.dName
//        self.liftView.price.text = "￥" + model.price!
       
//        let  a:Int!  = model.favorites_count
        
        //print(a)
        //解析真是狠多坑
//        let strVar = String( a)
        

//        self.liftView.islikednum.text = strVar
        
        //print(str)
//        let seleted = model.is_favorite
//        if seleted == 0 {
//            self.liftView.islikd.isSelected = false
//        }else
//        {
//            self.liftView.islikd.isSelected = true
//        }
     
        
        
        
        
    }
    
    func setrightView(model:PhotosModel){
        let url = URL(string: model.dFace!)
        self.rightView.logo.kf.setImage(with: url)
        self.rightView.name.text = model.dName
//        self.rightView.price.text = "￥" + model.price!
//        let  a:Int!  = model.favorites_count
        
       // print(a)
        //解析真是狠多坑
//        let strVar = String( a)
//        self.rightView.islikednum.text = strVar
        //print(model.name)
//        let seleted = model.is_favorite
//        if seleted == 0 {
//            self.rightView.islikd.isSelected = false
//        }else
//        {
//            self.rightView.islikd.isSelected = true
//        }
        
    }
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
