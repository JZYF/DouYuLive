//
//  SJHomeVC.swift
//  MyDouYuLive
//
//  Created by song jian on 2020/5/4.
//  Copyright © 2020 song jian. All rights reserved.
//

import UIKit

/// pageTitleView的高度
let pageTitleViewH: CGFloat = 40

class SJHomeVC: SJBaseVC {
    
    // MARK:- 懒加载属性
    
    /// 懒加载标题栏View
    lazy var homePageTitleView: SJPageTitleView = { [weak self] in
        // 1.设置frame
        let titleViewFrame = CGRect(x: 0, y: kStatuHeight+kNavigationBarHeight, width: kScreenW, height: pageTitleViewH)
        
        // 2.添加titles(数据源)
        let titles:[String] = ["推荐", "游戏", "娱乐", "趣玩"]
        let homePageTitleView: SJPageTitleView = SJPageTitleView(frame: titleViewFrame, titles: titles)
        
        homePageTitleView.delegate = self
        return homePageTitleView
    }()
    
    
    /// 懒加载标题栏对应的内容view，内部封装了collectionView
    lazy var homePageContentView: SJPageContentView = { [weak self] in
        // 1.设置frame
        let contentViewY = kStatuHeight+kNavigationBarHeight+pageTitleViewH
        let contentViewFrame = CGRect(x: 0, y: contentViewY, width: kScreenW, height: kScreenH-contentViewY)
        
        // 2.添加自控制器
        var childVCs = [UIViewController]()
        for _ in 0..<4 {
            let childVC = UIViewController()
            childVC.view.backgroundColor = colorWithRGBA(CGFloat(arc4random_uniform(255)), CGFloat(arc4random_uniform(255)), CGFloat(arc4random_uniform(255)), 1.0)
            childVCs.append(childVC)
        }
        let homePageContentView = SJPageContentView(frame: contentViewFrame, childVCs: childVCs, parentVC: self)
        return homePageContentView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // 设置UI
        setupUI()
        
    }
    
}

// MARK:- 设置UI 的扩展
extension SJHomeVC {
    private func setupUI() {
        // 1、设置导航栏
        setupNavigation()
    
        // 2、设置顶部标题栏
        self.view.addSubview(self.homePageTitleView)
        
        // 3、设置标题栏对应的内容View
        self.view.addSubview(self.homePageContentView)
//        self.homePageContentView.backgroundColor = .purple
    }
    
    
    /// 设置首页的导航栏
    private func setupNavigation() {
        
        // 1、设置左侧按钮
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(imageName: "logo")

        // 2、设置右侧按钮
        let btnSize = CGSize(width: AdaptW(40), height: AdaptW(40))
        let historyItem = UIBarButtonItem(imageName: "image_my_history", highlightedImageName: "Image_my_history_click", size: btnSize)
        
        let searchItem = UIBarButtonItem(imageName: "btn_search", highlightedImageName: "btn_search_clicked", size: btnSize)
        
        let qrcodeItem = UIBarButtonItem(imageName: "Image_scan", highlightedImageName: "Image_scan_click", size: btnSize)
        
        self.navigationItem.rightBarButtonItems = [historyItem, searchItem,
                                                   qrcodeItem]
    }
    
}

// MARK:- 遵守SJPageTitleViewDelegate
extension SJHomeVC: SJPageTitleViewDelegate {
    /// 通过实现代理方法设置collectionView的滚动
    func pageTitleView(titleView: SJPageTitleView, selectedIndex index: Int) {
        self.homePageContentView.setCollectionCellIndex(targetIndex: index)
    }
}
