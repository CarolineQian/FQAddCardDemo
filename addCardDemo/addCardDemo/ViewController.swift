//
//  ViewController.swift
//  addCardDemo
//
//  Created by 冯倩 on 2017/6/30.
//  Copyright © 2017年 冯倩. All rights reserved.
//

import UIKit

class ViewController: UITableViewController
{
    //控制本页面tableView样式
    var isType:Bool = true
    //
    var dataMutableArray : NSMutableArray = []
    
    override func viewWillAppear(_ animated: Bool)
    {
        super.viewWillAppear(true)
        print("保存本地的是\(String(describing: UserDefaults.standard.value(forKey: "memberList")))")
        //初始化,没有nil判空会崩溃
        if UserDefaults.standard.value(forKey: "memberList") != nil
        {
            let array = UserDefaults.standard.value(forKey: "memberList") as! NSArray
            dataMutableArray.removeAllObjects()
            let num = array.count
            for i in 0..<num
            {
                dataMutableArray.add(array[i])
            }
        }
        
        if dataMutableArray.count == 0
        {
            tableView?.backgroundView = tvBackgroundView
        }
        else
        {
            tableView?.backgroundView = nil
        }
        tableView.reloadData()
    }
    
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        self.title = "会员卡"
        navigationUI()
        tableViewUI()
    }
    
    //MARK: - 懒加载
    private lazy var tvBackgroundView: UIView =
    {
        let view = UIView()
        view.backgroundColor = UIColor.white
        let btn = UIButton()
        btn.frame = CGRect(x: ScreenWidth / 2 - 100, y: ScreenHeight / 2 - 25, width: 200, height: 50)
        btn.setTitle("点击添加第一张银行卡", for: UIControlState.normal)
        btn.setTitleColor(UIColor.darkGray, for: UIControlState.normal)
        btn.layer.borderColor = UIColor.hexStringToColor(hexString: ColorOfWaveBlueColor).cgColor
        btn.layer.borderWidth = 2
        btn.layer.cornerRadius = 8
        btn.layer.masksToBounds = true
        btn.addTarget(self, action:#selector(addMemberCardButtonAction), for: UIControlEvents.touchUpInside)
        view.addSubview(btn)
        return view
    }()
    
    
    //MARK: - UI
    private func tableViewUI()
    {
        tableView = UITableView(frame: CGRect(x:0,y:0,width:ScreenWidth,height:ScreenHeight), style: UITableViewStyle.grouped)
        tableView?.delegate = self
        tableView?.dataSource = self
    }
    
    private func navigationUI()
    {
        navigationController?.navigationBar.tintColor = UIColor.hexStringToColor(hexString: ColorOfBlueColor)
        //右侧编辑和添加按钮
        let item1 = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.add, target: self, action: #selector(addMemberCardButtonAction))
        let item2 = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.edit, target: self, action: #selector(editMemberCardButtonAction))
        navigationItem.rightBarButtonItems=[item1,item2]
    }
    
    //MARK: - Actions
    func addMemberCardButtonAction()
    {
        let controller = AddCardViewController()
        navigationController?.pushViewController(controller, animated: true)
        
    }

    
    func editMemberCardButtonAction()
    {
        ToastView.instance.removeToast(sender: self)
        
        if tableView.isEditing
        {
            tableView.isEditing = false
        }
        else
        {
            tableView.isEditing = true
        }
    }
    
    //MARK: - UITableViewDataSource
    //组数
    override func numberOfSections(in tableView: UITableView) -> Int
    {
        return 1
    }
    //行数
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return dataMutableArray.count
    }
    
    //行内容
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        
        let identifier = "identtifier";
        
        let cell = memberCardCommonCell(style: UITableViewCellStyle.subtitle, reuseIdentifier: identifier)
        cell.accessoryType=UITableViewCellAccessoryType.disclosureIndicator
        
        let item = dataMutableArray[indexPath.row] as! NSDictionary
        //因为字典里存的是绝对路径,需要再拼上相对路径
        let imagePath = "\(Tools().getDocumentsMemberFile())/\((item["frontPhoto"] as? String)!)"
        cell.frontImageView.image = UIImage(named:imagePath)
        cell.nameLabel.text = item["memberName"] as? String
        cell.numLabel.text = item["memberNum"] as? String
        
        return cell
        
    }
    
    //行高
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat
    {
            return 80

    }
    
    //左滑删除
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath)
    {
        //删除
        if editingStyle == UITableViewCellEditingStyle.delete
        {
            dataMutableArray.removeObject(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: UITableViewRowAnimation.fade)
            
            let array = dataMutableArray
            UserDefaults.standard.set(array, forKey: "memberList")
            
            if dataMutableArray.count == 0
            {
                tableView.backgroundView = tvBackgroundView
            }
            
        }
    }
    
    
    //编辑状态下的移动
    override func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath)
    {
        
        if sourceIndexPath != destinationIndexPath
        {
            let moveItem = dataMutableArray[sourceIndexPath.row]
            dataMutableArray.removeObject(at: sourceIndexPath.row)
            dataMutableArray.insert(moveItem, at: destinationIndexPath.row)
            
            let array = dataMutableArray
            UserDefaults.standard.set(array, forKey: "memberList")
        }
    }
    
    //点击
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
        
        tableView.deselectRow(at: indexPath, animated: true)
        let vc = AddCardViewController()
        vc.itemDic = (dataMutableArray[indexPath.row] as! NSDictionary) as! [String : String]
        self.navigationController?.pushViewController(vc, animated: true)
        
    }

    
    
    
    
}

