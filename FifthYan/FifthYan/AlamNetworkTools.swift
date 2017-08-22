//
//  AlamNetworkTools.swift
//  FifthYan
//
//  Created by LY on 2017/8/14.
//  Copyright © 2017年 SongXueqian. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class AlamNetworkTools: NSObject {
    
    var typeString : NSString?
    
    //单例
    static let shared = AlamNetworkTools()
    
    func ApiHomeList(finished:@escaping (_ homeListModel : [HomeListModel]) -> ()) {
        
        SVProgressHUD.show(withStatus: "正在加载...")
        let url = BaseAPI + "story.json?"
        let params = ["retrieve_type":"reading_list", "limit":"0", "offset":"20"]
        
        print("url ======\(url)")
        print("params ======\(params)")

        
        Alamofire
            .request(url, parameters: params)
            .responseJSON { (response) in
                guard response.result.isSuccess else {
                    SVProgressHUD.showError(withStatus: "加载失败...")
                    return
                }
                if let value = response.result.value {
                    let dict = JSON(value)
                    print("dic ===== \(dict)")
                    let code = dict["ok"].bool
                    let message = dict["message"].stringValue
                    guard code == RETURN_OK else {
                        SVProgressHUD.showInfo(withStatus: message)
                        return
                    }
                    //  字典转成模型
                    if let items = dict["result"].arrayObject {
                        var homeListItems = [HomeListModel]()
                        for item in items {
                            let homeItem = HomeListModel(dict: item as! [String: AnyObject])
                            homeListItems.append(homeItem)
                        }
                        print("homeListItems ====\(homeListItems)")
                        finished(homeListItems)
                    }
                    SVProgressHUD.showSuccess(withStatus: "加载成功...")

                }
        }
    }

}



    

