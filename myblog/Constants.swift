//
//  Constants.swift
//
//  Created by 王海峰 on 15/8/14.
//  Copyright (c) 2015年 云飞凌风. All rights reserved.
//

import Foundation
//请求地址
let server_url =       "http://wanghaifeng.net"
let advertise_url =    "http://wanghaifeng.net/api/ios/advertise.php"

let article_url =      "http://wanghaifeng.net/api/ios/articleList.php"
let classify_url =     "http://wanghaifeng.net/api/ios/articleClassify.php"
let detail_url =       "http://wanghaifeng.net/api/ios/articleDetail.php"

let dir_url =          "http://wanghaifeng.net/api/ios/dir.php"
let photos_url =       "http://wanghaifeng.net/api/ios/photos.php"


let login_url =        "http://wanghaifeng.net/api/ios/userLogin.php"
let userinfo_url =     "http://wanghaifeng.net/api/ios/userInfo.php"
let background_url =   "http://wanghaifeng.net/api/ios/background.php"
let project_url =      "http://wanghaifeng.net/api/ios/project.php"


//登录状态
var loginState:Bool  = false

//缓存用户信息
var userDefaults:UserDefaults = UserDefaults.standard
