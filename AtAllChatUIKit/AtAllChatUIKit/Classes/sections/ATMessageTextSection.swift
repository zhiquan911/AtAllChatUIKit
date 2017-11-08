//
//  ATMessageTextSection.swift
//  AtAllChatUIKit
//
//  Created by Chance on 2017/11/6.
//  Copyright © 2017年 atall. All rights reserved.
//

import UIKit
import IGListKit

/// 文本消息分区
open class ATMessageTextSection: ListSectionController {

    private var message: ATMessageItem!
    
    override init() {
        super.init()
    }
    
    /// 单元格的尺寸配置
    ///
    /// - Parameter index:
    /// - Returns:
    override open func sizeForItem(at index: Int) -> CGSize {
        let constrainedSize = CGSize(
            width: collectionContext!.containerSize.width * 0.7,
                                     height: CGFloat.greatestFiniteMagnitude)
        //计算消息内容的实际高度
        var contentSize = self.message.text.textSizeWithFont(
            ATChatMessageViewCell.font, constrainedToSize: constrainedSize)
//        NSLog("contentSize.height 1 = \(contentSize.height)")
        contentSize.height = contentSize.height + 90
//        NSLog("contentSize.height 2 = \(contentSize.height)")
//        NSLog("message = \(self.message.text)")
        return CGSize(width: collectionContext!.containerSize.width, height: contentSize.height)
    }
    
    
    /// 内容显示
    ///
    /// - Parameter index:
    /// - Returns:
    override open func cellForItem(at index: Int) -> UICollectionViewCell {
        
        guard let cell = collectionContext?.dequeueReusableCell(withNibName: "ATChatMessageViewTextCell", bundle: Bundle(for: self.classForCoder), for: self, at: index) as? ATChatMessageViewCell else {
                                                                                fatalError()
        }
        
        self.configureCell(cell)
        
        return cell
    }
    
   
    /// 更新单元格元素
    ///
    /// - Parameter object:
    override open func didUpdate(to object: Any) {
        guard let object = object as? ATMessageItem else {
            return
        }
        self.message = object
    }
    
}


// MARK: - 实现通用的委托
extension ATMessageTextSection: ATMessageSectionProtocal {
    
    /// 配置单元格内容
    ///
    /// - Parameter cell:
    func configureCell(_ cell: UICollectionViewCell) {
        
        var lblName: UILabel
        var lblText: UILabel
        var progressView: UIActivityIndicatorView
        var buttonUserAvatar: UIButton
        
        let cell = cell as! ATChatMessageViewCell
        
        switch message.messageSourceType {
        //对方作为接收
        case ATMessageItemSourceType.receive:
            lblName = cell.labelUserNameLeft
            lblText = cell.labelMessageTextLeft
            progressView = cell.progressViewLeft
            buttonUserAvatar = cell.buttonUserAvatarLeft
            cell.viewMessageLeft.isHidden = false
            cell.viewMessageRight.isHidden = true
            
        //自己作为发送
        case ATMessageItemSourceType.send:
            lblName = cell.labelUserNameRight
            lblText = cell.labelMessageTextRight
            progressView = cell.progressViewRight
            buttonUserAvatar = cell.buttonUserAvatarRight
            cell.viewMessageLeft.isHidden = true
            cell.viewMessageRight.isHidden = false
        }
        
        // 配置显示时间戳
        //        self.configureTimestamp(indexPath, cell: cell, message: message)
        // 配置显示用户名
        lblName.text = message.senderName
        // 配置显示消息内容
        lblText.text = message.text
        // 配置显示消息内容
        let shortTime = Date.getShortTimeByStamp(message.timestamp)
        cell.labelTimeStamp.text = shortTime;
        
        // 配置加载状态
        if self.message.sended {
            progressView.stopAnimating()
            progressView.isHidden = true
        } else {
            progressView.isHidden = false
            progressView.startAnimating()
        }
        
        //用户头像
        if message.avatar != nil {
            buttonUserAvatar.setImage(message.avatar!, for: .normal)
        }
        //        else {
        //            cell.buttonUserAvatar.imageView?.af_setImageWithURL(NSURL(string: message.avatarUrl)!, placeholderImage: UIImage.loadImage(named: "avator"))
        //        }
        
    }
    
}
