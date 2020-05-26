//
//  SJBaseCollectionViewCell.swift
//  MyDouYuLive
//
//  Created by song jian on 2020/5/25.
//  Copyright © 2020 song jian. All rights reserved.
//

import UIKit

class SJBaseCollectionViewCell: UICollectionViewCell {
        
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        initSubViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    /// 子类必须重写该方法
    public func initSubViews() {
        
    }

}

