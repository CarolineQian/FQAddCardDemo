//
//  memberCardCommonCell.swift
//  FQCard
//
//  Created by 冯倩 on 2017/5/23.
//  Copyright © 2017年 冯倩. All rights reserved.
//

import UIKit

class memberCardCommonCell: UITableViewCell
{
    //后面不加!会引起property 'self.frontImageView' not initialized at super init call的报错
    var frontImageView: UIImageView!
    var nameLabel: UILabel!
    var numLabel: UILabel!
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?)
    {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        if !self.isEqual(nil)
        {
            frontImageView = UIImageView(frame: CGRect(x: 15, y: 10, width: 100, height: 60))
            frontImageView.layer.masksToBounds = true
            frontImageView.layer.cornerRadius = 8
            contentView.addSubview(frontImageView)
            
            nameLabel = UILabel(frame: CGRect(x: 15 + frontImageView.width + 5, y: 10, width: ScreenWidth - 45 - 5 - frontImageView.width, height: 30))
            nameLabel.textAlignment = NSTextAlignment.left
            nameLabel.textColor = UIColor.hexStringToColor(hexString: ColorOfGrayText)
            nameLabel.font = Font14Thin
            contentView.addSubview(nameLabel)
            
            numLabel = UILabel(frame: CGRect(x: 15 + frontImageView.width + 5, y: 10 + nameLabel.height, width: ScreenWidth - 45 - 5 - frontImageView.width, height: 30))
            numLabel.textAlignment = NSTextAlignment.left
            numLabel.textColor = UIColor.hexStringToColor(hexString: ColorOfGrayText)
            numLabel.font = Font14Thin
            contentView.addSubview(numLabel)

        }
    }
    
    required init?(coder aDecoder: NSCoder)
    {
        fatalError("init(coder:) has not been implemented")
    }
    
}
