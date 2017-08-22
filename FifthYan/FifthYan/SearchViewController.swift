//
//  SearchViewController.swift
//  FifthYan
//
//  Created by LY on 2017/8/4.
//  Copyright © 2017年 SongXueqian. All rights reserved.
//

import UIKit


class SearchViewController: BaseViewController, UITextFieldDelegate, UIScrollViewDelegate {

    var textField : UITextField?
    var deleteImage : UIImageView?
    var rightButton : UIButton?
    
    var whiteView : UIView?
    var firstButton : UIButton?
    var secondButton : UIButton?
    var thirdButton : UIButton?
    var grayLabel : UILabel?
    var greenLabel : UILabel?
    var backScrollView : UIScrollView?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setNaVC()
        setChiView()
    }

    //MARK:
    //MARK:创建naVC
    func setNaVC(){
        
        self.navigationItem.leftBarButtonItem = nil
        self.navigationItem.hidesBackButton = true
        
        let titleView = UIView(frame:CGRect(x:0, y:0, width:SCREEN_WIDTH - 60, height:30))
        titleView.backgroundColor = GroundColor
        titleView.layer.masksToBounds = true
        titleView.layer.cornerRadius = 2
        self.navigationItem.titleView = titleView
        
        textField = UITextField()
        textField?.frame = CGRect(x:5,y:0,width:SCREEN_WIDTH - 110,height:titleView.frame.size.height)
        textField?.backgroundColor = GroundColor
        textField?.textColor = UIColor.black
        textField?.placeholder = "搜索你想看的内容"
        //字体大小
        textField?.setValue(UIFont.systemFont(ofSize: 13), forKeyPath: "_placeholderLabel.font")
        textField?.font = UIFont.systemFont(ofSize: 13)
        //字体颜色
//        textField?.setValue(UIColor.red, forKeyPath: "_placeholderLabel.textColor")
        textField?.delegate = self
        textField?.becomeFirstResponder()
        textField?.returnKeyType = UIReturnKeyType.search
        textField?.enablesReturnKeyAutomatically = true
        titleView.addSubview(textField!)
        
        deleteImage = UIImageView(frame:CGRect(x:titleView.frame.size.width - 50,y:7.5,width:15,height:15));
        deleteImage?.image = UIImage(named:"delete")
        deleteImage?.isHidden = true
        titleView.addSubview(deleteImage!)
        
        deleteImage?.isUserInteractionEnabled = true
        textField?.isUserInteractionEnabled = true
        
        let tap = UITapGestureRecognizer()
        deleteImage?.addGestureRecognizer(tap)
        tap.addTarget(self, action: #selector(deleteAction))
        
        
        self.rightButton = UIButton(frame:CGRect(x:0, y:0, width:60, height:30))
        self.rightButton?.setTitle("取消", for: UIControlState.normal)
        self.rightButton?.setTitleColor(DarkGroundColor, for: UIControlState.normal)
        self.rightButton?.titleLabel?.font = UIFont.systemFont(ofSize: 15)
        self.rightButton?.addTarget(self, action: #selector(backAction), for: UIControlEvents.touchUpInside)
        navigationItem.rightBarButtonItem = UIBarButtonItem (customView: self.rightButton!)

        


    }
    
    //MARK:
    //MARK:创建childViewController
    func setChiView(){
        
        whiteView = UIView()
        whiteView?.frame = CGRect(x:0, y:0, width:SCREEN_WIDTH, height:50)
        whiteView?.backgroundColor = UIColor.white
        self.view.addSubview(whiteView!)
        
        firstButton = UIButton(frame:CGRect(x:0, y:0, width:SCREEN_WIDTH / 3, height:50))
        firstButton?.setTitle("文章", for: UIControlState.normal)
        firstButton?.setTitleColor(MainColor, for: UIControlState.normal)
        firstButton?.titleLabel?.font = UIFont.systemFont(ofSize: 14)
        firstButton?.addTarget(self, action: #selector(firstAction), for: UIControlEvents.touchUpInside)
        whiteView?.addSubview(firstButton!)
        
        secondButton = UIButton(frame:CGRect(x:SCREEN_WIDTH / 3, y:0, width:(firstButton?.frame.size.width)!, height:50))
        secondButton?.setTitle("主题", for: UIControlState.normal)
        secondButton?.setTitleColor(UIColor.black, for: UIControlState.normal)
        secondButton?.titleLabel?.font = UIFont.systemFont(ofSize: 14)
        secondButton?.addTarget(self, action: #selector(secondAction), for: UIControlEvents.touchUpInside)
        whiteView?.addSubview(secondButton!)
        
        thirdButton = UIButton(frame:CGRect(x:SCREEN_WIDTH / 3 * 2, y:0, width:(firstButton?.frame.size.width)!, height:50))
        thirdButton?.setTitle("用户", for: UIControlState.normal)
        thirdButton?.setTitleColor(UIColor.black, for: UIControlState.normal)
        thirdButton?.titleLabel?.font = UIFont.systemFont(ofSize: 14)
        thirdButton?.addTarget(self, action: #selector(thirdAction), for: UIControlEvents.touchUpInside)
        whiteView?.addSubview(thirdButton!)
        
        grayLabel = UILabel()
        grayLabel?.frame = CGRect(x:0, y:(whiteView?.frame.size.height)! - 1, width:SCREEN_WIDTH, height:1)
        grayLabel?.backgroundColor = GroundColor
        whiteView?.addSubview(grayLabel!)
        
        greenLabel = UILabel()
        greenLabel?.frame = CGRect(x:0, y:(whiteView?.frame.size.height)! - 4, width:SCREEN_WIDTH / 3, height:4)
        greenLabel?.backgroundColor = MainColor
        whiteView?.addSubview(greenLabel!)
        whiteView?.isHidden = true

        backScrollView = UIScrollView()
        backScrollView?.frame = CGRect(x:0,y:50,width:SCREEN_WIDTH,height:SCREEN_HIGHT - 64 - 50)
        backScrollView?.backgroundColor = UIColor.clear
        backScrollView?.contentSize = CGSize(width:SCREEN_WIDTH * 3, height:0)
        backScrollView?.bounces = false
        backScrollView?.isPagingEnabled = true
        backScrollView?.delegate = self
        backScrollView?.showsHorizontalScrollIndicator = false
        self.view.addSubview(backScrollView!)
        backScrollView?.isHidden = true
        
        let homeVC = HomeViewController()
        homeVC.searchNum = 1
        homeVC.view.frame = CGRect(x:0,y:0,width:SCREEN_WIDTH,height:(backScrollView?.frame.size.height)!)
        addChildViewController(homeVC)
        backScrollView?.addSubview(homeVC.view)
        homeVC.didMove(toParentViewController: self)

        let detailVC = ClassifyViewController()
        detailVC.searchNum = 1
        detailVC.view.frame = CGRect(x:SCREEN_WIDTH,y:0,width:SCREEN_WIDTH,height:(backScrollView?.frame.size.height)!)
        addChildViewController(detailVC)
        backScrollView?.addSubview(detailVC.view)
        detailVC.didMove(toParentViewController: self)



        let claVC = ClassifySmallViewController()
        claVC.searchNum = 1
        claVC.view.frame = CGRect(x:SCREEN_WIDTH * 2,y:0,width:SCREEN_WIDTH,height:(backScrollView?.frame.size.height)!)
        addChildViewController(claVC)
        backScrollView?.addSubview(claVC.view)
        claVC.didMove(toParentViewController: self)
        
    }
    
    //MARK:
    //MARK:TextField delegate
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        deleteImage?.isHidden = false
        return true
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        whiteView?.isHidden = false
        backScrollView?.isHidden = false

        NotificationCenter.default.post(name: NSNotification.Name(rawValue:"Word1"), object: nil, userInfo: ["word":textField.text ?? [String :Any]()])
        NotificationCenter.default.post(name: NSNotification.Name(rawValue:"Word2"), object: nil, userInfo: ["word":textField.text ?? [String :Any]()])
        NotificationCenter.default.post(name: NSNotification.Name(rawValue:"Word3"), object: nil, userInfo: ["word":textField.text ?? [String :Any]()])
        
        return true
    }
    
    //MARK:
    //ScrollView Delegate
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if (backScrollView?.contentOffset.x)! < SCREEN_WIDTH {
            
            UIView .animate(withDuration: 0.5) {
                self.firstButton?.setTitleColor(MainColor, for: UIControlState.normal)
                self.secondButton?.setTitleColor(UIColor.black, for: UIControlState.normal)
                self.thirdButton?.setTitleColor(UIColor.black, for: UIControlState.normal)
                
                self.greenLabel?.frame = CGRect(x:0, y:(self.whiteView?.frame.size.height)! - 4, width:SCREEN_WIDTH / 3, height:4)
                
            }

        } else if (backScrollView?.contentOffset.x)! < SCREEN_WIDTH * 2 && (backScrollView?.contentOffset.x)! >= SCREEN_WIDTH {
            
            UIView .animate(withDuration: 0.5) {
                self.firstButton?.setTitleColor(UIColor.black, for: UIControlState.normal)
                self.secondButton?.setTitleColor(MainColor, for: UIControlState.normal)
                self.thirdButton?.setTitleColor(UIColor.black, for: UIControlState.normal)
                
                self.greenLabel?.frame = CGRect(x:SCREEN_WIDTH / 3, y:(self.whiteView?.frame.size.height)! - 4, width:SCREEN_WIDTH / 3, height:4)
            }

        } else {
            
            UIView .animate(withDuration: 0.5) {
                self.firstButton?.setTitleColor(UIColor.black, for: UIControlState.normal)
                self.secondButton?.setTitleColor(UIColor.black, for: UIControlState.normal)
                self.thirdButton?.setTitleColor(MainColor, for: UIControlState.normal)
                
                self.greenLabel?.frame = CGRect(x:SCREEN_WIDTH / 3 * 2, y:(self.whiteView?.frame.size.height)! - 4, width:SCREEN_WIDTH / 3, height:4)
            }

        }
    }
    
    //MARK:
    //MARK:点击事件
    func backAction(){
        textField?.resignFirstResponder()
        self.navigationController?.popViewController(animated: true)
    }

    func deleteAction(){
        textField?.text = ""
        deleteImage?.isHidden = true
        textField?.becomeFirstResponder()

    }
    
    func firstAction(){
        
        UIView .animate(withDuration: 0.5) {


            
            self.backScrollView?.contentOffset = CGPoint(x:0, y:0)

        }
        


    }
    
    func secondAction(){
        UIView .animate(withDuration: 0.5) {
            
            self.backScrollView?.contentOffset = CGPoint(x:SCREEN_WIDTH, y:0);
        }

    }

    func thirdAction(){
        UIView .animate(withDuration: 0.5) {
            self.backScrollView?.contentOffset = CGPoint(x:2 * SCREEN_WIDTH, y:0);
        }

    }

    
    
   
}
