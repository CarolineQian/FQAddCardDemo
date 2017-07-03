//
//  AddCardViewController.swift
//  addCardDemo
//
//  Created by 冯倩 on 2017/6/30.
//  Copyright © 2017年 冯倩. All rights reserved.
//

import UIKit

class AddCardViewController: UITableViewController,UIImagePickerControllerDelegate,UINavigationControllerDelegate
{
    //正面照片按钮
    let frontBtn = UIButton()
    //背面照片按钮
    let backBtn = UIButton()
    //控制当前是正面照还是背面照
    var isFront : Bool = true
    
    
    //model保存当前卡片信息
    var frontPhoto : String = ""
    var backPhoto : String = ""
    var memberName : String = ""
    var memberNum : String = ""
    var memberPassWord : String = ""
    
    //下面是进来编辑的
    var itemDic = [String:String]()
    

    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        tableView = UITableView(frame: CGRect(x:0,y:0,width:ScreenWidth,height:ScreenHeight), style: UITableViewStyle.grouped)
        tableView?.delegate = self
        tableView?.dataSource = self
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "保存", style: UIBarButtonItemStyle.plain, target: self, action: #selector(rightBarButtonItemAction))
        NotificationCenter.default.addObserver(self, selector: #selector(notificationResponse(notification:)), name: NSNotification.Name.UITextFieldTextDidChange, object: nil)

    }
    
    //MARK: - Actions
    func rightBarButtonItemAction()
    {
        if (memberName.lengthOfBytes(using: String.Encoding.utf8) == 0 ||
            memberNum.lengthOfBytes(using: String.Encoding.utf8) == 0 ||
            memberPassWord.lengthOfBytes(using: String.Encoding.utf8) == 0 ||
            frontPhoto.lengthOfBytes(using: String.Encoding.utf8) == 0 ||
            backPhoto.lengthOfBytes(using: String.Encoding.utf8) == 0)
        {
            ToastView.instance.showToast(content: "输入不全", duration: 1.5)
        }
        else
        {
            //输入全了,保存本地
            var dic = [String:Any]()
            dic["frontPhoto"] = frontPhoto
            dic["backPhoto"] = backPhoto
            dic["memberName"] = memberName
            dic["memberNum"] = memberNum
            dic["memberPassWord"] = memberPassWord
            
            let memberList : NSMutableArray = []
            if UserDefaults.standard.value(forKey: "memberList") != nil
            {
                let array = UserDefaults.standard.value(forKey: "memberList") as! NSArray
                memberList.removeAllObjects()
                let num = array.count
                for i in 0..<num
                {
                    memberList.add(array[i])
                }
            }
            
            //重新编辑,移除之前的
            if itemDic.count > 0
            {
                let index = memberList.index(of: itemDic)
                memberList.remove(itemDic)
                memberList.insert(dic, at: index)
            }
            else
            {
                memberList.add(dic)
            }
            
            
            let array = memberList
            UserDefaults.standard.set(array, forKey: "memberList")
            
            //返回上一页
            navigationController?.popViewController(animated: true)
            

        }

        

    }
    
    //点击头部添加图片
    func btnAction(btn: UIButton)
    {
        isFront = btn.tag == 0 ? true : false
        //弹框提示如何选择图片
        let alertController = UIAlertController(title: btn.tag == 0 ? "正面图片" : "背面图片", message: nil, preferredStyle: .actionSheet)
        let cancelAction = UIAlertAction(title: "取消", style: .cancel, handler:
        {
            (UIAlertAction) -> Void in
            print("你点击了取消")
        })
        let okAction = UIAlertAction(title: "从相册中选择照片", style: .default, handler:
        {
            (UIAlertAction) -> Void in
            print("点击从相册中选择")
            let imagePicker = UIImagePickerController()
            imagePicker.delegate = self
            imagePicker.allowsEditing = true
            imagePicker.sourceType = UIImagePickerControllerSourceType.photoLibrary
            self.present(imagePicker, animated: true, completion: nil)
        })
        
        let okAction1 = UIAlertAction(title: "拍照", style: .default, handler:
        {
            (UIAlertAction) -> Void in
            if UIImagePickerController.isSourceTypeAvailable(.camera)
            {
                print("拍照可用")
                let imagePicker = UIImagePickerController()
                imagePicker.delegate = self
                imagePicker.allowsEditing = true
                imagePicker.sourceType = UIImagePickerControllerSourceType.camera
                self.present(imagePicker, animated: true, completion: nil)
            }
            else
            {
                print("拍照不可用")
            }
            
        })
        alertController.addAction(cancelAction)
        alertController.addAction(okAction)
        alertController.addAction(okAction1)
        self.present(alertController, animated: true, completion: nil)
        
    }

    
    //MARK: - UITableViewDataSource
    override func numberOfSections(in tableView: UITableView) -> Int
    {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return 3
        
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let identifier = "identtifier";
        let cell = addMemberCell(style: UITableViewCellStyle.subtitle, reuseIdentifier: identifier)
        //cell无任何点击效果
        cell.selectionStyle = UITableViewCellSelectionStyle.none
        if indexPath.row == 0
        {
            cell.titleLabel.text = "名称:"
        }
        else if indexPath.row == 1
        {
            cell.titleLabel.text = "卡号:"
        }
        else
        {
            cell.titleLabel.text = "密码:"
        }
        
        cell.inputTextField.tag = indexPath.row
        
        //重新编辑
        if itemDic.count > 0
        {
            if indexPath.row == 0
            {
                cell.inputTextField.text = itemDic["memberName"]
                memberName = itemDic["memberName"]!
            }
            else if indexPath.row == 1
            {
                cell.inputTextField.text = itemDic["memberNum"]
                memberNum = itemDic["memberNum"]!
            }
            else
            {
                cell.inputTextField.text = itemDic["memberPassWord"]
                memberPassWord = itemDic["memberPassWord"]!
            }
        }

        
           return cell;
    }
    
    
    //MARK: - UITableViewDelegate
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat
    {
        return 200
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat
    {
        return 50
        
    }
    
    override func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat
    {
        return 0.1
    }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView?
    {
        let headView = UIView()
        headView.backgroundColor = UIColor.white
        //正面照片按钮
        frontBtn.frame = CGRect(x: 15, y: 25, width: ScreenWidth / 2 - 15 * 2, height: 200 - 25 * 2)
        frontBtn.backgroundColor = UIColor.red
        frontBtn.addTarget(self, action: #selector(btnAction(btn:)), for: UIControlEvents.touchUpInside)
        frontBtn.tag = 0
        headView.addSubview(frontBtn)
        //背面照片按钮
        backBtn.frame = CGRect(x: ScreenWidth / 2 + 15, y: 25, width: ScreenWidth / 2 - 15 * 2, height: 200 - 25 * 2)
        backBtn.backgroundColor = UIColor.red
        backBtn.addTarget(self, action: #selector(btnAction(btn:)), for: UIControlEvents.touchUpInside)
        backBtn.tag = 1
        headView.addSubview(backBtn)
        
        //重新编辑
        if itemDic.count > 0
        {
            let frontImagePath = "\(Tools().getDocumentsMemberFile())/\((itemDic["frontPhoto"])!)"
            frontBtn.setImage(UIImage(named:frontImagePath), for: UIControlState.normal)
            let backImagePath = "\(Tools().getDocumentsMemberFile())/\((itemDic["backPhoto"])!)"
            backBtn.setImage(UIImage(named:backImagePath), for: UIControlState.normal)
            frontPhoto = itemDic["frontPhoto"]!
            backPhoto = itemDic["backPhoto"]!
        }
        
        return headView
    }

    
    //MARK: - UIImagePickerControllerDelegate
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any])
    {
        //在相册中选择完照片后的回调
        picker.dismiss(animated: true, completion: nil)
        let imageStr : UIImage = info[UIImagePickerControllerEditedImage] as! UIImage
        //将图片存入文件
        let filePath = Tools().getDocumentsMemberFile()
        let exist = FileManager.default.fileExists(atPath: filePath)
        if !exist
        {
            try! FileManager.default.createDirectory(atPath: filePath,
                                                     withIntermediateDirectories: true, attributes: nil)
        }
        //将图片保存在文件中
        let imagePath = "\(filePath)/\(Tools().getTimeSP()).jpg"
        let imageData = UIImageJPEGRepresentation(imageStr, 1.0)
        FileManager.default.createFile(atPath: imagePath, contents: imageData, attributes: nil)
        //保存相对路径
        let imageNSURL:NSURL = NSURL.init(fileURLWithPath: imagePath)
        let imageLastPath = imageNSURL.lastPathComponent!
        //显示
        if isFront
        {
            frontBtn.setImage(imageStr, for: UIControlState.normal)
            frontPhoto = imageLastPath
        }
        else
        {
            backBtn.setImage(imageStr, for: UIControlState.normal)
            backPhoto = imageLastPath
        }
        
    }
    
    //MARK: - NSNotification
    
    func notificationResponse(notification: NSNotification)
    {
        let textField : UITextField = notification.object as! UITextField
        if textField.tag == 0
        {
            memberName = textField.text!
        }
        else if textField.tag == 1
        {
            memberNum = textField.text!
        }
        else
        {
            memberPassWord = textField.text!
        }
    }
    
}
