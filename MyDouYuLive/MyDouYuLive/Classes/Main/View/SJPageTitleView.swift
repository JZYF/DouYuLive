//
//  SJPageTitleView.swift
//  MyDouYuLive
//
//  Created by song jian on 2020/5/4.
//  Copyright © 2020 song jian. All rights reserved.
//

import UIKit

// 底部分割线的高度
private let kBottomLineH: CGFloat = 0.5
// label下划线的高度
private let kScrollLineH: CGFloat = 2


/// 标题的滚动条View
class SJPageTitleView: UIView {
    
    // MARK:- 定义属性
    private var titles: [String] = [String]()
    
    // MARK:- 懒加载属性
    lazy var labels: [UILabel] = [UILabel]()
    
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
        
        print(self.scrollView.frame)
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
        
        // 3、添加下划线和底部分割线
        setupScrollLineAndBottomLine()
    }
    
    // MARK:- 设置标题的labels
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
            
        }
        
    }
    
    
    // MARK:- 设置label的选中下划线和底部分割线
    private func setupScrollLineAndBottomLine() {
        // 1、设置第一个label默认为选中的颜色
        guard let firstLabel = self.labels.first else {
            return
        }
        firstLabel.textColor = kHighOrangeColor
        
        // 2、设置底部分隔线，将其添加到view中，不需要随着scrollView进行滚动
        let bottomLine: UIView = UIView()
        bottomLine.backgroundColor = klineColor
        bottomLine.frame = CGRect(x: 0, y: self.frame.height-kBottomLineH, width: self.frame.width, height: kBottomLineH)
        self.addSubview(bottomLine)
        
        // 3、设置选中下划线,将其添加到scrollView中
        self.scrollView.addSubview(self.scrollLine)
        scrollLine.frame = CGRect(x: firstLabel.frame.origin.x, y: self.frame.height-kScrollLineH, width: firstLabel.frame.width, height: kScrollLineH)
        
    }
    
}
