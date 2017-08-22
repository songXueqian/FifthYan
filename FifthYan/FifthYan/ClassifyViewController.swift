//
//  ClassifyViewController.swift
//  FifthYan
//
//  Created by LY on 2017/8/3.
//  Copyright © 2017年 SongXueqian. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class ClassifyViewController: BaseViewController,UITableViewDelegate, UITableViewDataSource {
    
    //MARK:
    //MARK:声明属性
    var tableView : UITableView?
    var chooseTableView : UITableView?
    var dataArray : NSMutableArray = []
    var chooseArray : NSMutableArray = ["推荐主题", "关注最多"]
    
    var titleButton : UIButton?
    var titleImage : UIImageView?
    var rightButton : UIButton?
    
    var typeString : String?
    var arrowPic : Bool = false
    var cell : ClassifyTableViewCell?
    var chooseCell : HomeChooseTableViewCell?
    var num : NSInteger?
    var classModel = [ClassifyModel]()
    
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
        typeString = "by_recommend"
        
        //创建naVC
        setNaVC()
        //创建tableView
        setTabVieVC()
        
        NotificationCenter.default.addObserver(self, selector: #selector(searchWord2(notification:)), name: NSNotification.Name(rawValue: "Word2"), object: nil)
        
        
    }
    
    
    
    func searchWord2(notification:NSNotification) {
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
        self.titleButton?.setTitle("推荐主题", for: UIControlState.normal)
        self.titleButton?.setTitleColor(UIColor.black, for: UIControlState.normal)
        self.titleButton?.titleLabel?.font = UIFont(name:"Zapfino", size:15)
        self.titleButton?.addTarget(self, action: #selector(titleAction), for: UIControlEvents.touchUpInside)
        titleView.addSubview(self.titleButton!)
        
        self.titleImage = UIImageView(frame:CGRect(x:(self.titleButton?.frame.origin.x)! + (self.titleButton?.frame.size.width)! - 20, y:(self.titleButton?.frame.origin.y)! + 3
            , width:20, height:20))
        self.titleImage?.image = UIImage(named:"ArrowDown")
        titleView.addSubview(self.titleImage!)
        self.titleImage?.isUserInteractionEnabled = true
        
        
        let tap = UITapGestureRecognizer()
        self.titleImage?.addGestureRecognizer(tap)
        tap.addTarget(self, action: #selector(titleAction))
        
        
        self.rightButton = UIButton(frame:CGRect(x:0, y:0, width:25, height:25))
        self.rightButton?.setBackgroundImage(UIImage(named:"search"), for: UIControlState.normal)
        self.rightButton?.addTarget(self, action: #selector(rightAction), for: UIControlEvents.touchUpInside)
        navigationItem.rightBarButtonItem = UIBarButtonItem (customView: self.rightButton!)
        
        
        
        
    }
    
    //MARK:
    //MARK:创建tabelView
    private func setTabVieVC() {
        
        self.chooseTableView = UITableView(frame:CGRect(x:0, y:0, width:SCREEN_WIDTH, height:0));
        self.chooseTableView?.delegate = self
        self.chooseTableView?.dataSource = self
        self.chooseTableView?.separatorStyle = .none
        self.chooseTableView?.showsVerticalScrollIndicator = false
        self.view?.addSubview(self.chooseTableView!)
        self.chooseTableView?.tableFooterView = UIView.init()
        
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
        
        var url : String?
        var params:[String:Any] = ["retrieve_type":typeString ?? [String:Any](), "limit":"20", "offset":"0"]
        
        if 1 == searchNum {
            url = BaseAPI + "topic.json?"
            params = ["retrieve_type":"by_search", "limit":"20", "offset":"0", "word":searchString ?? [String:Any]()]
            
            classModel = [ClassifyModel]()
            self.searchString = ""
        } else {
            url = BaseAPI + "topic.json?"
            params = ["retrieve_type":weakSelf?.typeString ?? [String:Any](), "limit":"20", "offset":"0"]
            
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
                    
                        var classItems = [ClassifyModel]()
                        //  字典转成模型
                        if let items = dict["result"].arrayObject {
                            for item in items {
                                let model = ClassifyModel(dict: item as! [String: AnyObject])
                                classItems.append(model)
                            }
                        }
                        weakSelf?.classModel = classItems
                        weakSelf?.tableView?.reloadData()
                        weakSelf?.tableView?.mj_header.endRefreshing()
                }
        }
        
        
    }
    
    //MARK:
    //MARK:tableView--delegate
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if self.chooseTableView == tableView {
            return 2
        } else {

            return classModel.count
 
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if self.chooseTableView == tableView {
            return 40
        } else {
            return 50
            
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if self.chooseTableView == tableView {
            let identifier = "HomeChooseCell"
            chooseCell = tableView.dequeueReusableCell(withIdentifier: identifier) as? HomeChooseTableViewCell
            if nil == chooseCell {
                chooseCell = HomeChooseTableViewCell(style: UITableViewCellStyle.value1, reuseIdentifier: identifier)
            }
            
            chooseCell?.selectionStyle = .none
            chooseCell?.backgroundColor = GroundColor
            chooseCell?.lable?.text = chooseArray .object(at: indexPath.row) as? String
            
            if indexPath.row == num {
                chooseCell?.lable?.textColor = MainColor
                chooseCell?.rightImage?.isHidden = false
            } else {
                chooseCell?.lable?.textColor = UIColor.black
                chooseCell?.rightImage?.isHidden = true
            }
            return chooseCell!
            
        } else {
            
                let identifier = "HomeCell"
                cell = tableView.dequeueReusableCell(withIdentifier: identifier) as? ClassifyTableViewCell
                if nil == cell {
                    cell = ClassifyTableViewCell(style: UITableViewCellStyle.value1, reuseIdentifier: identifier)
                }
                
                cell?.selectionStyle = .none
                cell?.backgroundColor = UIColor.white
                cell?.typeClass = classModel[indexPath.row]
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
                typeString = "by_recommend"
                self.titleButton?.setTitle("推荐主题", for: UIControlState.normal)
                
            } else {
                typeString = "by_top"
                self.titleButton?.setTitle("关注最多", for: UIControlState.normal)
                
            }
            
            
            setHeadData()
            
        } else {

                let clVC = ClassifyDetailViewController()
                clVC.titleString = "标题"
                clVC.classModel = classModel[indexPath.row]
                self.navigationController?.pushViewController(clVC, animated: true)
            
        }
        
        
        
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
                
                self.chooseTableView?.frame = CGRect(x:0, y:0, width:SCREEN_WIDTH, height:80);
                
                self.tableView?.frame = CGRect(x:0, y:(self.chooseTableView?.frame.origin.y)! + (self.chooseTableView?.frame.size.height)!, width:SCREEN_WIDTH, height:SCREEN_HIGHT - 64 - 49 - 80);
                
                
            }
            
            
        }
        
    }
    
    func rightAction(){
        
        let naVC = SearchViewController()
        self.navigationController?.pushViewController(naVC, animated: true)
    }
    
    deinit {
        print("安全!!!~~~")
        NotificationCenter.default.removeObserver(self)
        
    }
    
    
}
