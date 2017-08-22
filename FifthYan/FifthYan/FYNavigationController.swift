//
//  FYNavigationController.swift
//  FifthYan
//
//  Created by LY on 2017/8/3.
//  Copyright © 2017年 SongXueqian. All rights reserved.
//

import UIKit
import SVProgressHUD

class FYNavigationController: UINavigationController {

    var rightButton : UIButton?
    
    internal override class func initialize() {
        super.initialize()
        /// 设置导航栏标题
        let navBar = UINavigationBar.appearance()
        navBar.barTintColor = UIColor.white

        navBar.titleTextAttributes = [NSForegroundColorAttributeName: UIColor.black, NSFontAttributeName: UIFont.systemFont(ofSize: 15)]
        navBar.isTranslucent = false
    }

    
    
    /**
     # 统一所有控制器导航栏左上角的返回按钮
     # 让所有push进来的控制器，它的导航栏左上角的内容都一样
     # 能拦截所有的push操作
     - parameter viewController: 需要压栈的控制器
     - parameter animated:       是否动画
     */
    override func pushViewController(_ viewController: UIViewController, animated: Bool) {
        /// 这时push进来的控制器viewController，不是第一个子控制器（不是根控制器）
        if viewControllers.count > 0 {
            // push 后隐藏 tabbar
            viewController.hidesBottomBarWhenPushed = true
            
            self.rightButton = UIButton(frame:CGRect(x:0, y:0, width:30, height:30))
            self.rightButton?.setBackgroundImage(UIImage(named:"ArrowLeft"), for: UIControlState.normal)
            self.rightButton?.addTarget(self, action: #selector(navigationBackClick), for: UIControlEvents.touchUpInside)
            viewController.navigationItem.leftBarButtonItem = UIBarButtonItem (customView: self.rightButton!)
        }
        super.pushViewController(viewController, animated: true)
    }
    /// 返回按钮
    func navigationBackClick() {
        if SVProgressHUD.isVisible() {
            SVProgressHUD.dismiss()
        }
        if UIApplication.shared.isNetworkActivityIndicatorVisible {
            UIApplication.shared.isNetworkActivityIndicatorVisible = false
        }
        popViewController(animated: true)
    }

    
    
    
    
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
