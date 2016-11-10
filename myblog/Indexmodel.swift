//
//  Indexmodel.swift
//  myblog
//
//  Created by chinaskin on 16/11/10.
//  Copyright © 2016年 wanghaifeng. All rights reserved.
//

import Foundation
class Indexmodel:NSObject{
    
    var aId :String?
    var aTitle :String?
    var aUsername :String?
    var aClassify :String?
    var aImage :String?
    var aContent :String?
    var aDate :String?
    var aReadcount : Int?
    
    func setIndexmodelData(data:NSDictionary) -> Indexmodel {
        
        let model =  Indexmodel()
        model.aId = data["tg_id"] as?String
        model.aTitle = data["tg_title"] as?String
        model.aUsername = data["tg_username"] as?String
        model.aClassify = data["tg_classify"] as?String
        model.aImage = data["tg_image"] as?String
        model.aContent = data["tg_content"] as?String
        model.aDate = data["tg_date"] as?String
        model.aReadcount = data["tg_count"] as?Int
        
        return model
    }
    
}
