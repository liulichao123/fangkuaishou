//
//  BaseViewController.swift
//  快手
//
//  Created by liulichao on 16/5/13.
//  Copyright © 2016年 刘立超. All rights reserved.
//
//首页中三个控制器的基类控制器
import UIKit
import Alamofire
import SwiftyJSON

//首页类型
enum  HomeType: Int {
    case GuanZhu
    case FaXian
    case TongCheng
}

class BaseViewController: UICollectionViewController {
    
    let reuseIdentifier = "Cell"
    let videos: NSMutableArray = NSMutableArray()
    var firstVideoId: Int = 1
    var lastVideoId: Int = 1
    //自身类型 关注 发现 同城 子类不重写的话默认为faxian
    func mytype() -> HomeType {
        return HomeType.FaXian
    }
    override func viewDidLoad() {
        super.viewDidLoad()

        // Register cell classes
        self.collectionView!.registerClass(HomeCollectionCell.self, forCellWithReuseIdentifier: reuseIdentifier)
        
        view.backgroundColor = UIColor.whiteColor()
        collectionView?.backgroundColor = UIColor.whiteColor()
        //添加上拉刷新
        setupRefresh()
        
        //手动刷新
        collectionView?.mj_header.beginRefreshing()
        
    }

    
    override init(collectionViewLayout layout: UICollectionViewLayout) {
        let myLayout = KSCollectionLayout()
        let w = (ScreenSize.width - 5) / 2
        myLayout.itemSize = CGSizeMake(w, 170)
        super.init(collectionViewLayout: myLayout)
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
       
    }
    //添加下拉上拉刷新
    func setupRefresh() {
        var url: String
        switch mytype() {
        case HomeType.GuanZhu:
            url = HomeGuanZhuIP
        case HomeType.FaXian:
            url = HomeFaXianIP
        case HomeType.TongCheng:
            url = HomeTongChengIP
        }
        refresh(url)
    }
    func refresh(url: String) {
        //下拉刷新
        collectionView?.mj_header = MJRefreshNormalHeader(refreshingBlock: {
            let myId = UserTool.sharedInstance.user.id!
            print("myId:",myId)
            //取出原有最上面一条video的id
            var firstId = 0
            if let first: Video = self.videos.firstObject as? Video {
                firstId = first.id!
            }
            let parameters = ["beginVideoId":firstId, "pageSize":PageSize, "targetId":myId, "type":0]//页数
            Alamofire.request(.GET, url, parameters: parameters)
                .validate()
                .responseJSON { response in
                    switch response.result {
                    case .Success:
                        printLog("首页\(self.mytype())刷新  Successful")
                        let json: JSON = JSON(response.result.value!)
                        if let videos: Array = json["list"].array {
                            for v: JSON in videos {
                                if let video: Video = Video.instanceWithDict(v.dictionaryObject!) {
                                    if video.id > firstId {//比较id
                                        //添加到最顶部
                                        self.videos.insertObject(video, atIndex: 0)
                                    }
                                    
                                }
                            }
                        }
                        
                    case .Failure(let error):
                        printLog(error)
                    }
                    //排序
                    self.sortViedes(self.videos)
                    self.collectionView!.reloadData()
                    self.collectionView?.mj_header.endRefreshing()
            }
            
        })
        
        //上拉刷新
        collectionView?.mj_footer = MJRefreshAutoNormalFooter(refreshingBlock: { 
            let myId = UserTool.sharedInstance.user.id!
            print("myId:",myId)
            //取出原有最下面一条video的id
            var lastId = 0
            if let last: Video = self.videos.lastObject as? Video {
                lastId = last.id!
            }
            let parameters = ["beginVideoId":lastId, "pageSize":PageSize, "targetId":myId, "type":1]//type=1 返回比beginVideoId小的
            Alamofire.request(.GET, url, parameters: parameters)
                .validate()
                .responseJSON { response in
                    switch response.result {
                    case .Success:
                        printLog("首页\(self.mytype())刷新  Successful")
                        let json: JSON = JSON(response.result.value!)
                        if let videos: Array = json["list"].array {
                            for v: JSON in videos {
                                if let video: Video = Video.instanceWithDict(v.dictionaryObject!) {
                                    if video.id < lastId {//比较id
                                        //添加到最低部
                                        self.videos.addObject(video)
                                    }
                                    
                                }
                            }
                        }
                        
                    case .Failure(let error):
                        printLog(error)
                    }
                    //排序
                    self.sortViedes(self.videos)
                    self.collectionView!.reloadData()
                    self.collectionView?.mj_footer.endRefreshing()
            }

        })
        
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
    override func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
       
        return videos.count
    }
    
    override func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell: HomeCollectionCell = collectionView.dequeueReusableCellWithReuseIdentifier(reuseIdentifier, forIndexPath: indexPath) as! HomeCollectionCell
        // Configure the cell
        cell.model = videos[indexPath.item] as? Video

        return cell
    }
    
    // MARK: UICollectionViewDelegate
    override func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        let detailVC: HomeDetailViewController = HomeDetailViewController()
        detailVC.videoModel = videos[indexPath.item] as? Video
        //设置回调
        detailVC.callback = {
            () in
            collectionView.reloadItemsAtIndexPaths([indexPath])
        }

        presentViewController(detailVC, animated: false, completion: nil)
        
    }

}
