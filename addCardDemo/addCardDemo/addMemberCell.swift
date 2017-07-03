//
//  addMemberCell.swift
//  FQCard
//
//  Created by 冯倩 on 2017/5/22.
//  Copyright © 2017年 冯倩. All rights reserved.
//

import UIKit

class addMemberCell: UITableViewCell
{

    var titleLabel: UILabel!
    var inputTextField: UITextField!
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?)
    {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        if !self.isEqual(nil)
        {
            titleLabel = UILabel(frame: CGRect(x: 15, y: 0, width: 50, height: 50))
            titleLabel.textAlignment = NSTextAlignment.left
            addSubview(titleLabel)
            
            inputTextField = UITextField(frame: CGRect(x: titleLabel.width + 15, y: 10, width: ScreenWidth - titleLabel.width - 30, height: 30))
            inputTextField.font = Font14Thin
            inputTextField.textColor = UIColor.hexStringToColor(hexString: ColorOfGrayText)
            addSubview(inputTextField)
        }
    }
    
    required init?(coder aDecoder: NSCoder)
    {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
}
