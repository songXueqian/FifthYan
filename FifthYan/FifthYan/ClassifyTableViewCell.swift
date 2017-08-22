//
//  ClassifyTableViewCell.swift
//  FifthYan
//
//  Created by LY on 2017/8/7.
//  Copyright © 2017年 SongXueqian. All rights reserved.
//

import UIKit
import Kingfisher

class ClassifyTableViewCell: UITableViewCell {
    
    var photoImage : UIImageView?
    var titleLabel : UILabel?
    var detailLabel : UILabel?
    var numLabel : UILabel?
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        photoImage = UIImageView()
        photoImage?.frame = CGRect(x:15, y:5, width:40, height:40)
        self.addSubview(photoImage!)
        
        titleLabel = UILabel()
        titleLabel?.frame = CGRect(x:(photoImage?.frame.origin.x)! + (photoImage?.frame.size.width)! + 7.5, y:10, width:180, height:12.5)
        titleLabel?.textColor = UIColor.black
        titleLabel?.font = UIFont.systemFont(ofSize: 14)
        self.addSubview(titleLabel!)
        
        detailLabel = UILabel()
        detailLabel?.frame = CGRect(x:(titleLabel?.frame.origin.x)!, y:(titleLabel?.frame.origin.y)! + (titleLabel?.frame.size.height)! + 7, width:80, height:12.5)
        detailLabel?.textColor = UIColor.lightGray
        detailLabel?.font = UIFont.systemFont(ofSize: 11)
        self.addSubview(detailLabel!)
        
        numLabel = UILabel()
        numLabel?.frame = CGRect(x:(detailLabel?.frame.origin.x)! + (detailLabel?.frame.size.width)!, y:(detailLabel?.frame.origin.y)!, width:180, height:12.5)
        numLabel?.textColor = UIColor.lightGray
        numLabel?.font = UIFont.systemFont(ofSize: 11)
        self.addSubview(numLabel!)
        
        
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    var typeClass:ClassifyModel? {
        didSet {
            
            let url = typeClass!.image_thumbnail
            if (typeClass!.image_thumbnail) != nil {
                photoImage?.kf.setImage(with: URL(string:url!), placeholder: #imageLiteral(resourceName: "backImage"), options: nil, progressBlock: nil, completionHandler: { (image, error, cacheType, imageURL) in
                    
                })
            }
            print(typeClass!.image_thumbnail)
            
            titleLabel?.text = typeClass!.name
            print(typeClass!.name)

            if (typeClass!.followers_count) != nil {
                
                let numString = String(format:"%d", typeClass!.followers_count!)
                numLabel?.text = String(format:"%@人订阅", numString)
            }
            print(typeClass!.followers_count)

            let dic = typeClass!.owner_account
            detailLabel?.text = dic?.realname
            print(typeClass!.owner_account)

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
