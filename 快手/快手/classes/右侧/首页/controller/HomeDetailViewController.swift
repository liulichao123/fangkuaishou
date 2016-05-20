//
//  HomeDetailViewController.swift
//  快手
//
//  Created by liulichao on 16/5/8.
//  Copyright © 2016年 刘立超. All rights reserved.
//
import AVFoundation
import AVKit
import Alamofire
import SwiftyJSON
/**定义闭包，用于回调刷新*/
typealias callbackfunc = () -> Void

class HomeDetailViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, HomeDetailNavBarDelegate{
    //MARK:属性
    private let ID: String = "cell"
    var videoModel: Video? {
        didSet {
            
        }
    }
    /**导航栏**/
    private var navView: HomeDetailNavBar?
    /**内容视图**/
    private var tableView: UITableView?
    /**视频播放view**/
    private var playerView: UIView?
    private var player: AVPlayer?
    private var playerItem: AVPlayerItem?
    //进度条
    private var progressView: UIProgressView?
    //缓冲状态
    private var progressStatus: Bool = false
    //播放状态
    private var playStatus: Bool = true
    /**双击蒙版**/
    private var likeCover: UIImageView?
    private var likeCoverClick: Bool = false
    
    /**回调函数*/
    var callback = callbackfunc?()
//    MARK:系统方法
    override func viewDidAppear(animated: Bool) {
        player?.play()
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
   //MARK: 初始化
    func setup() {
        let w = view.frame.width
        view.backgroundColor = UIColor.whiteColor()
        //导航栏
        navView = HomeDetailNavBar(frame: CGRectMake(0,0, w, 64))
        navView?.detailDelegate = self;
        view.addSubview(navView!)
        //内容视图
        tableView = UITableView(frame: CGRectMake(0, navView!.frame.maxY, w, view.frame.height - statusBarSize.height - navView!.frame.height))
        tableView?.delegate = self
        tableView?.dataSource = self
        tableView?.registerClass(UITableViewCell.self, forCellReuseIdentifier: ID)
//       该种方式添加的header会随table滚动，如果在代理方法中实现，header将不会随table滚动
        tableView?.bounces = false
        setupPlayerView()
        tableView?.tableHeaderView = playerView
        view.addSubview(tableView!)
    }
    //初始化播放器相关
    func setupPlayerView() {
        let h = self.view.frame.width / CGFloat((videoModel?.scale)!)
        playerView = UIView(frame: CGRectMake(0, 0, view.frame.width, h))
        playerView!.backgroundColor = UIColor.purpleColor()
        let urlStr = VideoPrePath + (videoModel?.urlPath!)!
        let url = NSURL(string: urlStr)!
        playerItem = AVPlayerItem(URL: url)
        //添加观察者
        playerItem!.addObserver(self, forKeyPath: "status", options: .New, context:nil)
        playerItem!.addObserver(self, forKeyPath: "loadedTimeRanges", options:.New ,context: nil)// status
        //添加通知
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(HomeDetailViewController.myMovieFinishedCallback(_:)), name: AVPlayerItemDidPlayToEndTimeNotification, object: playerItem)
        player = AVPlayer(playerItem: playerItem!)
        let playerLayer = AVPlayerLayer(player: player)
        playerLayer.frame = playerView!.frame
        playerView!.layer.addSublayer(playerLayer)
        
        //添加双击事件
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(HomeDetailViewController.tapTWO(_:)))
        tap.numberOfTapsRequired = 2
        tap.numberOfTouchesRequired = 1
        playerView?.addGestureRecognizer(tap)
        
        //双击显示效果
        let x = (playerView?.frame.width)! * 0.5 - 50
        let y = (playerView?.frame.height)! * 0.5 - 42
        likeCover = UIImageView(frame: CGRectMake(x, y, 100, 84))
        likeCover?.image = UIImage(named: "daxin")
        likeCover?.hidden = true
        playerView?.addSubview(likeCover!)
        
        //进度条
        progressView = UIProgressView(frame: CGRectMake(0, ((playerView?.frame.maxY)! - 10), (playerView?.frame.width)!, 10))
        progressView?.progress = 0
        progressView?.tintColor = UIColor.orangeColor()
        progressView?.trackTintColor = UIColor.lightGrayColor()
        playerView?.addSubview(progressView!)
        
    }
    
    //MARK:触发双击事件
    func tapTWO(tap: UITapGestureRecognizer) {
        printLog("双击")
        if likeCoverClick {//正在双击动画过程中
            return
        }
        let myId = (UserTool.sharedInstance.user.id)!
        let targetId = (videoModel?.id)!
        let parameters = ["myId":myId, "targetId":targetId]
        Alamofire.request(.GET, AddLikeIP, parameters: parameters)
            .validate()
            .responseJSON { response in
                switch response.result {
                case .Success:
                    printLog("双击返回 Successful")
                    printLog(response.result.value)
                    let JSON = response.result.value
                    if JSON!["status"] as? Int == 200 {
                        self.videoModel?.likes = (self.videoModel?.likes)! + 1
                        //使用闭包回调，刷新主页UI 双击数加一
                        self.callback!()
//                        self.navView?.hiddenBtnIndex(3)
                    }
 
                    self.likeCover?.hidden = false
                    self.likeCoverClick = true//Int64(1.0 * Double(NSEC_PER_SEC)
                    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, Int64(0.5 * Double(NSEC_PER_SEC))), dispatch_get_main_queue(), {
                        self.likeCover?.hidden = true
                        self.likeCoverClick = false
                    })
                case .Failure(let error):
                    printLog(error)
                }
        }
        
        
    }
    
    //MARK: KVO
    /** * 通过KVO监控播放器状态 *
     * @param keyPath 监控属性
     * @param object 监视器
     * @param change 状态改变
     * @param context 上下文 */
    override func observeValueForKeyPath(keyPath: String?, ofObject object: AnyObject?, change: [String : AnyObject]?, context: UnsafeMutablePointer<Void>) {
        
        if "status" == keyPath {
            if playStatus == false {
                return
            }
            let status = (change![NSKeyValueChangeNewKey] as! NSNumber).integerValue as AVPlayerStatus.RawValue
            switch (status) {
            case AVPlayerStatus.ReadyToPlay.rawValue:
                
                self.player!.play()
            case AVPlayerStatus.Failed.rawValue:
                print("Failed to load video")
            default:
                true
            }
        }else if "loadedTimeRanges" == keyPath{
            if playStatus == false {
                return
            }
            //因为播放时会卡顿，所以在这里也需要调用播放方法
            self.player!.play()
            if !progressStatus {//如果未缓存完
                let playerItem1: AVPlayerItem = object as! AVPlayerItem
                //计算缓冲进度
                let timeRange: CMTimeRange = (playerItem1.loadedTimeRanges.first?.CMTimeRangeValue)!//本次缓冲时间范围
                let startSeconds = CMTimeGetSeconds(timeRange.start) //缓冲开始时间
                let durationSeconds = CMTimeGetSeconds(timeRange.duration)//缓冲长度
                let timeInterval = startSeconds + durationSeconds;//共缓冲的总长度
//                print("startSeconds:",startSeconds)
//                print("durationSeconds:",durationSeconds)
//                print("timeInterval:",timeInterval)
                if let all = videoModel?.timeLength where all > 0 {
                    let pro: Float = Float(timeInterval) / all
//                    print("进度：",pro)
                    progressView?.progress = Float(pro)
                }
                
            }
            
        }else{
            super.observeValueForKeyPath(keyPath, ofObject: object, change: change, context: context)
        }
    }
    //MARK:监听播放完成
    func myMovieFinishedCallback(notification: NSNotification) {
        print("播放结束")
        progressStatus = true
        progressView?.progress = 1.0
        player?.seekToTime(CMTimeMake(0, 1))//调至最开始时间
        player?.play()
    }
    //MARK: 导航栏按钮监听
    func homeDetailNavBarDelegate(index: Int) {
        switch index {
        case 1://返回
            player?.pause()
            playerItem?.cancelPendingSeeks()
            playerItem?.asset.cancelLoading()
            dismissViewControllerAnimated(true, completion: nil)
        case 2://关注
            printLog("2")
            addGuanZhu()
        case 3:
            printLog("3")
        case 4://举报
            jubao()
            printLog("4")
        case 5://分享
            printLog("5")
        case 6://头像点击
            printLog("6")
            iconClick()
        default: break
            
        }
    }
    //MARK:添加关注
    func addGuanZhu() {
        let user = UserTool.sharedInstance.user
        if let targetId = videoModel?.user?.id {
            let parameters = ["myId":user.id!, "targetId":targetId]
            Alamofire.request(.GET, AddGuanZhuIP, parameters: parameters)
                .validate()
                .responseJSON { response in
                    switch response.result {
                    case .Success:
                        printLog("关注返回 Successful")
                        printLog(response.result.value)
                        MBProgressHUD.showSuccess("关注成功")
                    case .Failure(let error):
                        printLog(error)
                    }
            }
        }
        
    }
    //MARK:举报
    func jubao() {
        let alert = UIAlertController(title: nil, message: nil, preferredStyle: UIAlertControllerStyle.ActionSheet)
        let action1 = UIAlertAction(title: "色请暴力", style: UIAlertActionStyle.Default) { (actioin) in
            printLog("举报色请暴力")
        }
        let action2 = UIAlertAction(title: "虚假广告", style: UIAlertActionStyle.Default) { (actioin) in
            printLog("举报虚假广告")
        }
        let action3 = UIAlertAction(title: "加入黑名单", style: UIAlertActionStyle.Default) { (actioin) in
            printLog("加入黑名单")
        }
        let action4 = UIAlertAction(title: "取消", style: UIAlertActionStyle.Default) { (actioin) in
            printLog("取消举报")
        }
        alert.addAction(action1)
        alert.addAction(action2)
        alert.addAction(action3)
        alert.addAction(action4)
        
        presentViewController(alert, animated: true, completion: nil)
    }
    //MARK:头像点击
    func iconClick() {
        //暂停视频
        player?.pause()
        playStatus = false
        //弹出个人控制器
        let layout =  UICollectionViewFlowLayout()
        layout.itemSize = CGSizeMake(100, 100)
        let personVC = PersonViewController(collectionViewLayout: layout)
        personVC.vcType = 1
        personVC.modelUser = videoModel?.user
        presentViewController(personVC, animated: true, completion: nil)
    }
    //MARK: tableView 数据源方法
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell: UITableViewCell = tableView.dequeueReusableCellWithIdentifier(ID)!
        cell.textLabel?.text = "这是第\(indexPath.row)条评论。"
        return cell
    }
    
    //MARK:view即将出现 继续播放（主要是用于从个人页面返回）
    override func viewWillAppear(animated: Bool) {
        playStatus = true
        player?.play()
    }
    
    //下面的方式也可以添加headerView(下面2个方法必须同时实现) 但是存在一个问题，该种方式添加的header不会随table滚动
//    func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
//        print("playerView.frame",playerView.frame)
//        return playerView
//    }
//    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
//        return playerView.frame.height
//    }
//    MARK:销毁监听
    deinit{
        print("销毁")
        playerItem?.removeObserver(self, forKeyPath: "status")
        playerItem?.removeObserver(self, forKeyPath: "loadedTimeRanges")
        NSNotificationCenter.defaultCenter().removeObserver(self)
    }
}
