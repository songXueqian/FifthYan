//
//  HomeViewController.swift
//  FifthYan
//
//  Created by LY on 2017/8/3.
//  Copyright © 2017年 SongXueqian. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class HomeViewController: BaseViewController, UITableViewDelegate, UITableViewDataSource {
    
    //MARK:
    //MARK:声明属性
    var tableView : UITableView?
    var chooseTableView : UITableView?
    var dataArray : NSMutableArray = []
    var chooseArray : NSMutableArray = ["全部更新", "热门文章", "编辑推荐"]
    var proArray : NSMutableArray = []
    
    var titleButton : UIButton?
    var titleImage : UIImageView?
    var arrowPic : Bool = false
    var cell : HomeTableViewCell?
    var chooCell : HomeChooseTableViewCell?
    var num : NSInteger?
    var typeString : String?
    
    var listModel = [HomeListModel]()
    
    var searchNum : NSInteger?
    var searchString : String?

    //MARK:
    //MARK:重写viewWillAppear

    override func viewWillAppear(_ animated: Bool) {
        if 1 == searchNum {
            
        } else {
            //获取数据
            setHeadData()
            searchNum = 2
        }

    }
    
    //MARK:
    //MARK:viewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
    
        num = 0
        typeString = "reading_list"
        searchString = ""
        
        dataArray = NSMutableArray()
        proArray = NSMutableArray()
        
        //创建naVC
        setNaVC()
        //创建tableView
        setTabVieVC()
        
        
        
        NotificationCenter.default.addObserver(self, selector: #selector(searchWord1(notification:)), name: NSNotification.Name(rawValue: "Word1"), object: nil)
        
    }
    
    func searchWord1(notification:NSNotification) {
    
        let userInfo = notification.userInfo
        self.searchString = userInfo?["word"] as? String
        setHeadData()
        print("通知")

    }
    
    
    //MARK:
    //MARK:创建naVC
    private func setNaVC() {
        
        
        
        let titleView = UIView(frame:CGRect(x:0, y:0, width:100, height:30))
        self.navigationItem.titleView = titleView
        
        
        self.titleButton = UIButton(frame:CGRect(x:-5, y:0, width:100, height:30))
        self.titleButton?.setTitle("全部更新", for: UIControlState.normal)
        self.titleButton?.setTitleColor(UIColor.black, for: UIControlState.normal)
        self.titleButton?.titleLabel?.font = UIFont(name:"Zapfino", size:15)
        self.titleButton?.addTarget(self, action: #selector(titleAction), for: UIControlEvents.touchUpInside)
        titleView.addSubview(self.titleButton!)
        
        self.titleImage = UIImageView(frame:CGRect(x:(self.titleButton?.frame.origin.x)! + (self.titleButton?.frame.size.width)! - 20, y:(self.titleButton?.frame.origin.y)! + 3
            , width:20, height:20))
        self.titleImage?.image = #imageLiteral(resourceName: "ArrowUp")
        titleView.addSubview(self.titleImage!)
        self.titleImage?.isUserInteractionEnabled = true
        
        
        let tap = UITapGestureRecognizer()
        self.titleImage?.addGestureRecognizer(tap)
        tap.addTarget(self, action: #selector(titleAction))
        
        
        
        
    }
    
    //MARK:
    //MARK:创建tabelView
    private func setTabVieVC() {
        self.tableView = UITableView(frame:CGRect(x:0, y:0, width:SCREEN_WIDTH, height:SCREEN_HIGHT - 64 - 49));
        self.tableView?.delegate = self
        self.tableView?.dataSource = self
        self.tableView?.separatorStyle = .none
        self.tableView?.showsVerticalScrollIndicator = false
        self.view?.addSubview(self.tableView!)
        self.tableView?.tableFooterView = UIView.init()
        
        self.chooseTableView = UITableView(frame:CGRect(x:0, y:0, width:SCREEN_WIDTH, height:0));
        self.chooseTableView?.delegate = self
        self.chooseTableView?.dataSource = self
        self.chooseTableView?.separatorStyle = .none
        self.chooseTableView?.showsVerticalScrollIndicator = false
        self.view?.addSubview(self.chooseTableView!)
        self.tableView?.tableFooterView = UIView.init()
        
        
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
        var params:[String:Any] = ["retrieve_type":typeString ?? [String:Any](), "limit":"20", "offset":"0"]

        if (self.searchString?.isEmpty) == false  {
            print(listModel)

            listModel = [HomeListModel]()

            print(listModel)
            url = BaseAPI + "story.json?"
            params = ["retrieve_type":"by_search", "limit":"20", "offset":"0", "word":searchString ?? [String:Any]()]
            self.searchString = ""
           
        } else {
            url = BaseAPI + "story.json?"
            
            if 0 == num {
                params = ["retrieve_type":typeString ?? [String:Any](), "limit":"20", "offset":"0"]
                
            } else if 1 == num {
                params = ["retrieve_type":typeString ?? [String:Any](), "limit":"20", "offset":"0", "top_month":"2016-05"]
                
            } else {
                params = ["retrieve_type":typeString ?? [String:Any](), "limit":"20", "offset":"0", "topic_id":"9xmXAhXKkxB"]
                
            }

        }
        
        
        
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
                    SVProgressHUD.dismiss()
                    
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
        
        if self.chooseTableView == tableView {
            return chooseArray.count
        } else {
            return listModel.count
            
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if self.chooseTableView == tableView {
            return 40
        } else {

            return 355
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if self.chooseTableView == tableView {
            let identifier = "HomeChooseCell"
            chooCell = tableView.dequeueReusableCell(withIdentifier: identifier) as? HomeChooseTableViewCell
            if nil == chooCell {
                chooCell = HomeChooseTableViewCell(style: UITableViewCellStyle.value1, reuseIdentifier: identifier)
            }
            
            chooCell?.selectionStyle = .none
            chooCell?.backgroundColor = GroundColor
            chooCell?.lable?.text = chooseArray .object(at: indexPath.row) as? String
            
            if indexPath.row == num {
                chooCell?.lable?.textColor = MainColor
                chooCell?.rightImage?.isHidden = false
            } else {
                chooCell?.lable?.textColor = UIColor.black
                chooCell?.rightImage?.isHidden = true
            }
            return chooCell!
            
        } else {
            
            let identifier = "HomeCell"
            cell = tableView.dequeueReusableCell(withIdentifier: identifier) as? HomeTableViewCell
            if nil == cell {
                cell = HomeTableViewCell(style: UITableViewCellStyle.value1, reuseIdentifier: identifier)
            }
            
            cell?.selectionStyle = .none
            cell?.backgroundColor = GroundColor
            cell?.product = listModel[indexPath.row]
            return cell!
        }
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if self.chooseTableView == tableView {
            
            self.arrowPic = false
            
            UIView.animate(withDuration: 0.2) {
                self.titleImage?.transform = (self.titleImage?.transform.rotated(by: CGFloat(Double.pi)))!
                
                self.chooseTableView?.frame = CGRect(x:0, y:0, width:SCREEN_WIDTH, height:0);
                self.tableView?.frame = CGRect(x:0, y:0, width:SCREEN_WIDTH, height:SCREEN_HIGHT - 64 - 49);
                
                
            }
            
            num = indexPath.row
            chooseTableView?.reloadData()
            
            if 0 == num {
                typeString = "reading_list"
                self.titleButton?.setTitle("全部更新", for: UIControlState.normal)
                
            } else if 1 == num {
                typeString = "by_top"
                self.titleButton?.setTitle("热门文章", for: UIControlState.normal)
                
                
            } else {
                typeString = "by_topic"
                self.titleButton?.setTitle("编辑推荐", for: UIControlState.normal)
                
            }
            setHeadData()
        } else {
            
            let webVC = WebViewController()
            webVC.listModel = listModel[indexPath.row]
            self.navigationController?.pushViewController(webVC, animated: true)
        }
        
        
        
    }
    
    //MARK:
    //MARK:点击事件
    func titleAction() {
        
        if arrowPic {
            self.arrowPic = false
            
            UIView.animate(withDuration: 0.2) {
                self.titleImage?.transform = (self.titleImage?.transform.rotated(by: CGFloat(Double.pi)))!
                
                self.chooseTableView?.frame = CGRect(x:0, y:0, width:SCREEN_WIDTH, height:0);
                self.tableView?.frame = CGRect(x:0, y:0, width:SCREEN_WIDTH, height:SCREEN_HIGHT - 64 - 49);
                
                
                
                
            }
            
            
        } else {
            self.arrowPic = true
            
            UIView.animate(withDuration: 0.2) {
                self.titleImage?.transform = (self.titleImage?.transform.rotated(by: CGFloat(Double.pi)))!
                
                self.chooseTableView?.frame = CGRect(x:0, y:0, width:SCREEN_WIDTH, height:120);
                
                self.tableView?.frame = CGRect(x:0, y:(self.chooseTableView?.frame.origin.y)! + (self.chooseTableView?.frame.size.height)!, width:SCREEN_WIDTH, height:SCREEN_HIGHT - 64 - 49 - 120);
                
                
            }
            
            
        }
        
    }
    
    
    deinit {
        print("安全!!!~~~")
        NotificationCenter.default.removeObserver(self)
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
    
}
