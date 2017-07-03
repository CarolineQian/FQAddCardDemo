//
//  Tools.swift
//  FQCard
//
//  Created by 冯倩 on 2017/5/9.
//  Copyright © 2017年 冯倩. All rights reserved.
//

import UIKit

class Tools: NSObject
{
    //MARK: - 将数组转换成字符串
    public func passwordString(array: NSArray) -> String
    {
        var str = ""
        for p in array
        {
            str.append(String(describing: p))
        }
        return str
    }
    
    //MARK: - 获取当前时间戳
    public func getTimeSP() -> Int
    {
        let now = Date()
        let timeInterval:TimeInterval = now.timeIntervalSince1970
        let timeStamp = Int(timeInterval)
        return timeStamp
    }
    
    //MAARK: - 获取Documents下的路径
    /*
     *在iOS8之前，我们获取到沙盒中的document、cache、tmp之后，下一次模拟器或真机无论怎样重启，这具体的路径是固定的了
     在iOS8之后，苹果可能考虑到安全因素，应用每一次重启，沙盒路径都动态的发生了变化,但是并不代表你原来沙盒路径中的数据发生了变化；同时，也并不代表路径会越来越多
     1>苹果会把你上一个路径中的数据转移到你新的路径中。
     2>你上一个路径也会被苹果毫无保留的删除，只保留最新的路径
     */
    public func getDocumentsMemberFile() -> String
    {
        //Documents下创建或找到文件
        let rootPath = NSSearchPathForDirectoriesInDomains(.documentDirectory,.userDomainMask, true)[0] as String
        let filePath:String = rootPath + "/Documents/Member"
        return filePath
    }
    

}
