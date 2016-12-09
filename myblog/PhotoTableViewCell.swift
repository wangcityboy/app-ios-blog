//
//  giftTableViewCell.swift
//  dantang
//
//  Created by HYZ on 16/10/19.
//  Copyright © 2016年 HYZ. All rights reserved.
//

import UIKit
import Kingfisher


protocol photoCellPushtoDetailDelegate :NSObjectProtocol {
    func photoCellPushtoDetail(isleft:Bool, tag:Int)
}

class PhotoTableViewCell: UITableViewCell {
    let wb = mainScreenWidth / 750
    let liftView = PhotoViewCell()
    let rightView = PhotoViewCell()
    weak var delegate : photoCellPushtoDetailDelegate?
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        
        super.init(style: UITableViewCellStyle.default, reuseIdentifier: String?.none)
        self.makeCellUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    
    func  makeCellUI(){
       
        liftView.frame = CGRect.init(x: 10*wb, y: 10*wb, width: 355*wb, height: 340*wb)
        self.addSubview(liftView)
        
        let  gesturnL :UITapGestureRecognizer = UITapGestureRecognizer.init(target: self, action:#selector(PhotoTableViewCell.liftPush))
        liftView.addGestureRecognizer(gesturnL)
        
        
        
        rightView.frame = CGRect.init(x: 385*wb, y: 10*wb, width: 355*wb, height: 340*wb)
        self.addSubview(rightView)
        
        let  gesturnR :UITapGestureRecognizer = UITapGestureRecognizer.init(target: self, action:  #selector(rightPush))
        rightView.addGestureRecognizer(gesturnR)
        
        
        self.backgroundColor = UIColor.white
        
        
    }
    func liftPush(){
        delegate?.photoCellPushtoDetail(isleft: true, tag: self.tag)
        
    }
    
    func rightPush(){
        delegate?.photoCellPushtoDetail(isleft: false, tag: self.tag)
    }
    
    func setliftView(model:PhotosModel){
        let url = URL(string: server_url + model.dFace!)
        self.liftView.logo.kf.setImage(with: url)
        self.liftView.name.text = model.dName! + "-[" + String(describing: (model.dImages?.count)!) + "]"
        self.liftView.date.text = model.dDate
    }
    
    func setrightView(model:PhotosModel){
        let url = URL(string: server_url +  model.dFace!)
        self.rightView.logo.kf.setImage(with: url)
        self.rightView.name.text = model.dName! + "-[" + String(describing: (model.dImages?.count)!) + "]"
        self.rightView.date.text = model.dDate
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
