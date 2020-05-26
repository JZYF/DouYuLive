//
//  SJCollectionHeaderView.swift
//  MyDouYuLive
//
//  Created by song jian on 2020/5/26.
//  Copyright © 2020 song jian. All rights reserved.
//

import UIKit

/// 间距
private let kMargin: CGFloat = AdaptW(10)

class SJCollectionHeaderView: UICollectionReusableView {
    var headerIconImgView: UIImageView?
    var headerTitleLable: UILabel?
    var headerBtn: UIButton?
    var bottomLineView: UIView?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

// MARK:- 设置UI的扩展
extension SJCollectionHeaderView {
    private func setupUI() {
        headerIconImgView = UIImageView.createImgView(imgName: "home_header_phone", contentMode: .scaleAspectFit, superView: self, constraintMakerClosure: { (make) in
            make.centerY.equalToSuperview()
            make.left.equalToSuperview().offset(kMargin)
        })
        
        headerTitleLable = UILabel.createLable(text: "颜值", superView: self, constraintMakerClosure: { (make) in
            make.centerY.equalTo(headerIconImgView!.snp.centerY)
            make.left.equalTo(headerIconImgView!.snp.right).offset(kMargin)
        })
        
        headerBtn = UIButton.createButton(normalTitle: "更多 >", highlightedTitle: "更多 >", normalImgName: nil, highlightedImgName: nil, superView: self, constraintMakerClosure: { (make) in
            make.centerY.equalTo(headerIconImgView!.snp.centerY)
            make.right.equalToSuperview().inset(kMargin)
        })
        
        bottomLineView = UIView.createView(backgroundColor: kBGGrayColor, superView: self, constraintMakerClosure: { (make) in
            make.left.right.top.equalToSuperview().inset(0)
            make.height.equalTo(kMargin)
        })
    }
}
