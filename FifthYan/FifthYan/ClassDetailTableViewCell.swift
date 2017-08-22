//
//  ClassDetailTableViewCell.swift
//  FifthYan
//
//  Created by LY on 2017/8/7.
//  Copyright © 2017年 SongXueqian. All rights reserved.
//

import UIKit

class ClassDetailTableViewCell: UITableViewCell {

    var whiteView : UIView?
    var bigImage : UIImageView?
    var titleLabel : UILabel?
    var detailLabel : UILabel?
    var timeLabel : UILabel?
    
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super .init(style: style, reuseIdentifier: reuseIdentifier)
        
        
        whiteView = UIView()
        whiteView?.frame = CGRect(x:0, y:0, width:SCREEN_WIDTH, height:400)
        whiteView?.backgroundColor = UIColor.white
        self.contentView.addSubview(whiteView!)
        
        bigImage = UIImageView()
        bigImage?.frame = CGRect(x:15, y:20, width:SCREEN_WIDTH - 30, height:180)
        whiteView?.addSubview(bigImage!)
        
        titleLabel = UILabel()
        titleLabel?.frame = CGRect(x:(bigImage?.frame.origin.x)!, y:(bigImage?.frame.origin.y)! + (bigImage?.frame.size.height)! + 5, width:(bigImage?.frame.size.width)!, height:30)
        titleLabel?.textColor = UIColor.black
        titleLabel?.font = UIFont.systemFont(ofSize: 16)
        whiteView?.addSubview(titleLabel!)
        
        detailLabel = UILabel()
        detailLabel?.frame = CGRect(x:(titleLabel?.frame.origin.x)!, y:(titleLabel?.frame.origin.y)! + (titleLabel?.frame.size.height)!, width:(titleLabel?.frame.size.width)!, height:30)
        detailLabel?.textColor = UIColor.lightGray
        detailLabel?.font = UIFont.systemFont(ofSize: 12)
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
            
            
            let url = product!.image
            bigImage?.kf.setImage(with: URL(string:url!), placeholder: #imageLiteral(resourceName: "backImage")        , options: nil, progressBlock: nil, completionHandler: { (image, error, cacheType, imageURL) in
                
            })
            titleLabel?.text = product!.title
            detailLabel?.text = product!.subtitle
            
            let string = String(format:"%d", (product?.read_cost)!)
            timeLabel?.text = String(format:"%@分后", string)
            
            
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
