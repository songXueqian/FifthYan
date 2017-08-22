//
//  ClassifySearchTableViewCell.swift
//  FifthYan
//
//  Created by LY on 2017/8/18.
//  Copyright © 2017年 SongXueqian. All rights reserved.
//

import UIKit

class ClassifySearchTableViewCell: UITableViewCell {

    var photoImage : UIImageView?
    var titleLabel : UILabel?
    var detailLabel : UILabel?

    
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
        if SCREEN_WIDTH == 320 {
            detailLabel?.frame = CGRect(x:(titleLabel?.frame.origin.x)!, y:(titleLabel?.frame.origin.y)! + (titleLabel?.frame.size.height)! + 7, width:240, height:12.5)
        } else {
            detailLabel?.frame = CGRect(x:(titleLabel?.frame.origin.x)!, y:(titleLabel?.frame.origin.y)! + (titleLabel?.frame.size.height)! + 7, width:280, height:12.5)
        }
        
        detailLabel?.textColor = UIColor.lightGray
        detailLabel?.font = UIFont.systemFont(ofSize: 11)
        self.addSubview(detailLabel!)

        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    var typeClass:ClassifySearchModel? {
        didSet {
            
            let url = typeClass!.avatar
            if (typeClass!.avatar) != nil {
                photoImage?.kf.setImage(with: URL(string:url!), placeholder: #imageLiteral(resourceName: "backImage"), options: nil, progressBlock: nil, completionHandler: { (image, error, cacheType, imageURL) in
                    
                })
            }
            
            titleLabel?.text = typeClass!.realname
            detailLabel?.text = typeClass!.introduction

            
            
            
        }
    }
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
