//
//  HomeTableViewCell.swift
//  FifthYan
//
//  Created by LY on 2017/8/3.
//  Copyright © 2017年 SongXueqian. All rights reserved.
//

import UIKit
import Kingfisher

class HomeTableViewCell: UITableViewCell {
    
    var whiteView : UIView?
    var photoImage : UIImageView?
    var typeLabel : UILabel?
    var grayLabel : UILabel?
    var bigImage : UIImageView?
    var titleLabel : UILabel?
    var detailLabel : UILabel?
    var timeLabel : UILabel?
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super .init(style: style, reuseIdentifier: reuseIdentifier)
        
        
        whiteView = UIView()
        whiteView?.frame = CGRect(x:0, y:0, width:SCREEN_WIDTH, height:180)
        whiteView?.backgroundColor = UIColor.white
        self.addSubview(whiteView!)
        
        photoImage = UIImageView()
        photoImage?.frame = CGRect(x:10, y:15, width:20, height:20)
        photoImage?.layer.masksToBounds = true
        photoImage?.layer.cornerRadius = 10
        whiteView?.addSubview(photoImage!)
        
        typeLabel = UILabel()
        typeLabel?.frame = CGRect(x:(photoImage?.frame.origin.x)! + (photoImage?.frame.size.width)! + 10, y:(photoImage?.frame.origin.y)! + 4, width:180, height:12.5)
        typeLabel?.textColor = UIColor.black
        typeLabel?.font = UIFont.systemFont(ofSize: 13)
        whiteView?.addSubview(typeLabel!)
        
        grayLabel = UILabel()
        grayLabel?.frame = CGRect(x:(photoImage?.frame.origin.x)!, y:(photoImage?.frame.origin.y)! + (photoImage?.frame.size.height)! + 7.5, width:SCREEN_WIDTH - 20, height:0.5)
        grayLabel?.backgroundColor = UIColor.lightGray
        whiteView?.addSubview(grayLabel!)
        
        bigImage = UIImageView()
        bigImage?.frame = CGRect(x:(grayLabel?.frame.origin.x)!, y:(grayLabel?.frame.origin.y)! + (grayLabel?.frame.size.height)! + 15, width:(grayLabel?.frame.size.width)!, height:180)
        whiteView?.addSubview(bigImage!)
        
        titleLabel = UILabel()
        titleLabel?.frame = CGRect(x:(bigImage?.frame.origin.x)!, y:(bigImage?.frame.origin.y)! + (bigImage?.frame.size.height)! + 5, width:(grayLabel?.frame.size.width)!, height:30)
        titleLabel?.textColor = UIColor.black
        titleLabel?.font = UIFont.systemFont(ofSize: 16)
//        titleLabel?.backgroundColor = UIColor.red
        whiteView?.addSubview(titleLabel!)
        
        detailLabel = UILabel()
        detailLabel?.frame = CGRect(x:(titleLabel?.frame.origin.x)!, y:(titleLabel?.frame.origin.y)! + (titleLabel?.frame.size.height)!, width:(grayLabel?.frame.size.width)!, height:30)
        detailLabel?.textColor = UIColor.lightGray
        detailLabel?.font = UIFont.systemFont(ofSize: 12)
//        detailLabel?.backgroundColor = UIColor.yellow
        whiteView?.addSubview(detailLabel!)
        
        timeLabel = UILabel()
        timeLabel?.frame = CGRect(x:SCREEN_WIDTH - 110, y:(detailLabel?.frame.origin.y)! + (detailLabel?.frame.size.height)! + 3, width:100, height:30)
        timeLabel?.textColor = UIColor.lightGray
        timeLabel?.font = UIFont.systemFont(ofSize: 12)
        timeLabel?.textAlignment = NSTextAlignment(rawValue: 2)!
        whiteView?.addSubview(timeLabel!)
        
        whiteView?.frame = CGRect(x:0, y:0, width:SCREEN_WIDTH, height:(timeLabel?.frame.origin.y)! + (timeLabel?.frame.size.height)! + 10)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    var product:HomeListModel? {
        didSet {
            
            let dic = product!.first_topic
            typeLabel?.text = dic?.name
            print(product!.first_topic)
            print(dic?.name)

            let url2 = dic?.image_thumbnail
            if (dic?.image_thumbnail) != nil {
                photoImage?.kf.setImage(with: URL(string:url2!)!, placeholder: #imageLiteral(resourceName: "backImage"), options: nil, progressBlock: nil, completionHandler: { (image, error, CacheType, imageURL) in
                    
                })
                
            }
            

            let url = product!.image
            if (product!.image) != nil {
                bigImage?.kf.setImage(with: URL(string:url!), placeholder: #imageLiteral(resourceName: "backImage")        , options: nil, progressBlock: nil, completionHandler: { (image, error, cacheType, imageURL) in
                    
                })
            }
            
            titleLabel?.text = product!.title
            detailLabel?.text = product!.subtitle
            
            if (product!.read_cost) != nil {
                 let string = String(format:"%d", (product?.read_cost)!)
                timeLabel?.text = String(format:"%@分钟", string)

            }
            
//            print(product!.title)
        }
        
    }
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        
        
        
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}
