//
//  UIView-Extension.swift
//  MyDouYuLive
//
//  Created by song jian on 2020/5/26.
//  Copyright © 2020 song jian. All rights reserved.
//

import UIKit
import SnapKit

/// 对创建UIView的扩展方法
extension UIView {
    
    
    /// 快速创建 View 并使用 SnapKit 进行布局
    /// - Parameters:
    ///   - backgroundColor: View的背景颜色
    ///   - superView: 父视图
    ///   - constraintMakerClosure: 布局约束的闭包
    /// - Returns: 创建的View
    class func createView(backgroundColor: UIColor,
                          superView: UIView?,
                          constraintMakerClosure:(_ make: ConstraintMaker) -> ()) -> UIView{
        let view = UIView()
        view.backgroundColor = backgroundColor
        if let superV = superView {
            superV.addSubview(view)
            view.snp.makeConstraints { (make) in
                constraintMakerClosure(make) // 将make传给外部规定好的布局去使用
            }
        }
        return view
    }
    
    
    /// 快速创建UIImageView， 并使用SnapKit进行布局
    /// - Parameters:
    ///   - imgName: 图片名称
    ///   - contentMode: 图片显示的模式
    ///   - superView: 父视图
    ///   - constraintMakerClosure: 布局约束的闭包
    /// - Returns: 创建的UIImageView
    class func createImgView(imgName: String?,
                             contentMode: UIView.ContentMode? = nil,
                             superView: UIView?,
                             constraintMakerClosure:(_ make: ConstraintMaker) -> ()) -> UIImageView {
        let imgView = UIImageView()
        if let name = imgName {
            imgView.image = UIImage(named: name)
        }
        if let mode = contentMode {
            imgView.contentMode = mode
        }
        if let superV = superView {
            superV.addSubview(imgView)
            imgView.snp.makeConstraints { (make) in
                constraintMakerClosure(make)
            }
        }
        return imgView
    }
    
    
    /// 快速创建 UIButton
    /// - Parameters:
    ///   - normalTitle: 正常状态下的标题
    ///   - highlightedTitle: 高亮状态下的标题
    ///   - normalTitleColor: 正常状态下的标题颜色，默认为kMainTextColor
    ///   - highlightedTitleColor: 高亮状态下的标题颜色，默认为kMainTextColor
    ///   - normalImgName: 正常状态下的图片名称
    ///   - highlightedImgName: 高亮状态下的图片名称
    ///   - contentMode: 图片显示的模式
    ///   - font: 文字大小
    ///   - superView: 父视图
    ///   - constraintMakerClosure: 布局约束的闭包
    /// - Returns: 创建的UIButton
    class func createButton(normalTitle: String?,
                            highlightedTitle: String?,
                            normalTitleColor: UIColor? = kMainTextColor,
                            highlightedTitleColor: UIColor? = kMainTextColor,
                            normalImgName: String?,
                            highlightedImgName: String?,
                            contentMode: UIView.ContentMode? = nil,
                            font: UIFont? = UIFont.systemFont(ofSize: Adapt(14)),
                            superView: UIView?,
                            constraintMakerClosure:(_ make: ConstraintMaker) -> ()) -> UIButton {
        let btn = UIButton()
        if normalTitle != nil {
            btn.setTitle(normalTitle, for: .normal)
        }
        if highlightedTitle != nil {
            btn.setTitle(highlightedTitle, for: .highlighted)
        }
        btn.setTitleColor(normalTitleColor, for: .normal)
        btn.setTitleColor(highlightedTitleColor, for: .highlighted)
        btn.titleLabel?.font = font
        if normalImgName != nil {
            btn.setImage(UIImage(named: normalImgName!), for: .normal)
        }
        if highlightedImgName != nil {
            btn.setImage(UIImage(named: highlightedImgName!), for: .highlighted)
        }
        if let mode = contentMode {
            btn.imageView?.contentMode = mode
        }
        
        if let superV = superView {
            superV.addSubview(btn)
            btn.snp.makeConstraints { (make) in
                constraintMakerClosure(make)
            }
        }
        return btn
    }
    
    
    /// 快速创建UILabel
    /// - Parameters:
    ///   - text: label的内容
    ///   - textColor: 文字的颜色
    ///   - font: 文字的大小
    ///   - textAlignment: 文字的对齐方式
    ///   - superView: 父视图
    ///   - constraintMakerClosure: 布局约束的闭包
    /// - Returns: 创建的UILabel
    class func createLable(text: String?,
                           textColor: UIColor? = kMainTextColor,
                           font: UIFont? = UIFont.systemFont(ofSize: Adapt(14)),
                           textAlignment: NSTextAlignment = .left,
                           superView: UIView?,
                           constraintMakerClosure:(_ make: ConstraintMaker) -> ()) -> UILabel {
        let label: UILabel = UILabel()
        label.text = text
        label.textColor = textColor!
        label.font = font
        label.textAlignment = textAlignment
        if let superV = superView {
            superV.addSubview(label)
            label.snp.makeConstraints { (make) in
                constraintMakerClosure(make)
            }
        }
        return label
    }
}
