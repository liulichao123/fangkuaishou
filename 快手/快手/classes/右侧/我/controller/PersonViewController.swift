//
//  PersonViewController1.swift
//  快手
//
//  Created by liulichao on 16/5/17.
//  Copyright © 2016年 刘立超. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

private let reuseIdentifier = "Cell"
private let reuseHeaderIdentifier = "Header"
class PersonViewController: UICollectionViewController {
    /**0 自己作品 1他人*/
    var vcType: Int = 0
    var navView: UINavigationBar?
    var topView: UIButton?
    var centerView: UIView?
    var modelUser: User?
    var videos: NSMutableArray?
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Register cell classes
        self.collectionView!.registerClass(HomeCollectionCell.self, forCellWithReuseIdentifier: reuseIdentifier)
        //注册header
        self.collectionView!.registerClass(PersonHeaderView.self, forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: reuseHeaderIdentifier)
        
        view.backgroundColor = UIColor.whiteColor()
        collectionView?.backgroundColor = UIColor.whiteColor()
        //添加导航栏
        let navBar: UINavigationBar = UINavigationBar(frame: CGRectMake(0, 0, statusBarSize.width, 64))
        let item = UINavigationItem(title: "我")
        item.leftBarButtonItem = UIBarButtonItem(title: "返回", style: UIBarButtonItemStyle.Plain, target: self, action: #selector(PersonViewController.back(_:)))
        navBar.items = [item]
        navBar.lt_setBackgroundColor(UIColor.clearColor())
        view.addSubview(navBar)
        //加载数据
        videos = NSMutableArray()
        loadData()
    }

    override init(collectionViewLayout layout: UICollectionViewLayout) {
        super.init(collectionViewLayout: layout)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    //MARK:监听返回点击
    func back(barBtn: UIBarButtonItem) {
        if vcType == 0 {
            //发送通知告诉父控制器
            NSNotificationCenter.defaultCenter().postNotificationName(leftBtnClickNotificatioin, object: nil)
        }else{
            dismissViewControllerAnimated(true, completion: nil)
        }
        
    }
    func loadData() {
        let url = PersonVideosIP
        if let myId = modelUser?.id {
        let parameters = ["beginVideoId":0, "pageSize":50, "targetId":myId, "type":0]//页数
        Alamofire.request(.GET, url, parameters: parameters)
            .validate()
            .responseJSON { response in
                switch response.result {
                case .Success:
                    printLog("个人获取所发视频 Successful")
                    let json: JSON = JSON(response.result.value!)
                    if let videos: Array = json["list"].array {
                        for v: JSON in videos {
                            if let video: Video = Video.instanceWithDict(v.dictionaryObject!) {
                                    //添加到最顶部
                                    self.videos!.addObject(video)
                            }
                        }
                    }
                    
                case .Failure(let error):
                    printLog(error)
                }
                //排序
                self.sortViedes(self.videos!)
                self.collectionView!.reloadData()
        }
        }
    }
    //数组降序排序
    func sortViedes(arrayM: NSMutableArray){
        arrayM.sortUsingComparator { (o1, o2) -> NSComparisonResult in
            let v1 = o1 as! Video
            let v2 = o2 as! Video
            if v1.id > v2.id{
                return NSComparisonResult.OrderedAscending
            }else{
                return NSComparisonResult.OrderedDescending
            }
        }
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
    }
    */

    // MARK: UICollectionViewDataSource

    override func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }


    override func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        return (videos?.count)!
    }

    override func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell: HomeCollectionCell = collectionView.dequeueReusableCellWithReuseIdentifier(reuseIdentifier, forIndexPath: indexPath) as! HomeCollectionCell
        // Configure the cell
        cell.model = videos![indexPath.item] as? Video
        cell.backgroundColor = UIColor.redColor()
        return cell
    }
    
//    collectionview
    //设置高待续。。。。。
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSizeMake(UIScreen.mainScreen().bounds.size.width, 350)
    }
    //返回header
    override func collectionView(collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, atIndexPath indexPath: NSIndexPath) -> UICollectionReusableView {
        var headerView: UICollectionReusableView

        headerView =  collectionView.dequeueReusableSupplementaryViewOfKind(UICollectionElementKindSectionHeader, withReuseIdentifier: reuseHeaderIdentifier, forIndexPath: indexPath)
        return headerView
        
    }
    override func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        let detailVC: HomeDetailViewController = HomeDetailViewController()
        detailVC.videoModel = videos![indexPath.item] as? Video
        //设置回调
        detailVC.callback = {
            () in
            collectionView.reloadItemsAtIndexPaths([indexPath])
        }
        
        presentViewController(detailVC, animated: false, completion: nil)
    }
    
    // MARK: UICollectionViewDelegate

    /*
    // Uncomment this method to specify if the specified item should be highlighted during tracking
    override func collectionView(collectionView: UICollectionView, shouldHighlightItemAtIndexPath indexPath: NSIndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment this method to specify if the specified item should be selected
    override func collectionView(collectionView: UICollectionView, shouldSelectItemAtIndexPath indexPath: NSIndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
    override func collectionView(collectionView: UICollectionView, shouldShowMenuForItemAtIndexPath indexPath: NSIndexPath) -> Bool {
        return false
    }

    override func collectionView(collectionView: UICollectionView, canPerformAction action: Selector, forItemAtIndexPath indexPath: NSIndexPath, withSender sender: AnyObject?) -> Bool {
        return false
    }

    override func collectionView(collectionView: UICollectionView, performAction action: Selector, forItemAtIndexPath indexPath: NSIndexPath, withSender sender: AnyObject?) {
    
    }
    */
    
}
