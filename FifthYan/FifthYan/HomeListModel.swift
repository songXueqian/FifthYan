//
//  HomeListModel.swift
//  FifthYan
//
//  Created by LY on 2017/8/14.
//  Copyright © 2017年 SongXueqian. All rights reserved.
//

import UIKit

class HomeListModel: NSObject {
    
    var id: String?
    var url: String?
    var title: String?
    var subtitle: String?
    var read_cost: Int?
    var image: String?
    var web2png: String?
    var account: AccountModel?
    var first_topic: First_topicModel?
    
    init(dict: [String: AnyObject]) {
        super.init()
        
        id = dict["id"] as? String
        url = dict["url"] as? String
        title = dict["title"] as? String
        subtitle = dict["subtitle"] as? String
        read_cost = dict["read_cost"] as? Int
        image = dict["image"] as? String
        web2png = dict["web2png"] as? String
        
        if ((dict["account"] as? [String: AnyObject]) != nil) {
            account = AccountModel(dict: dict["account"] as! [String: AnyObject])
        }
        
        if ((dict["first_topic"] as? [String: AnyObject]) != nil) {
             first_topic = First_topicModel(dict: dict["first_topic"] as! [String: AnyObject])
        }
        
       
        
       

        
    }

}


class AccountModel: NSObject {
    var realname : String?
    var avatar : String?
    var introduction : String?

    init(dict : [String: AnyObject]) {
        super.init()
        
        realname = dict["realname"] as? String
        avatar = dict["avatar"] as? String
        introduction = dict["introduction"] as? String
        
    }
}

class First_topicModel: NSObject {
    var name : String?
    var introduction : String?
    var image_thumbnail : String?
    var url : String?

    init(dict : [String: AnyObject]) {
        super.init()
        
        name = dict["name"] as? String
        introduction = dict["introduction"] as? String
        image_thumbnail = dict["image_thumbnail"] as? String
        url = dict["url"] as? String

    }
}
