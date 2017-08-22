//
//  WebViewController.swift
//  FifthYan
//
//  Created by LY on 2017/8/7.
//  Copyright © 2017年 SongXueqian. All rights reserved.
//

import UIKit
import WebKit
import Alamofire
import SwiftyJSON
import JavaScriptCore

class WebViewController: BaseViewController, WKUIDelegate, WKNavigationDelegate{
    
    //MARK:
    //MARK:声明属性
    var urlString : String?
    var webView : WKWebView?
    var listModel : HomeListModel?
    
    var num : NSInteger?
    var string : String?
    
    //MARK:
    //MARK:viewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if UserDefaults.standard.object(forKey: "FontOpen") != nil {
            
            string = UserDefaults.standard.object(forKey: "FontOpen") as? String
            
            if string == "1" {
                self.num = 1
                //变大
            } else {
                //正常
                self.num = 2
            }
            
        } else {
            //正常
            self.num = 2
            
        }
       
        webViewCre()
        setData()
        
    }

    //MARK:
    //MARK:创建webView
    func webViewCre(){
        
        webView = WKWebView()
        webView?.frame = CGRect(x:0, y:0, width:SCREEN_WIDTH, height:SCREEN_HIGHT - 64)
        webView?.uiDelegate = self
        webView?.navigationDelegate = self
        self.view?.addSubview(webView!)

        
        
    }
    
    //MARK:
    //MARK:获取数据
    func setData(){
        weak var weakSelf = self

        weakSelf?.urlString = listModel?.id
        
        
        let url = BaseAPI + "story.json?"
        let params:[String:Any] = ["story_id":weakSelf!.urlString ?? [String:Any]()]
        
        print("url ======\(url)")
        print("params ======\(params)")
        
        SVProgressHUD.show(withStatus: "正在加载...")
        
        Alamofire
            .request(url, parameters: params)
            .responseJSON { (response) in
                guard response.result.isSuccess else {
                    SVProgressHUD.showError(withStatus: "加载失败")
                    return
                }
                if let value = response.result.value {
                    let dict = JSON(value)
                    print("dic ===== \(dict)")
                    let code = dict["ok"].bool
                    
                    guard code == RETURN_OK else {
                       
                        return
                    }
                    SVProgressHUD.dismiss()
                    
                    if let items = dict["result"].array {
                        //webView读取url
                        let string = items.first?["url"].stringValue
                        let url = NSURL(string: string!)
                        // 根据URL创建请求
                        let request = NSURLRequest(url: url! as URL)
                        weakSelf?.webView?.load(request as URLRequest)
                        //标题
                        weakSelf?.navigationItem.title = items.first?["title"].stringValue
                    }

                    
                    

                }
        }

        
    }
    
    //MARK:
    //MARK:webView delegate
    func webView(_ webView: WKWebView, createWebViewWith configuration: WKWebViewConfiguration, for
        navigationAction: WKNavigationAction, windowFeatures: WKWindowFeatures) -> WKWebView? {

//        if (navigationAction.targetFrame?.isMainFrame)! {
            webView.load(navigationAction.request)

//        }
        return nil;
    }
    
    // 页面加载完成之后调用
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        
        if 1 == self.num {
            let str = "document.getElementsByTagName('body')[0].style.webkitTextSizeAdjust= '120%'"
            webView.evaluateJavaScript(str) { (response, error) in
                
            }

        } else {
            let str = "document.getElementsByTagName('body')[0].style.webkitTextSizeAdjust= '100%'"
            webView.evaluateJavaScript(str) { (response, error) in
                
            }

        }
        
        
     

    }
    
    
    
    
    
    
    deinit {
        print("安全!!!~~~")
        NotificationCenter.default.removeObserver(self)
        
    }
    
}
