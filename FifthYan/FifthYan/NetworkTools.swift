//
//  NetworkTools.swift
//  FifthYan
//
//  Created by LY on 2017/8/11.
//  Copyright © 2017年 SongXueqian. All rights reserved.
//

import Foundation

//MARK:
//MARK:网络请求类型枚举
enum FYRequestType : Int {
    case GET
    case POST
}

class NetworkTools: AFHTTPSessionManager {
    static let shared: NetworkTools = {
       let tools = NetworkTools()
        tools.responseSerializer.acceptableContentTypes = [
            "application/json",
            "text/html",
            "text/plain",
            "image/jpeg",
            "image/png",
            "application/octet-stream",
            "text/json",
        ] as Set
        return tools
    }()
    
}





//MARK:
//MARK:封装请求方法
extension NetworkTools {
    // 请求JSON数据
    // 将成功和失败的回调写在一个逃逸闭包中
    
    func request(method: FYRequestType, urlString: String, parameters: [String: AnyObject], progress: @escaping (_ progressResult: Progress?) -> (), success: @escaping (_ successResult: AnyObject?)  -> (), error: @escaping (_ errorResult: NSError?) -> ()) {

        // 进度回调闭包
        let progressCallback = { (progressData: Progress) in
            progress(progressData)
        }
        
        // 成功结果回调闭包
        let successCallback = { (task: URLSessionDataTask, successData: AnyObject?) in
            success(successData)
        }
        
        // 失败错误信息回调闭包
        let failureCallback = { (task: URLSessionDataTask?, errorData: NSError) in
            error(errorData)
        }
        
        if method == .GET {
            get(urlString, parameters: parameters, progress: progressCallback, success: successCallback as? (URLSessionDataTask, Any?) -> Void, failure: failureCallback as? (URLSessionDataTask?, Error) -> Void)
            
        } else {
            post(urlString, parameters: parameters, progress: progressCallback, success: successCallback as? (URLSessionDataTask, Any?) -> Void, failure: failureCallback as? (URLSessionDataTask?, Error) -> Void)
        }
        

        
    }
    
    
    // MARK: 下载文件
    /**
     下载文件
     
     - parameter urlStr:      文件的网络地址
     - parameter savePath:    保存路径(包含文件名)
     - parameter progress:    进度
     - parameter resultBlock: 结果回调
     */
    func download(urlStr: String, savePath: String, progress: ((_ progress: Double) -> ())?, resultBlock: ((URL?, Error?)->())?) {
        let urlRequest = URLRequest(url: URL(string: urlStr)!)
        let task = self.downloadTask(with: urlRequest, progress: {
            if progress != nil {
                progress!(($0.fractionCompleted))
            }
        }, destination: { (url, response) -> URL in
            return URL(fileURLWithPath: savePath)
        }, completionHandler: { (response, url, error) in
            if resultBlock != nil {
                resultBlock!(url, error)
            }
        })
        
        task.resume()
    }

    
}


















