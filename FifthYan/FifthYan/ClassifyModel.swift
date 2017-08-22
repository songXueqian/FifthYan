//
//  ClassifyModel.swift
//  FifthYan
//
//  Created by LY on 2017/8/16.
//  Copyright © 2017年 SongXueqian. All rights reserved.
//

import UIKit

class ClassifyModel: NSObject {
    
    var id : String?
    var name : String?
    var followers_count : Int?
    var introduction : String?
    var image_thumbnail : String?
    var owner_account : Owner_accountModel?

    
    
    init(dict: [String: AnyObject]) {
        super.init()
        id = dict["id"] as? String
        name = dict["name"] as? String
        followers_count = dict["followers_count"] as? Int
        introduction = dict["introduction"] as? String
        image_thumbnail = dict["image_thumbnail"] as? String
        
        
        if ((dict["owner_account"] as? [String: AnyObject]) != nil) {
            owner_account = Owner_accountModel(dict: dict["owner_account"] as! [String: AnyObject])
        }
        
       

    }
}

class Owner_accountModel: NSObject{
    var realname : String?
    
    
    
    init(dict: [String: AnyObject]) {
        super.init()
        realname = dict["realname"] as? String
   
        
    }

}
