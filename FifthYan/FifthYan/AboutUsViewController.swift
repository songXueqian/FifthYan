//
//  AboutUsViewController.swift
//  FifthYan
//
//  Created by LY on 2017/8/4.
//  Copyright © 2017年 SongXueqian. All rights reserved.
//

import UIKit

class AboutUsViewController: BaseViewController {

    var titleLabel : UILabel?
    var detailLabel : UILabel?
    var numLabel : UILabel?

    override func viewDidLoad() {
        super.viewDidLoad()

        let navBar = UINavigationBar.appearance()
        navBar.barTintColor = UIColor.white
        
        navBar.titleTextAttributes = [NSForegroundColorAttributeName: UIColor.black, NSFontAttributeName: UIFont.systemFont(ofSize: 15)]
        navBar.isTranslucent = false
        self.navigationItem.title = "关于我们"
        
        titleLabel = UILabel(frame:CGRect(x:0, y:80, width:SCREEN_WIDTH, height:30))
        titleLabel?.text = "十五言"
        titleLabel?.font = UIFont(name:"Zapfino", size:25)
        titleLabel?.textColor = UIColor.black
        titleLabel?.textAlignment = NSTextAlignment.center
        self.view.addSubview(titleLabel!)

        
        numLabel = UILabel(frame:CGRect(x:0, y:(titleLabel?.frame.origin.y)! + (titleLabel?.frame.size.height)! + 10, width:SCREEN_WIDTH, height:30))
        numLabel?.text = "V 1.0.0"
        numLabel?.font = UIFont(name:"Zapfino", size:11)
        numLabel?.textColor = UIColor.lightGray
        numLabel?.textAlignment = NSTextAlignment.center
        self.view.addSubview(numLabel!)

        
        detailLabel = UILabel(frame:CGRect(x:0, y:(numLabel?.frame.origin.y)! + (numLabel?.frame.size.height)! + 50, width:SCREEN_WIDTH, height:30))
        detailLabel?.text = "每个人都在创造"
        detailLabel?.font = UIFont(name:"Zapfino", size:11)
        detailLabel?.textColor = UIColor.lightGray
        detailLabel?.textAlignment = NSTextAlignment.center
        self.view.addSubview(detailLabel!)

        
    }

   
}
