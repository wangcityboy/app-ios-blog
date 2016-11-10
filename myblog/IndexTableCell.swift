//
//  IndexTableCell.swift
//  myblog
//
//  Created by chinaskin on 16/11/10.
//  Copyright © 2016年 wanghaifeng. All rights reserved.
//

import UIKit
import Kingfisher
class IndexTableCell: UITableViewCell {
    
    var myimageView = UIImageView()
    var mytitle = UILabel()
    let wb = mainScreenWidth / 750
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        
        super.init(style: UITableViewCellStyle.default, reuseIdentifier: String?.none)
        self.makeCellUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
    func  makeCellUI(){
        myimageView.frame = CGRect.init(x: 15*wb, y:15*wb, width:720*wb, height: 290*wb)
        self .addSubview(myimageView)
        
        mytitle.frame = CGRect.init(x: 20*wb, y:260*wb, width: 690*wb, height: 30*wb)
        mytitle.textAlignment = .left
        mytitle.textColor = UIColor.purple
        mytitle.font = UIFont.systemFont(ofSize: 14)
        self.addSubview(mytitle)
        
        
    }
    
    func setData(model:Indexmodel){
        let url = URL(string: server_url + model.aImage!)
        self.myimageView.kf.setImage(with: url!)
        self.mytitle.text = model.aTitle!
        
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
