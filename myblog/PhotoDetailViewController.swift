//
//  PhotoDetailViewController.swift
//  myblog
//
//  Created by chinaskin on 16/11/3.
//  Copyright © 2016年 wanghaifeng. All rights reserved.
//

import UIKit

class PhotoDetailViewController: UIViewController,SliderGalleryControllerDelegate {
    var model : PhotosModel = PhotosModel()
    var sliderGallery : SliderGalleryController!


    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "图片详情"
        loadHeadView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.rdv_tabBarController.setTabBarHidden(true, animated: true)
        self.navigationItem.leftBarButtonItem = UIBarButtonItem.init(image: UIImage(named: "navigationbar_back"), style: .plain, target: self, action: #selector(trashClick))
    }
    
    //点击返回上一层
    func trashClick(){
        self.navigationController!.popToRootViewController(animated: true)
    }
    
    
    // 加载tableview广告轮播图
    func loadHeadView(){
        
        //初始化图片轮播组件
        sliderGallery = SliderGalleryController()
        sliderGallery.delegate = self
        sliderGallery.view.frame = CGRect(x: 0, y: 0, width: screenWidth,height: mainScreenHeight-62);
        self.view.addSubview(sliderGallery.view)
        
        
        //添加组件的点击事件
        let tap = UITapGestureRecognizer(target: self,action: #selector(handleTapAction))
        sliderGallery.view.addGestureRecognizer(tap)
        
    }
    
    
    //图片轮播组件协议方法：获取内部scrollView尺寸
    func galleryScrollerViewSize() -> CGSize {
        return CGSize(width: screenWidth, height: mainScreenHeight-62)
    }
    
    
    
    //图片轮播组件协议方法：获取数据集合
    func galleryDataSource() -> [String] {
        return self.model.dImages as! [String]
    }
    
    //点击事件响应
    func handleTapAction(_ tap:UITapGestureRecognizer)->Void{
        //获取图片索引值
        let index = sliderGallery.currentIndex
        
        let title = self.model.dName!
        
        //弹出索引信息
        let alertController = UIAlertController(title: "图片标题与索引：",message: "\(title)"+"\(index)", preferredStyle: .alert)
        let cancelAction = UIAlertAction(title: "确定", style: .cancel, handler: nil)
        alertController.addAction(cancelAction)
        self.present(alertController, animated: true, completion: nil)
    }

    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
    
    
}
