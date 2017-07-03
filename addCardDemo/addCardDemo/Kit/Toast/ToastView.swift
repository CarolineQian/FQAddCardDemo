//
//  ToastView.swift
//  FQCard
//
//  Created by 冯倩 on 2017/5/22.
//  Copyright © 2017年 冯倩. All rights reserved.
//

import UIKit

class ToastView: NSObject
{
    static var instance : ToastView = ToastView()
    
    var windows = UIApplication.shared.windows
//    let rv = UIApplication.shared.keyWindow?.subviews.first as UIView!
    let rv = UIApplication.shared.windows.last
    
    
    //显示加载圈圈
    func showLoadingView()
    {
        clear()
        let frame = CGRect(x: 0, y: 0, width: 78, height: 78)
        
        let loadingContainerView = UIView()
        loadingContainerView.layer.cornerRadius = 12
        loadingContainerView.backgroundColor = UIColor(red:0, green:0, blue:0, alpha: 0.8)
        
        let indicatorWidthHeight :CGFloat = 36
        let loadingIndicatorView = UIActivityIndicatorView(activityIndicatorStyle: UIActivityIndicatorViewStyle.whiteLarge)
        loadingIndicatorView.frame = CGRect(x: frame.width/2 - indicatorWidthHeight/2, y: frame.height/2 - indicatorWidthHeight/2, width: indicatorWidthHeight, height: indicatorWidthHeight)
        loadingIndicatorView.startAnimating()
        loadingContainerView.addSubview(loadingIndicatorView)
        
        let window = UIWindow()
        window.backgroundColor = UIColor.clear
        window.frame = frame
        loadingContainerView.frame = frame
        
        window.windowLevel = UIWindowLevelAlert
        window.center = CGPoint(x: (rv?.center.x)!, y: (rv?.center.y)!)
        window.isHidden = false
        window.addSubview(loadingContainerView)
        
        windows.append(window)
        
    }
    
    //弹窗图片文字
    func showToast(content:String , duration:CFTimeInterval)
    {
        clear()
        let frame = CGRect(x: 0, y: 0, width: 90, height: 90)
        
        let toastContainerView = UIView()
        toastContainerView.layer.cornerRadius = 10
        toastContainerView.backgroundColor = UIColor(red:0, green:0, blue:0, alpha: 0.7)
        
        let iconWidthHeight :CGFloat = 36
//        let toastIconView = UIImageView(image: UIImage(named: imageName)!)
//        toastIconView.frame = CGRect(x: (frame.width - iconWidthHeight)/2, y: 15, width: iconWidthHeight, height: iconWidthHeight)
//        
//        toastContainerView.addSubview(toastIconView)
        
        let toastContentView = UILabel(frame: CGRect(x: 0, y: iconWidthHeight + 5, width: frame.height, height: frame.height - iconWidthHeight))
        toastContentView.font = UIFont.systemFont(ofSize: 13)
        toastContentView.textColor = UIColor.white
        toastContentView.text = content
        toastContentView.textAlignment = NSTextAlignment.center
        toastContainerView.addSubview(toastContentView)
        
        
        let window = UIWindow()
        window.backgroundColor = UIColor.clear
        window.frame = frame
        toastContainerView.frame = frame
        
        window.windowLevel = UIWindowLevelAlert
        window.center = CGPoint(x: (rv?.center.x)!, y: (rv?.center.y)! * 16/10)
        window.isHidden = false
        window.addSubview(toastContainerView)
        windows.append(window)
        
        toastContainerView.layer.add(AnimationUtil.getToastAnimation(duration: duration), forKey: "animation")
        
        perform(#selector(removeToast(sender: )), with: window, afterDelay: duration)
    }
    
    //移除当前弹窗
    func removeToast(sender: AnyObject)
    {
        if let window = sender as? UIWindow
        {
            if let index = windows.index(where: { (item) -> Bool in
                return item == window
            })
            {
                 print("find the window and remove it at index \(index)")
                windows.remove(at: index)
            }
        }
        else
        {
             print("can not find the window")
        }
    }
    
    //清除所有弹窗
    func clear()
    {
        NSObject.cancelPreviousPerformRequests(withTarget: self)
        windows.removeAll(keepingCapacity: false)
    }


}
