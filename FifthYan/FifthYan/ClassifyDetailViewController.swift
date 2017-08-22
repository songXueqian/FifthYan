//
//  ClassifyDetailViewController.swift
//  FifthYan
//
//  Created by LY on 2017/8/7.
//  Copyright © 2017年 SongXueqian. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class ClassifyDetailViewController: BaseViewController, UITableViewDelegate, UITableViewDataSource  {

    //MARK:
    //MARK:声明属性
    var titleString : NSString?
    var tableView : UITableView?
    var dataArray : NSMutableArray = []
    var cell : ClassDetailTableViewCell?
    
    var photoImage : UIImageView?
    var titleLabel : UILabel?
    var detailLabel : UILabel?
    var grayLabel : UILabel?
    var numLabel : UILabel?
    var idString : String?

    var classModel : ClassifyModel?
    var listModel = [HomeListModel]()
    var searchNum : NSInteger?
    var searchString : String?

    
    //MARK:
    //MARK:重写viewWillAppear
    override func viewWillAppear(_ animated: Bool) {

        
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        //创建tableView
        setTabVieVC()
        
        if 1 == searchNum {
            
        } else {
            self.navigationItem.title = classModel!.name
            //获取数据
            setHeadData()
            searchNum = 2
        }
        


    }

        
    //MARK:
    //MARK:创建tabelView
    private func setTabVieVC() {
        self.tableView = UITableView(frame:CGRect(x:0, y:0, width:SCREEN_WIDTH, height:SCREEN_HIGHT - 64
        ));
        self.tableView?.delegate = self
        self.tableView?.dataSource = self
        self.tableView?.separatorStyle = .none
        self.tableView?.showsVerticalScrollIndicator = false
        self.view?.addSubview(self.tableView!)
        self.tableView?.backgroundColor = GroundColor
        self.tableView?.tableFooterView = UIView.init()
        
        let headView = UIView(frame:CGRect(x:0,y:0,width:SCREEN_WIDTH, height:200))
        headView.backgroundColor = GroundColor
        self.tableView?.tableHeaderView = headView
        
        let whiteView = UIView(frame:CGRect(x:0,y:0,width:SCREEN_WIDTH, height:200))
        whiteView.backgroundColor = UIColor.white
        headView.addSubview(whiteView)
        
        photoImage = UIImageView(frame:CGRect(x:SCREEN_WIDTH / 2 - 80,y:10,width:160,height:160));
        if searchNum == 1 {
            
        } else {
            let url = classModel!.image_thumbnail
            photoImage?.kf.setImage(with: URL(string:url!), placeholder: #imageLiteral(resourceName: "backImage"), options: nil, progressBlock: nil, completionHandler: { (image, error, cacheType, imageURL) in
                
            })
        }
        photoImage?.layer.masksToBounds = true
        photoImage?.layer.cornerRadius = 10
        whiteView.addSubview(photoImage!)
        
        titleLabel = UILabel(frame:CGRect(x:0, y:(photoImage?.frame.origin.y)! + (photoImage?.frame.size.height)!, width:SCREEN_WIDTH, height:30))
        if searchNum == 1 {
            
        } else {
            titleLabel?.text = classModel!.name

        }

        
        titleLabel?.font = UIFont.systemFont(ofSize: 14)
        titleLabel?.textAlignment = NSTextAlignment.center
        whiteView.addSubview(titleLabel!)
        
        detailLabel = UILabel(frame:CGRect(x:40, y:(titleLabel?.frame.origin.y)! + (titleLabel?.frame.size.height)!, width:SCREEN_WIDTH - 80, height:30))
        
        if searchNum == 1 {
            
        } else {
            detailLabel?.text = String(format:"%@", classModel!.introduction!)
            
        }

        detailLabel?.font = UIFont.systemFont(ofSize: 11)
        detailLabel?.textColor = UIColor.lightGray
        detailLabel?.numberOfLines = 0
        detailLabel?.sizeToFit()
        whiteView.addSubview(detailLabel!)
        
        if (detailLabel?.frame.size.height)! <= 30 {
            detailLabel?.frame = CGRect(x:40, y:(titleLabel?.frame.origin.y)! + (titleLabel?.frame.size.height)!, width:SCREEN_WIDTH - 80, height:30)
            detailLabel?.textAlignment = NSTextAlignment.center
        } else {
            detailLabel?.numberOfLines = 0
            detailLabel?.sizeToFit()
            detailLabel?.textAlignment = NSTextAlignment.center

        }
        
        numLabel = UILabel(frame:CGRect(x:0, y:(detailLabel?.frame.origin.y)! + (detailLabel?.frame.size.height)!, width:SCREEN_WIDTH, height:30))
        
        if searchNum == 1 {
            
        } else {
            let string = String(format:"%d", classModel!.followers_count!)
            numLabel?.text = String(format:"%@人订阅", string)
            
        }
        numLabel?.font = UIFont.systemFont(ofSize: 11)
        numLabel?.textColor = UIColor.lightGray
        numLabel?.textAlignment = NSTextAlignment.center
        whiteView.addSubview(numLabel!)
        
        whiteView.frame = CGRect(x:0,y:0,width:SCREEN_WIDTH, height:(numLabel?.frame.origin.y)! + (numLabel?.frame.size.height)! + 10)
        headView.frame = CGRect(x:0,y:0,width:SCREEN_WIDTH, height:whiteView.frame.origin.y + whiteView.frame.size.height + 10)
        
        
        
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
        
        var url = BaseAPI + "story.json?"
        weakSelf?.idString = classModel?.id
        var params:[String:Any] = ["retrieve_type":"by_topic", "topic_id": weakSelf?.idString ?? [String:Any](), "limit":"20", "offset":"0"]
        
        if (self.searchString?.isEmpty) == false  {
            print(classModel)
            
            url = BaseAPI + "topic.json?"
            params = ["retrieve_type":"by_search", "limit":"20", "offset":"0", "word":searchString ?? [String:Any]()]
            
            listModel = [HomeListModel]()
            print(listModel)
            self.searchString = ""
        } else {
            url = BaseAPI + "story.json?"
            var params:[String:Any] = ["retrieve_type":"by_topic", "topic_id": weakSelf?.idString ?? [String:Any](), "limit":"20", "offset":"0"]
            
        }

        
        
        //topic
        print("url ======\(url)")
        print("params ======\(params)")
        
        
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
                    
                    var homeListItems = [HomeListModel]()
                    //  字典转成模型
                    if let items = dict["result"].arrayObject {
                        for item in items {
                            let homeItem = HomeListModel(dict: item as! [String: AnyObject])
                            homeListItems.append(homeItem)
                        }
                    }
                    weakSelf?.listModel = homeListItems
                    weakSelf?.tableView?.reloadData()
                    weakSelf?.tableView?.mj_header.endRefreshing()
                }
        }

    }
    
    //MARK:
    //MARK:tableView--delegate
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return listModel.count

        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return 320

    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let identifier = "HomeCell"
        cell = tableView.dequeueReusableCell(withIdentifier: identifier) as? ClassDetailTableViewCell
        if nil == cell {
            cell = ClassDetailTableViewCell(style: UITableViewCellStyle.value1, reuseIdentifier: identifier)
        }
        
        cell?.selectionStyle = .none
        cell?.backgroundColor = GroundColor
        cell?.product = listModel[indexPath.row]
        
        return cell!

    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let webVC = WebViewController()
        webVC.listModel = listModel[indexPath.row]
        self.navigationController?.pushViewController(webVC, animated: true)
    }
    
    

}
