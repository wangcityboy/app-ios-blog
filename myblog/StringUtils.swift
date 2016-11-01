//
//  StringUtils.swift
//
//  Created by 王海峰 on 15/8/14.
//  Copyright (c) 2015年 云飞凌风. All rights reserved.
//

import Foundation

class StringUtils {
   
    
    //格式化日期
    class func formatStrDate(strDate:String)-> String {
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        let dateFromString = dateFormatter.date(from: strDate)
        dateFormatter.dateFormat = "yyyy-MM-dd"
        let formatDate = dateFormatter.string(from: dateFromString!)
        return formatDate
    }
    

    
    //将url类参数拆分成key、value数组
//    class func splitTranStr(str: String) -> [String: String] {
//        let arr1 = str.componentsSeparatedBy("&")
//        var ret: [String: String] = [String: String]()
//        for v in arr1 {
//            let arr2 = v.componentsSeparatedByString("=")
//            var s = ""
//            for var i = 1;i < arr2.count; i += 1 {
//                if (i == 1) {
//                    s = s + arr2[i]
//                } else {
//                    s = s + "=\(arr2[i])"
//                }
//            }
//            ret[arr2[0]] = s
//        }
//        return ret
//    }
    
    
    //将字节数组转换成十六进制字符串
//    class func getHexStrFromByteArray(byteArray: [UInt8]) -> String {
//        var hexStr: String = ""
//        for i in 0 ..< byteArray.count{
//            let newHexStr = NSString(format: "%x", byteArray[i]&0xff)
//            if (newHexStr.length == 1) {
//                hexStr = hexStr + "0" + (newHexStr as String)
//            } else {
//                hexStr = hexStr + (newHexStr as String)
//            }
//        }
//        return hexStr
//    }
    
    
    //将UIImage转换成十六进制字符串
//    class func getHexStrFromImage(image: UIImage) -> String {
//        //转换成NSData
//        let imageData = UIImageJPEGRepresentation(image, 0.5)
//        
//        //转换成byte数组
//        var byteArray: [UInt8] = [UInt8]()
//        for i in 0..<imageData!.count {
//            var temp: UInt8 = 0
//            imageData!.copyBytes(to: &temp, from: NSRange(location: i, length: 1))
//            byteArray.append(temp)
//        }
//        return getHexStrFromByteArray(byteArray)
//    }
    
    
    //从毫秒转换成时间
    class func getDateString(time: Double, format: String) -> String {
        let date = NSDate(timeIntervalSince1970: time/1000)
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        return dateFormatter.string(from: date as Date)
    }
    
    
    //两个毫秒时间之间的天数
    class func getDayCount(fromTime: Double, toTime: Double) -> Int {
        return Int((toTime - fromTime)/1000/3600/24)
    }
    
    
    //格式化文件或文件夹大小，返回123K、12.3M或12.3G
    class func formatFileSize(sizeInB: Int64) -> String {
        let sizeInKB = sizeInB / 1000
        if (sizeInKB < 1000) {
            return "\(sizeInKB)K"
        } else if (sizeInKB >= 1000 && sizeInKB < 1000000) {
            return String(format: "%.1fM", Float(sizeInKB) / 1000)
        } else {
            return String(format: "%.1fG", Float(sizeInKB) / 1000000)
        }
    }
    
}
