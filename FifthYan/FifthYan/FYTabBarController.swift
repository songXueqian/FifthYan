//
//  FYTabBarController.swift
//  FifthYan
//
//  Created by LY on 2017/8/3.
//  Copyright © 2017年 SongXueqian. All rights reserved.
//

import UIKit

class FYTabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()

        let tabBar = UITabBar.appearance()
        tabBar.isTranslucent = false

        addChildViewControllers()
    }
    
    //添加子控制器
    private func addChildViewControllers() {
        addChildViewController(childController: HomeViewController(), title:"", imageName: "home")
        addChildViewController(childController: ClassifyViewController(), title:"", imageName: "type")
        addChildViewController(childController: MeViewController(), title:"", imageName: "person")
        
        
    }
    
    //初始化子控制器
    private func addChildViewController(childController: UIViewController, title: String, imageName: String) {
        
        childController.title = title
        
        childController.tabBarItem.image = UIImage(named:imageName)
        childController.tabBarItem.selectedImage = UIImage(named:imageName + "_selected")
        
        childController.tabBarItem.image = childController.tabBarItem.image?.withRenderingMode(UIImageRenderingMode.alwaysOriginal)
        childController.tabBarItem.selectedImage = childController.tabBarItem.selectedImage?.withRenderingMode(UIImageRenderingMode.alwaysOriginal)

        let naVC = FYNavigationController(rootViewController:childController)
        addChildViewController(naVC)
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
