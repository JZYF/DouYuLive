//
//  SJPageCollectionView.swift
//  MyDouYuLive
//
//  Created by song jian on 2020/5/6.
//  Copyright © 2020 song jian. All rights reserved.
//

import UIKit

private let PageContentCollectionViewCellID = "PageContentCollectionViewCellID"

/// 标题滚动栏对应下的内容View类
class SJPageContentView: SJBaseView {
    
    // MARK:- 定义属性
    
    /// 保存子控制器的数组
    private var childVCs: [UIViewController]
    /// 加载子控制器的父亲控制器,用weak修饰防止循环引用
    private weak var parentVC: UIViewController?
    
    // MARK:- 懒加载属性
    
    /// 初始化collectionView，闭包中使用weak，防止循环引用
    lazy var collectionView: UICollectionView = { [weak self] in
        // 1.设置layout
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = (self?.bounds.size)!
        layout.minimumLineSpacing = 0 //最小行间距
        layout.minimumInteritemSpacing = 0 //最小列间距
        layout.scrollDirection = .horizontal
        
        // 2.创建UICollectionView
        let collectionView: UICollectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: layout)
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.isPagingEnabled = true
        collectionView.bounces = false
        
        // 3.设置数据源
        collectionView.dataSource = self
        
        // 4.注册UICollectionViewCell
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: PageContentCollectionViewCellID)
        
        return collectionView
    }()

    init(frame: CGRect, childVCs: [UIViewController],
         parentVC: UIViewController?) {
        self.childVCs = childVCs
        self.parentVC = parentVC
        
        super.init(frame: frame)
        
        // 设置UI
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

// MARK:- 设置UI界面的扩展
extension SJPageContentView {
    
    private func setupUI(){
        // 1.将所有的childVC添加到parentVC中
        for childVC in self.childVCs {
            self.parentVC?.addChild(childVC)
        }
        
        // 2.添加collectionView
        self.addSubview(self.collectionView)
        self.collectionView.frame = self.bounds
    }
}

// MARK:- 遵守UICollectionViewDataSource
extension SJPageContentView: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.childVCs.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        // 1.创建cell
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PageContentCollectionViewCellID, for: indexPath)
        
        // 2.给cell设置内容
        // 2.1.防止cell重用时保留之前的view，先移除之前的子view
        for view in cell.contentView.subviews {
            view.removeFromSuperview()
        }
        let childVC = childVCs[indexPath.item]
        childVC.view.frame = cell.contentView.frame
        cell.contentView.addSubview(childVC.view)
        
        return cell
    }
    
    
}

// MARK:- 对外开放的方法
extension SJPageContentView {
    
    /// 设置collectionView的偏移量，让外界的代理方法调用
    /// - Parameter targetIndex: 滚动的目标索引
    public func setCollectionCellIndex(targetIndex: Int) {
        let offsetX = CGFloat(targetIndex) * self.collectionView.bounds.width
        self.collectionView.setContentOffset(CGPoint(x: offsetX, y: 0), animated: true)
    }
}
