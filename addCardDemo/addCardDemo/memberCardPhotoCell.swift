//
//  memberCardPhotoCell.swift
//  FQCard
//
//  Created by 冯倩 on 2017/5/24.
//  Copyright © 2017年 冯倩. All rights reserved.
//

import UIKit

class memberCardPhotoCell: UITableViewCell
{

    //后面不加!会引起property 'self.frontImageView' not initialized at super init call的报错
    var frontImageView: UIImageView!
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?)
    {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        if !self.isEqual(nil)
        {
            frontImageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 250, height: 140))
            frontImageView.center = CGPoint(x: ScreenWidth / 2, y: 160 / 2)
            frontImageView.layer.masksToBounds = true
            frontImageView.layer.cornerRadius = 8
            contentView.addSubview(frontImageView)
        }
    }
    
    required init?(coder aDecoder: NSCoder)
    {
        fatalError("init(coder:) has not been implemented")
    }


}
