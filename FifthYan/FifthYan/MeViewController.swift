//
//  MeViewController.swift
//  FifthYan
//
//  Created by LY on 2017/8/3.
//  Copyright © 2017年 SongXueqian. All rights reserved.
//

import UIKit

class MeViewController: BaseViewController,  UITableViewDelegate, UITableViewDataSource {
    
    //MARK:
    //MARK:声明属性
    var tableView : UITableView?
    var dataArray : NSMutableArray = []
    
    var photoImage : UIImageView?
    var loginLabel : UILabel?
    var cell : MeSegmentTableViewCell?
    var alertController : UIAlertController?
    
    //MARK:
    //MARK:viewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //创建naVC
        setNaVC()
        //创建tableView
        setTabVieVC()
        //获取数据
        setData()
    }
    
    //MARK:
    //MARK:创建naVC
    private func setNaVC() {
        navigationItem.title = "设置"
        
        alertController = UIAlertController(title: "您当前是最新版", message:"1.0.0", preferredStyle:.alert)
        //            let cancelAction = UIAlertAction(title: "取消", style: .cancel, handler: nil)
        let okAction = UIAlertAction(title: "确定", style: .default, handler:{
            (UIAlertAction) -> Void in
            print("点击确定事件")
        })
        //            alertController.addAction(cancelAction)
        alertController?.addAction(okAction)// 当添加的UIAlertAction超过两个的时候，会自动变成纵向分布
        
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
        self.tableView?.backgroundColor = GroundColor
        self.tableView?.tableFooterView = UIView.init()
        
        let headView = UIView(frame:CGRect(x:0,y:0,width:SCREEN_WIDTH, height:200))
        headView.backgroundColor = UIColor.white
        self.tableView?.tableHeaderView = headView
        
        photoImage = UIImageView(frame:CGRect(x:SCREEN_WIDTH / 2 - 50,y:30,width:100,height:100));
        photoImage?.image = UIImage(named:"person")
        headView.addSubview(photoImage!)
        
        loginLabel = UILabel(frame:CGRect(x:(photoImage?.frame.origin.x)!, y:(photoImage?.frame.origin.y)! + (photoImage?.frame.size.height)! + 15, width:(photoImage?.frame.size.width)!, height:30))
        loginLabel?.text = "请登录"
        loginLabel?.textAlignment = NSTextAlignment.center
        headView.addSubview(loginLabel!)
        
        //tableViewCell分割线显示不全解决方案
        if (tableView?.responds(to:#selector(setter: UITableViewCell.separatorInset)))! {
            tableView?.separatorInset = UIEdgeInsets.zero
        }
        if (tableView?.responds(to:#selector(setter: UIView.layoutMargins)))! {
            tableView?.layoutMargins = UIEdgeInsets.zero
        }
    }
    
    //MARK:
    //MARK:获取数据
    private func setData() {
        
    }
    
    //MARK:
    //MARK:tableView--delegate
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return 6
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        switch indexPath.row {
        case 0:
            return 10
        case 1:
            return 45
        case 2:
            return 45
        case 3:
            return 10
        case 4:
            return 45
        case 5:
            return 45
        default:
            return 0
        }
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        switch indexPath.row {
        case 0:
            let identifier = "TableViewCell"
            var cell = tableView.dequeueReusableCell(withIdentifier: identifier)
            if nil == cell {
                cell = UITableViewCell(style: UITableViewCellStyle.default, reuseIdentifier: identifier)
            }
            
            cell?.selectionStyle = .none
            cell?.backgroundColor = GroundColor
            return cell!
        case 1:
            let identifier = "MeCell"
            cell = tableView.dequeueReusableCell(withIdentifier: identifier) as? MeSegmentTableViewCell
            
            if nil == cell {
                cell = MeSegmentTableViewCell(style: UITableViewCellStyle.default, reuseIdentifier: identifier)
            }
            
            cell?.selectionStyle = .none
            cell?.backgroundColor = UIColor.white
            cell?.textLabel?.text = "无图模式"
            cell?.textLabel?.font = UIFont.systemFont(ofSize: 14)
            
            cell?.backType = ({(type:ObjCBool) -> Void in
                
                
                if type.boolValue == true {
                    print("开1")
                    
                    
                } else {
                    print("关1")
                    
                }
            })
            
            
            return cell!
        case 2:
            let identifier = "MeCell"
            cell = tableView.dequeueReusableCell(withIdentifier: identifier) as? MeSegmentTableViewCell
            if nil == cell {
                cell = MeSegmentTableViewCell(style: UITableViewCellStyle.default, reuseIdentifier: identifier)
            }
            
            cell?.selectionStyle = .none
            cell?.backgroundColor = UIColor.white
            cell?.textLabel?.text = "大字体"
            cell?.textLabel?.font = UIFont.systemFont(ofSize: 14)
            
            if (UserDefaults.standard.object(forKey: "FontOpen")) != nil {
                
                let string : String = UserDefaults.standard.object(forKey: "FontOpen") as! String
                if string == "1" {
                    cell?.switchView?.isOn = true

                } else {
                    cell?.switchView?.isOn = false

                }
                
            } else {
                cell?.switchView?.isOn = false
                
            }
            
            
            cell?.backType = ({(type:ObjCBool) -> Void in
                
                
                
                if type.boolValue == true {
                    print("开2")
                    UserDefaults.standard.set("1", forKey: "FontOpen")
                } else {
                    print("关2")
                    UserDefaults.standard.set("2", forKey: "FontOpen")
                }
                
                
            })
            
            return cell!
        case 3:
            let identifier = "TableViewCell"
            var cell = tableView.dequeueReusableCell(withIdentifier: identifier)
            if nil == cell {
                cell = UITableViewCell(style: UITableViewCellStyle.default, reuseIdentifier: identifier)
            }
            
            cell?.selectionStyle = .none
            cell?.backgroundColor = GroundColor
            return cell!
            
        case 4:
            let identifier = "TableViewCell"
            var cell = tableView.dequeueReusableCell(withIdentifier: identifier)
            if nil == cell {
                cell = UITableViewCell(style: UITableViewCellStyle.default, reuseIdentifier: identifier)
            }
            
            cell?.selectionStyle = .none
            cell?.backgroundColor = UIColor.white
            cell?.textLabel?.text = "关于"
            cell?.textLabel?.font = UIFont.systemFont(ofSize: 14)
            
            cell?.accessoryType = UITableViewCellAccessoryType.disclosureIndicator
            
            return cell!
        case 5:
            let identifier = "TableViewCell"
            var cell = tableView.dequeueReusableCell(withIdentifier: identifier)
            if nil == cell {
                cell = UITableViewCell(style: UITableViewCellStyle.default, reuseIdentifier: identifier)
            }
            
            cell?.selectionStyle = .none
            cell?.backgroundColor = UIColor.white
            cell?.textLabel?.text = "检查更新"
            cell?.textLabel?.font = UIFont.systemFont(ofSize: 14)
            
            cell?.accessoryType = UITableViewCellAccessoryType.disclosureIndicator
            
            return cell!
        default:
            let identifier = "TableViewCell"
            var cell = tableView.dequeueReusableCell(withIdentifier: identifier)
            if nil == cell {
                cell = UITableViewCell(style: UITableViewCellStyle.default, reuseIdentifier: identifier)
            }
            
            cell?.selectionStyle = .none
            cell?.backgroundColor = GroundColor
            return cell!
            
        }
        
        
        
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch indexPath.row {
        case 0:
            print("123")
            
        case 1:
            print("123")
            
        case 2:
            print("123")
            
        case 3:
            print("123")
            
        case 4:
            
            let naVC = AboutUsViewController()
            self.navigationController?.pushViewController(naVC, animated: true)
            
        case 5:
            
            self.present(alertController!, animated: true, completion: nil)
            
        default:
            print("123")
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
    
}
