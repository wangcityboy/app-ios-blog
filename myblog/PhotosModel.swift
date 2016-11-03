//
//  PhotoDetailModel.swift
//  myblog
//
//  Created by chinaskin on 16/10/29.
//  Copyright © 2016年 wanghaifeng. All rights reserved.
//

import UIKit

class PhotosModel: NSObject {
    var dId :String?
    var dName :String?
    var dFace :String?
    var dDate :String?
    var dImages :NSArray?

    func setPhotomodelData(data:NSDictionary) -> PhotosModel {
        let model =  PhotosModel()
        model.dId = data["tg_id"] as?String
        model.dName = data["tg_name"] as?String
        model.dFace = data["tg_face"] as?String
        model.dDate = data["tg_date"] as?String
        model.dImages = data["tg_images"] as?NSArray
        return model;
        
    }
    
    
}

