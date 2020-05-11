//
//  SJPageCollectionView.swift
//  MyDouYuLive
//
//  Created by song jian on 2020/5/6.
//  Copyright © 2020 song jian. All rights reserved.
//

import UIKit

private let PageContentCollectionViewCellID = "PageContentCollectionViewCellID"


/// 滚动collectionView带动titleView中滑块渐变的协议，只能被类实现
protocol SJPageContentViewDelegate: class {
    
    /// 监听滚动collectionView带动titleView中滑块渐变的代理方法
    /// - Parameters:
    ///   - pageContentView: 包含collectionView的View类
    ///   - sourceIndex: 开始滚动时的标题索引
    ///   - targetIndex: 结束滚动时的标题索引
    ///   - progress: 滚动的进度
    func pageContentView(pageContentView: SJPageContentView,
                         sourceIndex: Int,
                         targetIndex: Int,
                         progress: CGFloat)
}

/// 标题滚动栏对应下的内容View类
class SJPageContentView: SJBaseView {
    
    // MARK:- 定义属性
    
    /// 保存子控制器的数组
    private var childVCs: [UIViewController]
    /// 加载子控制器的父亲控制器,用weak修饰防止循环引用
    private weak var parentVC: UIViewController?
    /// 保存collectionView初始的偏移量
    private var startOffsetX: CGFloat = 0
    /// 是否禁止collectionView滚动带动title变动的协议，默认不禁止
    private var isForbiddenSJPageContentViewDelegate = false
    /// 代理方法
    weak public var delegate: SJPageContentViewDelegate?
    
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
        
        // 3.设置数据源和代理
        collectionView.dataSource = self
        collectionView.delegate = self
        
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

// MARK:- 遵守UICollectionViewDelegate
extension SJPageContentView: UICollectionViewDelegate {
    /// 开始拖拽时的监听方法
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        // 当滚动的代理方法实现时表明collectionView被拖拽带动titleView的改变
        // 此时需要启用SJPageContentViewDelegate的代理方法
        self.isForbiddenSJPageContentViewDelegate = false
        self.startOffsetX = scrollView.contentOffset.x
    }
    
    /// 滑动中的监听方法
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
        // 0.判断是否要启用SJPageContentViewDelegate的代理方法
        guard self.isForbiddenSJPageContentViewDelegate  == false else {
            return
        }
        
        // 1.定义需要的属性:滚动进度、源索引、目标索引
        var progress: CGFloat
        var sourceIndex: Int
        var targetIndex: Int
        
        
        // 2.判断左滑还是右滑
        let currOffSetX: CGFloat = scrollView.contentOffset.x
        let collectionViewW: CGFloat = self.collectionView.bounds.width
        let radio: CGFloat = currOffSetX/collectionViewW
        // 左滑
        if currOffSetX > startOffsetX {
            progress = radio - floor(radio)
            sourceIndex = Int(currOffSetX/collectionViewW)
            targetIndex = sourceIndex+1
            if targetIndex >= self.childVCs.count {
                targetIndex = self.childVCs.count-1
            }
            //恰好滑完一个页面
            if currOffSetX-startOffsetX == collectionViewW {
                progress = 1
                targetIndex = sourceIndex
            }
        } else { //右滑
            progress = 1 - (radio - floor(radio))
            targetIndex = Int(currOffSetX/collectionViewW)
            sourceIndex = targetIndex+1
            if sourceIndex >= self.childVCs.count {
                sourceIndex = self.childVCs.count-1
            }
        }
//        print("progress \(progress), sourceIndex \(sourceIndex), targetIndex \(targetIndex)")
        // 3.通知代理调用相应的方法
        self.delegate?.pageContentView(pageContentView: self, sourceIndex: sourceIndex, targetIndex: targetIndex, progress: progress)
        
    }
}

// MARK:- 对外开放的方法
extension SJPageContentView {
    
    /// 设置collectionView的偏移量，让外界的代理方法调用
    /// - Parameter targetIndex: 滚动的目标索引
    public func setCollectionCellIndex(targetIndex: Int) {
        // 当来的该方法时表明是点击被title点击了，带动collectionView滚动，
        // 此时需要禁止SJPageContentViewDelegate的代理方法
        self.isForbiddenSJPageContentViewDelegate = true
        let offsetX = CGFloat(targetIndex) * self.collectionView.bounds.width
        self.collectionView.setContentOffset(CGPoint(x: offsetX, y: 0), animated: true)
    }
}
