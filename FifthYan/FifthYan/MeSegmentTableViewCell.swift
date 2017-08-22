//
//  MeSegmentTableViewCell.swift
//  FifthYan
//
//  Created by LY on 2017/8/4.
//  Copyright © 2017年 SongXueqian. All rights reserved.
//

import UIKit

typealias TypeBool = (_ type:ObjCBool) -> Void

class MeSegmentTableViewCell: UITableViewCell {

    var switchView : UISwitch?
    var backType : TypeBool?
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        switchView = UISwitch()
        switchView?.frame = CGRect(x:SCREEN_WIDTH - (switchView?.frame.size.width)! - 10, y:7, width:0, height:30)
        switchView?.isOn = false
        self.addSubview(switchView!)
        switchView?.addTarget(self, action: #selector(switchDidChange), for:UIControlEvents.valueChanged)

    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()

        
    }

    
    func switchDidChange(){
        if (switchView?.isOn)! {
            switchView?.isOn = true
            backType!(true)
            
            
        } else {
            switchView?.isOn = false
            backType!(false)

        }
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
