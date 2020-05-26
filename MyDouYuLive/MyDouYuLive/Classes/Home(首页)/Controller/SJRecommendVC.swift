//
//  SJRecommendVC.swift
//  MyDouYuLive
//
//  Created by song jian on 2020/5/25.
//  Copyright © 2020 song jian. All rights reserved.
//

import UIKit

// MARK:- 常量
/// item直接的间距
private let kItemMargin: CGFloat = AdaptW(10)
/// item的宽度
private let kItemW: CGFloat = (kScreenW-3*kItemMargin) / 2
/// item的高度
private let kItemH: CGFloat = kItemW*3 / 4
/// section的头部高度
private let kSectionHeaderH: CGFloat = AdaptW(40)
/// normal的item的id
private let kNormalItemCellId: String = "SJRecommendCellId"
private let kSectionHeaderId: String = "SJRecommendSectionHeaderId"

class SJRecommendVC: SJBaseVC {
    
    // MARK:- 懒加载属性
    private lazy var collectionView: UICollectionView = { [weak self] in
        // 1.创建布局
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: kItemW, height: kItemH)
        layout.minimumLineSpacing = 0 // 设置行间距
        layout.minimumInteritemSpacing = kItemMargin // 设置item直接的间距
        layout.headerReferenceSize = CGSize(width: kScreenW,
                                            height: kSectionHeaderH) // section头部的大小
        layout.sectionInset = UIEdgeInsets(top: 0, left: kItemMargin, bottom: 0, right: kItemMargin)
        
        
        // 2.创建UICollectionView
        let collectionView: UICollectionView = UICollectionView(frame: (self?.view.bounds)!  , collectionViewLayout: layout)
        collectionView.autoresizingMask = [.flexibleHeight, .flexibleWidth]  // 自适应高度和宽度
        collectionView.backgroundColor = .white
        
        // 3.设置代理和数据源
        collectionView.delegate = self
        collectionView.dataSource = self
        
        // 4.注册cell和header
        collectionView.register(SJRecommendNormalCell.self, forCellWithReuseIdentifier: kNormalItemCellId)
        collectionView.register(SJCollectionHeaderView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: kSectionHeaderId)
        return collectionView
        
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.purple
        // 1.设置UI
        setupUI()
    }
    


}

// MARK:- 设置UI界面
extension SJRecommendVC {
    private func setupUI() {
        // 1.将collectionView添加到view中
        self.view.addSubview(self.collectionView)
    }
}

// MARK:- 实现UICollectionViewDelegate和UICollectionViewDataSource
extension SJRecommendVC: UICollectionViewDelegate, UICollectionViewDataSource {
    
    /// 有12组
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 12
    }
    
    /// 每组有多少个item
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if section == 0 {
            return 8
        }
        return 4
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        // 1.取出section的header
        let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: kSectionHeaderId, for: indexPath)
//        headerView.backgroundColor = .green
        return headerView
    }
    
    /// 设置cell
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        // 1.获取cell
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: kNormalItemCellId, for: indexPath)
//        cell.backgroundColor = .red
        return cell
    }
    

}
