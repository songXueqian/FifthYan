//
//  FYConst.swift
//  FifthYan
//
//  Created by LY on 2017/8/3.
//  Copyright © 2017年 SongXueqian. All rights reserved.
//

import Foundation
import UIKit


//MARK:
//MARK:Network url

// code 码 200 操作成功
let RETURN_OK = true

// 服务器地址
let BaseAPI = "http://www.15yan.com/apis/"


//MARK:
//MARK:let
let SCREEN_WIDTH = UIScreen.main.bounds.size.width

let SCREEN_HIGHT = UIScreen.main.bounds.size.height


//RGBA的颜色设置
func FYColor(r:CGFloat, g:CGFloat, b:CGFloat, a:CGFloat) -> UIColor {
    return UIColor(red: r / 255.0, green: g / 255.0, blue: b / 255.0, alpha: a)
}

//主题色
let MainColor = UIColor (red: 0.11, green: 0.67, blue: 0.08, alpha: 1.00)


//背景色
let GroundColor = UIColor(red: 0.90, green: 0.90, blue: 0.90, alpha: 1.00)

//深背景色
let DarkGroundColor = UIColor(red: 0.7, green: 0.7, blue: 0.7, alpha: 1.00)
