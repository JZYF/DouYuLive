//
//  SJTabBarController.swift
//  MyDouYuLive
//
//  Created by song jian on 2020/5/1.
//  Copyright © 2020 song jian. All rights reserved.
//

import UIKit

class SJTabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // 设置图片和文字选中时的颜色   必须设置（系统默认选中蓝色）
        self.tabBar.tintColor = UIColor.orange
        setAllVc()

        // Do any additional setup after loading the view.
    }
    
    func setAllVc() -> Void {
        setUpChildVc(controller: SJHomeVC(), title: "首页", normalImgName: "btn_home_normal", selectedImgName: "btn_home_selected")
        setUpChildVc(controller: SJLiveVC(), title: "直播", normalImgName: "btn_live_normal", selectedImgName: "btn_live_selected")
        setUpChildVc(controller: SJFollowVC(), title: "关注", normalImgName: "btn_home_normal", selectedImgName: "btn_home_selected")
        setUpChildVc(controller: SJMineVC(), title: "我的", normalImgName: "btn_user_normal", selectedImgName: "btn_user_selected")
    }
    
    func setUpChildVc(controller: UIViewController,
                      title: String,
                      normalImgName: String,
                      selectedImgName: String)  {
        controller.tabBarItem.title = title
        controller.tabBarItem.image = UIImage(named: normalImgName)
        controller.tabBarItem.selectedImage = UIImage(named: selectedImgName)
        let navigationController = SJNavigationController(rootViewController: controller)
        self.addChild(navigationController)
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
