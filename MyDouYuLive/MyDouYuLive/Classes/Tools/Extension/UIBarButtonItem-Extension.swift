//
//  UIBarButtonItem-Extension.swift
//  MyDouYuLive
//
//  Created by song jian on 2020/5/4.
//  Copyright © 2020 song jian. All rights reserved.
//

import UIKit

extension UIBarButtonItem {
    
    
    /// 类方法扩展，方便创建自定义UIBarButtonItem
    /// - Parameters:
    ///   - imageName: normal状态下的图片名称
    ///   - highlightedImageName: highlighted状态下的图片名称
    ///   - size: item的size大小
    /// - Returns: 自定义的UIBarButtonItem对象
    class func createItem(imageName: String,
                          highlightedImageName: String,
                          size: CGSize) -> UIBarButtonItem {
        let btn = UIButton()
        btn.setImage(UIImage(named: imageName), for: .normal)
        btn.setImage(UIImage(named: highlightedImageName), for: .highlighted)
        btn.frame = CGRect(origin: CGPoint.zero, size: size)
        return UIBarButtonItem(customView: btn)
    }
    
    
    /// 便捷初始化器扩展，方便创建自定义UIBarButtonItem
    /// - Parameters:
    ///   - imageName: normal状态下的图片名称
    ///   - highlightedImageName: highlighted状态下的图片名称
    ///   - size: item的size大小
    convenience init(imageName: String,
                     highlightedImageName: String = "",
                     size: CGSize = CGSize.zero) {
        
        let btn = UIButton()
        btn.setImage(UIImage(named: imageName), for: .normal)
        if highlightedImageName != "" {
            btn.setImage(UIImage(named: highlightedImageName), for: .highlighted)
        }
        
        if size != CGSize.zero {
            btn.frame = CGRect(origin: CGPoint.zero, size: size)
        }
        
        self.init(customView:btn)
    }
    
    
}
