
//
//  ClassifySearchModel.swift
//  FifthYan
//
//  Created by LY on 2017/8/18.
//  Copyright © 2017年 SongXueqian. All rights reserved.
//

import UIKit

class ClassifySearchModel: NSObject {

    var realname : String?
    var introduction : String?
    var avatar : String?
    
    init(dic : [String : AnyObject]) {
        super.init()
        realname = dic["realname"] as? String
        introduction = dic["introduction"] as? String
        avatar = dic["avatar"] as? String

    }

}
