//
//  GuideViewController.swift
//  FifthYan
//
//  Created by LY on 2017/8/22.
//  Copyright © 2017年 SongXueqian. All rights reserved.
//

import UIKit

class GuideViewController: BaseViewController, UIScrollViewDelegate {

    //页面数量
    var numOfPages = 2
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let frame = self.view.bounds
        //scrollView的初始化
        let scrollView = UIScrollView()
        scrollView.frame = self.view.bounds
        scrollView.delegate = self
        //为了能让内容横向滚动，设置横向内容宽度为3个页面的宽度总和
        scrollView.contentSize = CGSize(width:frame.size.width * CGFloat(numOfPages + 1),
                                        height:frame.size.height)
        print("\(frame.size.width*CGFloat(numOfPages)),\(frame.size.height)")
        scrollView.isPagingEnabled = true
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.showsVerticalScrollIndicator = false
        scrollView.scrollsToTop = false
        for i in 0...numOfPages{
            let imgfile = "\(Int(i+1)).png"
            print(imgfile)
            let image = UIImage(named:"\(imgfile)")
            let imgView = UIImageView(image: image)
            imgView.frame = CGRect(x:frame.size.width*CGFloat(i), y:CGFloat(0),
                                   width:frame.size.width, height:frame.size.height)
            scrollView.addSubview(imgView)
        }
        scrollView.contentOffset = CGPoint.zero
        self.view.addSubview(scrollView)
        
    }

    //scrollview滚动的时候就会调用
    func scrollViewDidScroll(_ scrollView: UIScrollView)
    {
        print("scrolled:\(scrollView.contentOffset)")
        let twidth = 2 * self.view.bounds.size.width
        //如果在最后一个页面继续滑动的话就会跳转到主页面
        if(scrollView.contentOffset.x > twidth)
        {
            let viewController = FYTabBarController()
            let window = UIApplication.shared.delegate?.window
            window??.rootViewController = viewController
            
        }
    }
}
