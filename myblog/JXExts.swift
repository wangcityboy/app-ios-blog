//
//  JXExts.swift
//
//  Created by 王海峰 on 15/8/14.
//  Copyright (c) 2015年 云飞凌风. All rights reserved.
//

import UIKit

struct JXExt {
    /* 屏幕相关 */
    static let SCREEN_WIDTH: CGFloat = UIScreen.main.bounds.size.width
    static let SCREEN_HEIGHT: CGFloat = UIScreen.main.bounds.size.height
    
    /* 组件相关 */
    static let NAV_BAR_HEIGHT: CGFloat = 44     //导航条高度
    static let STATUS_BAR_HEIGHT: CGFloat = 20  //状态栏高度
    static let TOOL_BAR_HEIGHT: CGFloat = 44    //工具条高度
    static let TAB_BAR_HEIGHT: CGFloat = 49     //底部选项卡高度
}

//尺寸类
class JXExtSize: NSObject {
    //一半
    class func harf(num: CGFloat) -> CGFloat {
        return (num) / 2
    }
}

//颜色类
class JXExtColor: NSObject {
    class func color(color: (CGFloat, CGFloat, CGFloat)) -> UIColor {
        let (r, g, b) = color
        return JXExtColor.color(red: r, green: g, blue: b)
    }
    
    class func color(red: CGFloat, green: CGFloat, blue: CGFloat) -> UIColor {
        return JXExtColor.color(red: red, green: green, blue: blue, alpha: 1)
    }
    
    class func color(red: CGFloat, green: CGFloat, blue: CGFloat, alpha: CGFloat) -> UIColor {
        return UIColor(red: red / 255.0, green: green / 255.0, blue: blue / 255.0, alpha: alpha)
    }
}

//画图类
class JXExtDraw: NSObject {
    //画一条线
    class func drawALineWithFrame(frame: CGRect!, color: UIColor!, parentLayer: CALayer!) {
        let layer: CALayer = CALayer()
        layer.frame = frame
        layer.backgroundColor = color.cgColor
        parentLayer.addSublayer(layer)
    }
}

//图片类
class JXExtImage: NSObject {
    //对imageWithData的包装，不会有imageNamed的缓存占用内存问题
    class func imageWithFile(name: String!, type: String!) -> UIImage? {
        let allName: String! = name + "@2x";
        let path: String? = Bundle.main.path(forResource: allName, ofType: type)
        var image: UIImage?
        if (path != nil) {
            do{
                let data = try NSData(contentsOfFile: path!, options: NSData.ReadingOptions.alwaysMapped)
                let imageData: NSData! = data
                image = UIImage(data: imageData as Data)
            }catch{
                
            }
        }
        return image
    }
    
    //UIColor生成UIImage
    class func imageWithColor(color: UIColor!, imageSize:CGSize!) -> UIImage {
        let rect: CGRect! = CGRect(x:0.0, y:0.0, width:imageSize.width, height:imageSize.height)
        UIGraphicsBeginImageContext(rect.size)
        let context: CGContext! = UIGraphicsGetCurrentContext()
        context.setFillColor(color.cgColor)
        context.fill(rect)
        
        let theImage: UIImage! = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return theImage
    }
}



//扩张NSString类，计算文字高度
extension NSString {
    func textSizeWithFont(font: UIFont, constrainedToSize size:CGSize) -> CGSize {
        var textSize:CGSize!
        if size.equalTo(CGSize.zero) {
            let attributes = NSDictionary(object: font, forKey: NSFontAttributeName as NSCopying)
            textSize = self.size(attributes: attributes as? [String : AnyObject])
        } else {
            let option = NSStringDrawingOptions.usesLineFragmentOrigin
            let attributes = NSDictionary(object: font, forKey: NSFontAttributeName as NSCopying)
            let stringRect = self.boundingRect(with: size, options: option, attributes: attributes as? [String : AnyObject], context: nil)
            textSize = stringRect.size
        }
        return textSize
    }
}
