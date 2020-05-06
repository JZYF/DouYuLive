//
//  SJBaseVC.swift
//  MyDouYuLive
//
//  Created by song jian on 2020/5/1.
//  Copyright © 2020 song jian. All rights reserved.
//

import UIKit


class SJBaseVC: UIViewController {

    lazy var statusView: UIView = {
        let view = UIView()
        view.backgroundColor = kMainOrangeColor
        view.frame = CGRect(x: 0, y: 0, width: kScreenW, height: kScreenH)
        let gradientLayer: CAGradientLayer = CAGradientLayer()
        gradientLayer.colors = kGradientColors
        gradientLayer.startPoint = CGPoint.init(x: 0, y: 0)
        gradientLayer.endPoint = CGPoint.init(x: 1, y: 0)
        gradientLayer.frame = view.frame
        view.layer.insertSublayer(gradientLayer, at: 0)
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = kWhite
//        automaticallyAdjustsScrollViewInsets = false
    }
    
    deinit {
        print("\(Self.self)销毁")
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
