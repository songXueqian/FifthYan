//
//  ClassifySmallViewController.swift
//  FifthYan
//
//  Created by LY on 2017/8/21.
//  Copyright © 2017年 SongXueqian. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class ClassifySmallViewController: BaseViewController, UITableViewDelegate, UITableViewDataSource {
    
    //MARK:
    //MARK:声明属性
    var tableView : UITableView?
    var dataArray : NSMutableArray = []
    var cell : ClassifySearchTableViewCell?
    var classSearchModel = [ClassifySearchModel]()
    
    var searchNum : NSInteger?
    var searchString : String?
    
    //MARK:
    //MARK:viewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //创建tableView
        setTabVieVC()
        
        NotificationCenter.default.addObserver(self, selector: #selector(searchWord3(notification:)), name: NSNotification.Name(rawValue: "Word3"), object: nil)
    }
    
    func searchWord3(notification:NSNotification) {
        let userInfo = notification.userInfo
        self.searchString = userInfo?["word"] as? String
        setHeadData()
        
        print("通知")
    }
    
    //MARK:
    //MARK:创建tabelView
    private func setTabVieVC() {
        
        self.tableView = UITableView(frame:CGRect(x:0, y:0, width:SCREEN_WIDTH, height:SCREEN_HIGHT - 64 - 49));
        self.tableView?.delegate = self
        self.tableView?.dataSource = self
        self.tableView?.separatorStyle = .singleLine
        self.tableView?.showsVerticalScrollIndicator = false
        self.view?.addSubview(self.tableView!)
        self.tableView?.tableFooterView = UIView.init()
        
        
        
        if (self.tableView != nil) {
            //tableViewCell分割线显示不全解决方案
            if (tableView?.responds(to:#selector(setter: UITableViewCell.separatorInset)))! {
                tableView?.separatorInset = UIEdgeInsets.zero
            }
            if (tableView?.responds(to:#selector(setter: UIView.layoutMargins)))! {
                tableView?.layoutMargins = UIEdgeInsets.zero
            }
            
        }
        
        
    }
    
    //MARK:
    //MARK:获取数据
    func setHeadData(){
        
        let header = MJRefreshNormalHeader(refreshingTarget: self, refreshingAction: #selector(HomeViewController.setData))
        tableView?.mj_header = header
        tableView?.mj_header.beginRefreshing()
        
    }

    
    func setData() {
        weak var weakSelf = self
        
        let url : String?
        var params:[String:Any] = ["retrieve_type":"123", "limit":"20", "offset":"0"]

        
        url = BaseAPI + "account.json?"
        params = ["retrieve_type":"by_search", "limit":"20", "offset":"0", "word":searchString ?? [String:Any]()]
        
        print("url ======\(String(describing: url))")
        print("params ======\(params)")
        
        
        Alamofire
            .request(url!, parameters: params)
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
                    
                    
                    var classItems2 = [ClassifySearchModel]()
                    //  字典转成模型
                    if let items = dict["result"].arrayObject {
                        for item in items {
                            let model = ClassifySearchModel(dic: item as! [String: AnyObject])
                            classItems2.append(model)
                        }
                    }
                    weakSelf?.classSearchModel = classItems2
                    weakSelf?.tableView?.reloadData()
                    weakSelf?.tableView?.mj_header.endRefreshing()
                    
                }
        }
        
        
    }
    
    
    //MARK:
    //MARK:tableView--delegate
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return classSearchModel.count
            
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
       return 50
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        
        let identifier = "HomeSeaCell"
        cell = tableView.dequeueReusableCell(withIdentifier: identifier) as? ClassifySearchTableViewCell
        if nil == cell {
            cell = ClassifySearchTableViewCell(style: UITableViewCellStyle.value1, reuseIdentifier: identifier)
        }
        
        cell?.selectionStyle = .none
        cell?.backgroundColor = UIColor.white
        cell?.typeClass = classSearchModel[indexPath.row]
        return cell!
        
        
    }
    
    //tableViewCell分割线显示不全解决方案
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if cell.responds(to:#selector(setter: UIView.layoutMargins)) {
            cell.layoutMargins = UIEdgeInsets.zero
        }
        if cell.responds(to: #selector(setter: UITableViewCell.separatorInset)) {
            cell.separatorInset = UIEdgeInsets.zero
        }
    }
    
    
    
    
    
    
}
