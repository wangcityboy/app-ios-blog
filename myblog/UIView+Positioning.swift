//
//  UIView+Positioning.swift
//  quanzhan
//
//  Created by 王海峰 on 15/8/14.
//  Copyright (c) 2015年 云飞凌风. All rights reserved.
//

import UIKit


extension UIView {
    
    var x: CGFloat {
        get {
            return frame.origin.x;
        }
        set {
            var rect = frame;
            rect.origin.x = newValue;
            frame = rect;
        }
    }
    
    var y: CGFloat {
        get {
            return frame.origin.y;
        }
        set {
            var rect = frame;
            rect.origin.y = newValue;
            frame = rect;
        }
    }
    
    var width: CGFloat {
        get {
            return frame.width;
        }
        set {
            var rect = frame;
            rect.size.width = newValue;
            frame = rect;
        }
    }
    
    var height: CGFloat {
        get {
            return frame.height;
        }
        set {
            var rect = frame;
            rect.size.height = newValue;
            frame = rect;
        }
    }
    
    var origin: CGPoint {
        get {
            return frame.origin;
        }
        set {
            x = newValue.x;
            y = newValue.y;
        }
    }
    
    var size: CGSize {
        get {
            return frame.size;
        }
        set {
            width = newValue.width;
            height = newValue.height;
        }
    }
    
    var right: CGFloat {
        get {
            return x + width;
        }
        set {
            x = newValue - width;
        }
    }
    
    var bottom: CGFloat {
        get {
            return y + height;
        }
        set {
            y = newValue - height;
        }
    }
    
    var centerX: CGFloat {
        get {
            return center.x;
        }
        set {
            center = CGPoint(x:newValue, y:centerY)
        }
    }
    
    var centerY: CGFloat {
        get {
            return center.y;
        }
        set {
            center = CGPoint(x:centerX, y:newValue);
        }
    }
    
}
