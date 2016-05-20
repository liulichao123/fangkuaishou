//
//  HomeCollectionCell.swift
//  快手
//
//  Created by liulichao on 16/5/8.
//  Copyright © 2016年 刘立超. All rights reserved.
//

class HomeCollectionCell: UICollectionViewCell {
    var imageView: UIImageView
    var bottomView: ItemBottomView
//    var lab: UILabel!
    var model: Video? {
        didSet{
//            lab.text = "\(model?.id)"
            let urlStr = VideoPrePath + (model?.shotUrlPath)!
            let url: NSURL = NSURL(string: urlStr)!
            let image = UIImage(named: "login_bg_cover")
            imageView.sd_setImageWithURL(url, placeholderImage: image)
            imageView.layer.masksToBounds = true
//           var scale = (model?.videoOrginSize?.width)! / (model?.videoOrginSize?.height)!
            imageView.contentMode = UIViewContentMode.ScaleAspectFill//保持比例，填满但 frame 外也有。contentMode
//            if let url: nsurl = Video.
//            bottomView.iconImageView.sd_setImageWithURL(<#T##url: NSURL!##NSURL!#>, placeholderImage: <#T##UIImage!#>)
            bottomView.likeLabel.text = "❤️\(model!.likes!)"
        }
    }
    
    
    override init(frame: CGRect) {
        imageView = UIImageView(frame: CGRectMake(0, 0, frame.width, frame.height - 20))
        bottomView = ItemBottomView(frame: CGRectMake(0, imageView.frame.height, frame.width, 20))
        bottomView.backgroundColor = UIColor.whiteColor()
        super.init(frame: frame)
        
        addSubview(imageView)
        addSubview(bottomView)
        
//        lab = UILabel(frame: CGRectMake(0, 0, 150, 50))
//        lab.textColor = UIColor.whiteColor()
//        addSubview(lab)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
