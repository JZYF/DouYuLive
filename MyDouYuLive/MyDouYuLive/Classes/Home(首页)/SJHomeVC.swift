//
//  SJHomeVC.swift
//  MyDouYuLive
//
//  Created by song jian on 2020/5/4.
//  Copyright © 2020 song jian. All rights reserved.
//

import UIKit

// pageTitleView的高度
let pageTitleViewH: CGFloat = 40

class SJHomeVC: SJBaseVC {
    
    lazy var homePageTitleView: SJPageTitleView = {
        let titleViewFrame = CGRect(x: 0, y: kStatuHeight+kNavigationBarHeight, width: kScreenW, height: pageTitleViewH)
        let titles:[String] = ["推荐", "游戏", "娱乐", "趣玩"]
        let homePageTitleView: SJPageTitleView = SJPageTitleView(frame: titleViewFrame, titles: titles)
        return homePageTitleView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // 设置UI
        setupUI()
        
        print(kScreenW)
        print(kScreenH)
    }
    
}

// MARK:- 设置UI 的扩展
extension SJHomeVC {
    private func setupUI() {
        // 1、设置导航栏
        setupNavigation()
    
        // 2、设置顶部标题栏
        self.view.addSubview(self.homePageTitleView)
    }
    
    
    // MARK:- 设置首页的导航栏
    private func setupNavigation() {
        
        // 1、设置左侧按钮
        self.navigationItem.leftBarButtonItem =
            UIBarButtonItem(imageName: "logo")
        
        // 2、设置右侧按钮
        let btnSize = CGSize(width: AdaptW(40), height: AdaptW(40))
        let historyItem = UIBarButtonItem(imageName: "image_my_history", highlightedImageName: "Image_my_history_click", size: btnSize)
        
        let searchItem = UIBarButtonItem(imageName: "btn_search", highlightedImageName: "btn_search_clicked", size: btnSize)
        
        let qrcodeItem = UIBarButtonItem(imageName: "Image_scan", highlightedImageName: "Image_scan_click", size: btnSize)
        
        self.navigationItem.rightBarButtonItems = [historyItem, searchItem,
                                                   qrcodeItem]
    }
    
    
}
