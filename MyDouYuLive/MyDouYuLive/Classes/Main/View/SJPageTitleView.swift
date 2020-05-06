//
//  SJPageTitleView.swift
//  MyDouYuLive
//
//  Created by song jian on 2020/5/4.
//  Copyright © 2020 song jian. All rights reserved.
//

import UIKit
import SnapKit

/// 底部分割线的高度
private let kBottomLineH: CGFloat = 0.5
/// label滚动条的高度
private let kScrollLineH: CGFloat = 2

/// 定义点击title带动contentView滚动的代理，只能被类实现
protocol SJPageTitleViewDelegate: class {
    func pageTitleView(titleView: SJPageTitleView,
                       selectedIndex index: Int)
}


/// 标题的滚动条View类
class SJPageTitleView: SJBaseView {
    
    // MARK:- 定义属性
    
    /// 保存标题的数据源
    private var titles: [String] = [String]()
    /// 保存当前点击label之前的label的索引，默认为第0个
    private var preLabelIndex: Int = 0
    /// 保存滑块的布局，用于之后的更新
    private var constraint: Constraint?
    /// 遵守协议的代理对象
    public weak var delegate: SJPageTitleViewDelegate?
    
    // MARK:- 懒加载属性
    /// 保存所有的label
    lazy var labels: [UILabel] = [UILabel]()
    /// 初始化scrollView
    lazy var scrollView: UIScrollView = {
        var scrollView: UIScrollView = UIScrollView()
        scrollView.bounces = false
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.showsVerticalScrollIndicator = false
        scrollView.scrollsToTop = false //不响应顶部状态栏的点击
        
        // MARK:- 设置临时的颜色
        scrollView.backgroundColor = kGreen
        return scrollView
    }()
    /// 初始化label下的滚动条
    lazy var scrollLine: UIView = {
        var scrollLine: UIView = UIView()
        scrollLine.backgroundColor = kHighOrangeColor
        return scrollLine
    }()
    
    
    /// 自定义构造器
    /// - Parameters:
    ///   - frame: frame
    ///   - titles: 标题数组
    init(frame: CGRect, titles: [String]) {
        self.titles = titles
        super.init(frame: frame)
        
        // 设置UI
        setupUI()
        
        //        print(self.scrollView.frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}


// MARK:- 设置UI的扩展
extension SJPageTitleView {
    
    private func setupUI() {
        // 1、添加scrollView
        self.addSubview(self.scrollView)
        self.scrollView.frame = self.bounds
        
        // 2、添加标题对应的labels
        setupLabels()
        
        // 3、添加滚动条和底部分割线
        setupScrollLineAndBottomLine()
    }
    
    /// MARK:- 设置标题的labels
    private func setupLabels() {
        // 1、设置label的宽度 长度 Y坐标
        let labelW: CGFloat = self.frame.width / CGFloat(self.titles.count)
        let labelH: CGFloat = self.frame.height
        let labelY: CGFloat = 0
        
        // 2、循环添加label
        for (index, title) in titles.enumerated() {
            // 2.1、创建label
            let label: UILabel = UILabel()
            
            // 2.2、设置label的属性
            label.text = title
            label.textColor = kGrayTextColor
            label.font = UIFont.systemFont(ofSize: Adapt(16))
            label.textAlignment = .center
            label.tag = index
            
            // 2.3、设置label的frame
            let labelX: CGFloat = CGFloat(index) * labelW
            label.frame = CGRect(x: labelX, y: labelY, width: labelW, height: labelH)
            
            // 2.4、将label添加到scrollView中
            self.scrollView.addSubview(label)
            self.labels.append(label)
            
            // 2.5.给label添加手势
            label.isUserInteractionEnabled = true
            let tapGes: UITapGestureRecognizer =
                UITapGestureRecognizer(target: self, action: #selector(self.titleLabelClick(tapGes:)))
            label.addGestureRecognizer(tapGes)
            
        }
        
    }
    
    
    /// 设置label的选中滚动条和底部分割线
    private func setupScrollLineAndBottomLine() {
        // 1、设置第一个label默认为选中的颜色
        guard let firstLabel = self.labels.first else {
            return
        }
        firstLabel.textColor = kHighOrangeColor
        
        // 2、设置底部分隔线，将其添加到view中，不需要随着scrollView进行滚动
        let bottomLine: UIView = UIView()
        bottomLine.backgroundColor = klineColor
        //        bottomLine.frame = CGRect(x: 0, y: self.frame.height-kBottomLineH, width: self.frame.width, height: kBottomLineH)
        self.addSubview(bottomLine)
        bottomLine.snp.makeConstraints { (make) in
            make.left.right.bottom.equalToSuperview()
            make.height.equalTo(kBottomLineH)
        }
        
        // 3、设置选中滚动条,将其添加到scrollView中
        self.scrollView.addSubview(self.scrollLine)
        //        scrollLine.frame = CGRect(x: firstLabel.frame.origin.x, y: self.frame.height-kScrollLineH, width: firstLabel.frame.width, height: kScrollLineH)
        scrollLine.snp.makeConstraints { (make) in
            self.constraint = make.left.right.equalTo(firstLabel).constraint
            make.bottom.equalTo(self)
            make.height.equalTo(kScrollLineH)
        }
    }
    
}

// MARK:- 监听titleLabel的点击事件
extension SJPageTitleView {
    
    /// title label的点击事件
    /// - Parameter tapGes: tap手势对象
    @objc private func titleLabelClick(tapGes: UITapGestureRecognizer) {
        // 1.获取点击的当前label
        guard let currLabel: UILabel = tapGes.view as? UILabel else {
            return
        }
        
        // 2.设置之前label和当前label的颜色变化
        let preLabel: UILabel = self.labels[preLabelIndex]
        preLabel.textColor = kGrayTextColor
        currLabel.textColor = kHighOrangeColor
        
        // 3.保存最新的下标
        preLabelIndex = currLabel.tag
        
        // 4.设置滚动条的位置滑动
        self.constraint?.deactivate()
        UIView.animate(withDuration: 0.25) {
            self.scrollLine.snp.makeConstraints { (make) in
                self.constraint = make.left.right.equalTo(currLabel).constraint
            }
            self.layoutIfNeeded() //立即刷新布局，否则没有动画效果
        }
        
        // 5.通知代理做事
        self.delegate?.pageTitleView(titleView: self, selectedIndex: preLabelIndex)
       
    }
}
