//
//  HomeViewController.swift
//  快手
//
//  Created by liulichao on 16/5/3.
//  Copyright © 2016年 刘立超. All rights reserved.
//
//首页根控制器

import UIKit
import AVFoundation
import Alamofire
import SwiftyJSON

private let reuseIdentifier = "Cell"

class HomeViewController: UIViewController, LNavigationDelegate,UIScrollViewDelegate,UINavigationControllerDelegate,UIImagePickerControllerDelegate {
    //导航
    var navView: LNavigationView?
    //scrollView
    lazy var scrollView: UIScrollView = {
        return UIScrollView()
    }()
    //内容视图
    //MARK:懒加载
    //关注
    lazy var guanzhuVC: GuanZhuViewController = {
        let layout = KSCollectionLayout()
        let vc = GuanZhuViewController(collectionViewLayout: layout)
        self.addChildViewController(vc)
        vc.view.frame = CGRectMake(0, 0, self.view.frame.width, self.view.frame.height - self.navView!.frame.maxY)
        self.scrollView.addSubview(vc.view)
        return vc
    }()
 
    //发现
    lazy var faxianVC: FaxianViewController = {
        let layout = KSCollectionLayout()
        let vc = FaxianViewController(collectionViewLayout: layout)
        self.addChildViewController(vc)
        vc.view.frame = CGRectMake(self.view.frame.width, 0, self.view.frame.width, self.view.frame.height - self.navView!.frame.maxY)
        self.scrollView.addSubview(vc.view)
        return vc
    }()
    
    //同城
    lazy var tongchengVC: TongChengViewController = {
        let layout = KSCollectionLayout()
        let vc = TongChengViewController(collectionViewLayout: layout)
        self.addChildViewController(vc)
        vc.view.frame = CGRectMake(self.view.frame.width * 2, 0, self.view.frame.width, self.view.frame.height - self.navView!.frame.maxY)
       self.scrollView.addSubview(vc.view)
        return vc
    }()
    //记录当前视图控制器
    var currentVC: BaseViewController?
    
   
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    /**
     初始化
     */
    func setup() {
        //添加顺序不要改变
        //导航
        navView = LNavigationView(frame: CGRectMake(0, statusBarSize.height, view.frame.width, 41))
        navView?.backgroundColor = UIColor.init(colorLiteralRed: 250/255.0, green: 185/255.0, blue: 30/255.0, alpha: 0.8)
        navView?.delegate = self;
        view.addSubview(navView!)
        
        //scrollView
        let w = view.frame.width * 3
        let h = view.frame.height - navView!.frame.maxY
        scrollView.frame = CGRectMake(0, navView!.frame.maxY, view.frame.width, h)
        scrollView.contentSize = CGSizeMake(w, h)
        scrollView.delegate = self
        //设置tag，防止和collectionView 中scrollview冲突
        scrollView.tag = 1
        scrollView.contentOffset = CGPointMake(view.frame.width, 0)
        scrollView.contentInset = UIEdgeInsetsMake(0, 0, 0, 0)
        scrollView.bounces = false
        scrollView.pagingEnabled = true
        view.addSubview(scrollView)
        
        //记录当前显示出的view
        currentVC = faxianVC
        //导航
//        navView!.navBtnMoveToIndex(2)
        
        
    }
    
    //MAEK:UIScrollView代理
    func scrollViewDidEndDecelerating(scrollView: UIScrollView) {
        if scrollView.tag != 1 {
            return
        }
        //获取当前滚动到的位置转化为页数(1-3)
        let page = Int(scrollView.contentOffset.x / scrollView.frame.size.width) + 1;
        navView!.navBtnMoveToIndex(page)
    }
   
    func scrollViewDidScroll(scrollView: UIScrollView) {
        if scrollView.tag != 1 {
            return
        }
        let scale = scrollView.contentOffset.x / (scrollView.bounds.width * 2)
        navView!.moveToScale(scale)
        if scrollView.contentOffset.x > scrollView.bounds.width {//左滑 （必须是>=，不能去掉=）
            currentVC = tongchengVC
        } else if scrollView.contentOffset.x < scrollView.bounds.width {
             currentVC = guanzhuVC
        } else {
           //相等时不处理
        }
    }
    //工具方法
    func scrollViewMoveToIndex(index: Int){
        UIView.animateWithDuration(0.3) { 
            self.scrollView.contentOffset.x = self.scrollView.bounds.width * CGFloat(index-1)
        }
    }
    
    // MARK: 导航器代理方法
    func navButtonClick(button: UIButton) {
        switch button.tag {
        case 0:
            //发送通知告诉父控制器
            NSNotificationCenter.defaultCenter().postNotificationName(leftBtnClickNotificatioin, object: nil)
        case 1:
            currentVC = guanzhuVC
            navView!.navBtnMoveToIndex(button.tag)
            scrollViewMoveToIndex(button.tag)
        case 2:
            currentVC = faxianVC
            navView!.navBtnMoveToIndex(button.tag)
            scrollViewMoveToIndex(button.tag)
        case 3:
            currentVC = tongchengVC
            navView!.navBtnMoveToIndex(button.tag)
            scrollViewMoveToIndex(button.tag)
        case 4:
            print("录像")
            //添加视频
             addVideo()
        default://默认发现
            currentVC = faxianVC
 

        }
    }
    //MARK:上传视频
    func addVideo() -> HomeVideo {
        //注意，需要设置该控制器为root控制器的子控制器，否则会提示警告
        //Presenting view controllers on detached view controllers is discouraged <Âø´Êâã.HomeViewController:
        let imagePickerVc: UIImagePickerController = UIImagePickerController()
        imagePickerVc.sourceType = UIImagePickerControllerSourceType.PhotoLibrary
//        imagePickerVc.mediaTypes = ["public.movie", "public.image"]
        imagePickerVc.mediaTypes = ["public.movie"]
        imagePickerVc.delegate = self
        presentViewController(imagePickerVc, animated: true, completion: nil)
        
        return HomeVideo()
    }
    //MARK: imagepickerViewf代理
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]) {
//        print(info)
        /** info:
         NSString *const UIImagePickerControllerMediaType;// 媒体类型
         NSString *const UIImagePickerControllerOriginalImage;// 原始未编辑的图像
         NSString *const UIImagePickerControllerEditedImage;// 编辑后的图像
         NSString *const UIImagePickerControllerCropRect;// 源图像可编辑(有效?)区域
         NSString *const UIImagePickerControllerMediaURL;// 视频的路径
         NSString *const UIImagePickerControllerReferenceURL;// 原始选择项的URL
         NSString *const UIImagePickerControllerMediaMetadata;// 只有在使用摄像头并且是图像类型的时候有效.包含选择图像信息的字典类型复制代码
         **/
         let mediaURL: NSURL = info["UIImagePickerControllerMediaURL"] as! NSURL
        handleMedia(mediaURL, picker: picker)
        
    }
    /**
     处理视频
     - parameter mediaURL:
     - parameter picker:
     */
    func handleMedia(mediaURL: NSURL, picker: UIImagePickerController) {
        //计算大小
        let datasize = Double(FileTool.fileSizeAtPath(mediaURL.path)) / (1024.0 * 1024.0)
        //上传大小限制
        if datasize > 20 {
            print("datasize:",datasize,"文件太大。。。不能选取")
            FileTool.removeFileAtPath(mediaURL.path)
            let alert: UIAlertController = UIAlertController(title: "提示", message: "文件太大，不能选取", preferredStyle: UIAlertControllerStyle.Alert)
            
            picker.presentViewController(alert, animated: false, completion: {
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, Int64(1.0 * Double(NSEC_PER_SEC))), dispatch_get_main_queue(), {
                    alert.dismissViewControllerAnimated(true, completion: {
                        //不符合要求也退出选择
                    picker.dismissViewControllerAnimated(true, completion: nil)
                        return
                    })
                })
            })
            return
        }
        //返回主线程刷新UI
        dispatch_async(dispatch_get_main_queue(), {
            picker.dismissViewControllerAnimated(true, completion: {
                
//                let time: NSTimeInterval = 2.0
//                let delay = dispatch_time(DISPATCH_TIME_NOW,
//                    Int64(time * Double(NSEC_PER_SEC)))
//                dispatch_after(delay, dispatch_get_main_queue()) {
//                     MBProgressHUD.hideHUD()
//                }
            })
        })
        //符合上传要求
        MBProgressHUD.showSuccess("后台正在上传")
        //耗时操作 开启异步
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0)) {
            let asset: AVURLAsset = AVURLAsset(URL: mediaURL, options: [AVURLAssetPreferPreciseDurationAndTimingKey: false])
            //获取视频缩略图
            let assetGerator: AVAssetImageGenerator = AVAssetImageGenerator(asset: asset)
            assetGerator.appliesPreferredTrackTransform = true//ture 会自动旋转
            let time = CMTimeMakeWithSeconds(0, 600)
            var actualTime: CMTime = CMTimeMake(0, 0)
            var image: CGImageRef!
            do{
                image = try assetGerator.copyCGImageAtTime(time, actualTime: &actualTime)
            }catch let error as NSError{
                print(error)
            }
            //缩略图
            let uiImage = UIImage(CGImage: image)
            //视频时长
            let second = Int(asset.duration.value) / Int(asset.duration.timescale)
            print("视频时长(单位秒):",second )
            let filePath = ImageTool.imageWriteTifile(uiImage)
            let videoShot = Modeltool.modelWihtImagePath(filePath)
            let imageUrl = NSURL.init(fileURLWithPath: filePath)
            videoShot.videoOrginSize = uiImage.size//设置视频宽高
            videoShot.videoURLPath = mediaURL.path
            let scale: CGFloat = (videoShot.videoOrginSize?.width)! / videoShot.videoOrginSize!.height //宽高比
            //发送到服务器
            let user = UserTool.sharedInstance.user!
            //注意此处不能拼接可选类型，否则会出错 打印带有option....， 不符合int id类型
            let userid = (user.id)!
            let url = "\(UploadVideoIP)?userId=\(userid)&size=\(datasize)&timeLength=\(second)&scale=\(scale)"
            printLog(url)
            Alamofire.upload(
                .POST,
                url,
                multipartFormData: { multipartFormData in
                    //下面上传方式必须一致 ，否则会报错
                    multipartFormData.appendBodyPart(fileURL: mediaURL, name: "video")
                    multipartFormData.appendBodyPart(fileURL: imageUrl, name: "image")
                },
                encodingCompletion: { encodingResult in
                    switch encodingResult {
                    case .Success(let upload, _, _):
                        upload.responseJSON { response in
                            print("返回数据成功response：",response)
                            let JSON = response.result.value
                            if JSON!["status"] as? Int == 200 {
                                MBProgressHUD.showSuccess("上传成功")
                            }
                            //删除本地缓存
                            dispatch_async(dispatch_get_global_queue(0, 0), {
                                FileTool.removeFileAtPath(filePath)
                                FileTool.removeFileAtPath(mediaURL.path)
                            })
                        }
                    case .Failure(let encodingError):
                        print("返回数据失败")
                        print(encodingError)
                        //删除本地缓存
                        dispatch_async(dispatch_get_global_queue(0, 0), {
                            FileTool.removeFileAtPath(filePath)
                            FileTool.removeFileAtPath(mediaURL.path)
                        })
                    }
                }
            )
            
            
        }
        

        
    }
    




    

}
