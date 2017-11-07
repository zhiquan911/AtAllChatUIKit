//
//  ATChatMessageViewCellCollectionViewCell.swift
//  AtAllChatUIKit
//
//  Created by Chance on 2017/11/6.
//  Copyright © 2017年 atall. All rights reserved.
//

import UIKit


/// 消息列表单元格视图
public class ATChatMessageViewCell: UICollectionViewCell {
    
    static let kDefaultImage = UIImage.loadImage(named: "PhotoDownload")!
    
    @IBOutlet public var labelTimeStamp: UILabel!
    @IBOutlet public var viewTimeStamp: UIView!
    
    /***** 左边用户 *****/
    @IBOutlet public var viewMessageLeft: UIView!
    @IBOutlet public var labelUserNameLeft: UILabel!
    @IBOutlet public var labelMessageTextLeft: UILabel!
    @IBOutlet public var buttonUserAvatarLeft: UIButton!
    @IBOutlet public var viewBubbleLeft: UIView!
    @IBOutlet public var progressViewLeft: UIActivityIndicatorView!
    @IBOutlet public var imageViewVoicePlayedLeft: UIImageView!
    @IBOutlet public var buttonErrorLeft: UIButton!
    @IBOutlet public var labelVoiceDurationLeft: UILabel!
//    @IBOutlet public var imageViewAnimationVoiceLeft: SCVoicePlayImageView!
//    @IBOutlet public var imageViewPhotoLeft: BubblePhotoImageView!
    @IBOutlet public var labelProgressLeft: UILabel!
 
    /***** 右边用户 *****/
    @IBOutlet public var viewMessageRight: UIView!
    @IBOutlet public var labelUserNameRight: UILabel!
    @IBOutlet public var labelMessageTextRight: UILabel!
    @IBOutlet public var buttonUserAvatarRight: UIButton!
    @IBOutlet public var viewBubbleRight: UIView!
    @IBOutlet public var progressViewRight: UIActivityIndicatorView!
    @IBOutlet public var imageViewVoicePlayedRight: UIImageView!
    @IBOutlet public var buttonErrorRight: UIButton!
    @IBOutlet public var labelVoiceDurationRight: UILabel!
//    @IBOutlet public var imageViewAnimationVoiceRight: SCVoicePlayImageView!
//    @IBOutlet public var imageViewPhotoRight: BubblePhotoImageView!
    @IBOutlet public var labelProgressRight: UILabel!
    
    var indexPath: NSIndexPath!
    
    //布局约束
    @IBOutlet var viewTimestampLeftMarginContraints: NSLayoutConstraint!
    @IBOutlet var viewTimestampRightMarginContraints: NSLayoutConstraint!
    @IBOutlet var viewTimestampTopMarginContraints: NSLayoutConstraint!
    @IBOutlet var viewTimestampBottomMarginContraints: NSLayoutConstraint!
    @IBOutlet var bubbleViewWidthContraints: NSLayoutConstraint!
    
    
    //语音消息的背景长度根据语音时长正比变化，最大宽为200，最小宽为66，最大录音时长60秒
    let maxBubbleVoiceWdith: CGFloat = 200
    let minBubbleVoiceWdith: CGFloat = 66
    let maxVoiceDuration: Float = 60.0
    
    /// 单元格高度
    static let cellHeight: CGFloat = 100
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        self.setupUI()
    }
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override public func awakeFromNib() {
        super.awakeFromNib()
        self.setupUI()
    }
    
    
    /// 配置UI及布局
    func setupUI() {
        self.viewTimeStamp.layer.cornerRadius = 3
        self.viewTimeStamp.layer.masksToBounds = true
        self.progressViewLeft.hidesWhenStopped = true
        self.progressViewRight.hidesWhenStopped = true
    }
    
    
    override public func preferredLayoutAttributesFitting(_ layoutAttributes: UICollectionViewLayoutAttributes) -> UICollectionViewLayoutAttributes {
        setNeedsLayout()
        layoutIfNeeded()
        let size = contentView.systemLayoutSizeFitting(layoutAttributes.size)
        var newFrame = layoutAttributes.frame
        // note: don't change the width
        newFrame.size.height = ceil(size.height)
        layoutAttributes.frame = newFrame
        return layoutAttributes
    }
}
