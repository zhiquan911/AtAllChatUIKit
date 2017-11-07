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
    
    
    /// 单元格的尺寸配置
    ///
    /// - Parameter index:
    /// - Returns:
    override open func sizeForItem(at index: Int) -> CGSize {
        return CGSize(width: collectionContext!.containerSize.width, height: ATChatMessageViewCell.cellHeight)
    }
    
    
    /// 内容显示
    ///
    /// - Parameter index:
    /// - Returns:
    override open func cellForItem(at index: Int) -> UICollectionViewCell {
        
        guard let cell = collectionContext?.dequeueReusableCell(withNibName: "ATChatMessageViewTextCell", bundle: nil, for: self, at: index) as? ATChatMessageViewCell else {
                                                                                fatalError()
        }
        
        var lblName: UILabel
        var lblText: UILabel
        var progressView: UIActivityIndicatorView
        var buttonUserAvatar: UIButton
        
        switch message.messageSourceType {
        //发送方
        case ATMessageItemSourceType.send:
            lblName = cell.labelUserNameLeft
            lblText = cell.labelMessageTextLeft
            progressView = cell.progressViewLeft
            buttonUserAvatar = cell.buttonUserAvatarLeft
            cell.viewMessageLeft.isHidden = false
            cell.viewMessageRight.isHidden = true
        //接收方
        case ATMessageItemSourceType.receive:
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
//            cell.buttonUserAvatar.imageView?.af_setImageWithURL(NSURL(string: message.avatarUrl)!, placeholderImage: UIImage(named: "avator"))
//        }
        
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
