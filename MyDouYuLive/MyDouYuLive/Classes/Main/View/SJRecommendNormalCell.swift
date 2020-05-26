//
//  SJRecommendNormalCell.swift
//  MyDouYuLive
//
//  Created by song jian on 2020/5/25.
//  Copyright © 2020 song jian. All rights reserved.
//

import UIKit

/// SJRecommendNormalCell中的间距
private let kMargin: CGFloat = 10
/// 当做每行cell间距的距离
private let kLineH: CGFloat = 2

class SJRecommendNormalCell: SJBaseCollectionViewCell {
    
    var imgView: UIImageView?
    var bottomIconImgView: UIImageView?
    var bottomTitleLable: UILabel?
    var titleLable: UILabel?
    var onlineNumsOfPeopleBtn: UIButton?
    var bottomLineView: UIView?
    
    
    override func initSubViews() {
        self.setupUI()
    }
}

// MARK:- 设置UI的扩展
extension SJRecommendNormalCell {
    
    private func setupUI() {
        imgView = UIImageView.createImgView(imgName: "live_cell_default_phone", contentMode: .scaleToFill, superView: self, constraintMakerClosure: { (make) in
            make.left.right.top.equalToSuperview().inset(0)
            make.height.equalTo(self.bounds.height * 0.75)
        })
        imgView?.layer.cornerRadius = 5 // 设置圆角
        imgView?.layer.masksToBounds = true
        
        bottomIconImgView = UIImageView.createImgView(imgName: "home_live_cate_normal", contentMode: .scaleAspectFit, superView: self, constraintMakerClosure: { (make) in
            make.left.equalToSuperview().offset(0)
            make.top.equalTo(imgView!.snp.bottom).offset(kMargin)
        })
        
        bottomTitleLable = UILabel.createLable(text: "斗鱼直播", textColor: kGrayTextColor, superView: self, constraintMakerClosure: { (make) in
            make.centerY.equalTo(bottomIconImgView!.snp.centerY)
            make.left.equalTo(bottomIconImgView!.snp.right).offset(kMargin/2)
        })
        
        titleLable = UILabel.createLable(text: "斗鱼直播",textColor: kWhite,superView: imgView, constraintMakerClosure: { (make) in
            make.left.bottom.equalToSuperview().inset(kMargin/2)
        })
        
        onlineNumsOfPeopleBtn = UIButton.createButton(normalTitle: "6666人在线", highlightedTitle: nil,normalTitleColor: kWhite, normalImgName: "Image_online", highlightedImgName: nil, contentMode: .scaleAspectFit,superView: imgView ) { (make) in
            make.right.bottom.equalToSuperview().inset(kMargin/2)
        }
        onlineNumsOfPeopleBtn?.isUserInteractionEnabled = false // 只显示图片和文字，不可点击
    }
}


