//
//  FileUtils.swift
//
//  Created by 王海峰 on 15/8/14.
//  Copyright (c) 2015年 云飞凌风. All rights reserved.
//

import Foundation

class FileUtils {
    //保存图片
//    class func saveImage(image: UIImage, withFileName imageName: String, ofType fileExtension: String) {
//        let path = NSSearchPathForDirectoriesInDomains(FileManager.SearchPathDirectory.cachesDirectory, FileManager.SearchPathDomainMask.userDomainMask, true)[0]
//        
//        var filePath = path + "/"
//        filePath = filePath + "images/"
//        let fileName = filePath + imageName + "." + fileExtension
//        createDir(fileDir: filePath)
//        
//        if (fileExtension.lowercased == "png") {
//            do{
//                try UIImagePNGRepresentation(image)?.writeToFile(fileName, options: NSData.WritingOptions.AtomicWrite)
//            }catch{
//                
//            }
//            
//        } else if (fileExtension.lowercased == "jpg" || fileExtension.lowercased == "jpeg") {
//            do{
//                try UIImageJPEGRepresentation(image, 1.0)!.writeToFile(fileName, options: NSData.WritingOptions.AtomicWrite)
//            }catch{
//                
//            }
//        }
//        
//    }
    
    //读取图片
    class func loadImage(imageName: String, ofType fileExtension: String) -> UIImage? {
        let path = NSSearchPathForDirectoriesInDomains(FileManager.SearchPathDirectory.cachesDirectory, FileManager.SearchPathDomainMask.userDomainMask, true)[0]
        var filePath = path + "/"
        filePath = filePath + "images/"
        let fileName = filePath + imageName + "." + fileExtension
        
        if let a = UIImage(contentsOfFile: fileName) {
            return a
        } else {
            return nil
        }
    }
    
    //判断文件夹是否存在，如否，则创建
    class func createDir(fileDir: String) {
        let fileManager = FileManager()
        if (!fileManager.fileExists(atPath: fileDir)) {
            do {try fileManager.createDirectory(atPath: fileDir, withIntermediateDirectories: true, attributes: nil)}catch{}
        }
    }
    
    //计算文件或文件夹大小，返回B单位
    class func fileSizeForDir(path: NSString) -> Int64 {
        var size: Int64 = 0
        do{
            let fm = FileManager.default
            
            let arr:[String]? = try fm.contentsOfDirectory(atPath: path as String)
            if let array = arr {
                for i in 0 ..< array.count {
                    let fullPath = path.appendingPathComponent(array[i])
//                    var isDir = ObjCBool.init(true)
//                    if (!(fm.fileExistsAtPath(fullPath, isDirectory: &isDir) && isDir)) {
//                        let fileAttributeDic = try fm.attributesOfItem(atPath: fullPath)
//                        size = size + (fileAttributeDic["NSFileSize"] as! NSNumber).longLongValue
//                    } else {
//                        size = size + fileSizeForDir(path: fullPath as NSString)
//                    }
                    size = size + fileSizeForDir(path: fullPath as NSString)
                }
            }
            }catch{
                
            }
        return size
    }
    
    //计算缓存文件夹大小，返回B单位
    class func calcFoldSize() -> Int64 {
        let cachePath1 = NSSearchPathForDirectoriesInDomains(FileManager.SearchPathDirectory.cachesDirectory, FileManager.SearchPathDomainMask.userDomainMask, true)[0]
        let cachePath = cachePath1 + "/"
        
        let cacheSize = fileSizeForDir(path: cachePath as NSString)
        
        return cacheSize
    }
    
    //删除文件或文件夹
    class func removeFiles(path: NSString) {
        do{
            let fm = FileManager.default
            let arr:[String]? = try fm.contentsOfDirectory(atPath: path as String)
            if let array = arr {
                for i in 0 ..< array.count {
                    let fullPath = path.appendingPathComponent(array[i])
                    try fm.removeItem(atPath: fullPath)
                }
            }
        }catch{
            
        }
        
    }
    
    //删除缓存文件夹内文件
    class func removeFiles() {
        let cachePath1 = NSSearchPathForDirectoriesInDomains(FileManager.SearchPathDirectory.cachesDirectory, FileManager.SearchPathDomainMask.userDomainMask, true)[0]
        let cachePath = cachePath1 + "/"
        removeFiles(path: cachePath as NSString)
    }
    
}
