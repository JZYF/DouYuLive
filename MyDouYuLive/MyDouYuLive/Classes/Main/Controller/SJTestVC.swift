//
//  SJTestVCViewController.swift
//  MyDouYuLive
//
//  Created by song jian on 2020/5/6.
//  Copyright © 2020 song jian. All rights reserved.
//

import UIKit

class SJTestVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.pushViewController(SJHomeVC(), animated: true)
        // Do any additional setup after loading the view.
    }

}
