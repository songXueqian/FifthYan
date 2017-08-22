//
//  HomeChooseTableViewCell.swift
//  FifthYan
//
//  Created by LY on 2017/8/3.
//  Copyright © 2017年 SongXueqian. All rights reserved.
//

import UIKit

class HomeChooseTableViewCell: UITableViewCell {

    var rightImage : UIImageView?
    var lable : UILabel?
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super .init(style: style, reuseIdentifier: reuseIdentifier)
        
        lable = UILabel()
        lable?.frame = CGRect(x:0, y:7.5, width:SCREEN_WIDTH / 2, height:30)
        lable?.textColor = UIColor.black
        lable?.font = UIFont.systemFont(ofSize: 13)
        lable?.textAlignment = NSTextAlignment.center
        self.addSubview(lable!)
        
        rightImage = UIImageView()
        rightImage?.frame = CGRect(x:SCREEN_WIDTH / 2 + SCREEN_WIDTH / 2 / 2 - 10, y:17.5, width:10, height:10)
        rightImage?.image = UIImage(named:"gou")
        rightImage?.isHidden = true
        self.addSubview(rightImage!)
        
       

        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
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
