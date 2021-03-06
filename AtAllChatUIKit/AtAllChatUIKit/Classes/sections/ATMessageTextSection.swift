//
//  ATMessageTextSection.swift
//  AtAllChatUIKit
//
//  Created by Chance on 2017/11/6.
//  Copyright © 2017年 atall. All rights reserved.
//

import UIKit
import IGListKit
import AsyncDisplayKit

/// 文本消息分区
open class ATMessageTextSection: ListSectionController, ASSectionController {
    
    /// 默认3分钟内的消息不显示时间
    let timeShowInterval: TimeInterval = 60 * 3
    
    
    /// 当前的消息
    var message: ATMessageItem!
    
    /// 前一条消息
    var preMessage: ATMessageItem?
    
    /// 是否翻转数据
    var inverted: Bool = false
    
    /// 是否显示接收方名字
    var showReceiverName: Bool = false
    
    /// 是否显示我方名字
    var showUserName: Bool = false
    
    /// 显示内容的单元格
    lazy var contentCell: ATMessageTextCell = {
        let node = ATMessageTextCell(model: self.message)
        node.showReceiverName = self.showReceiverName
        node.showUserName = self.showUserName
        return node
    }()
    
    
    /// 显示时间的单元格
    lazy var timeCell: ATMessageTimeCell = {
        let node = ATMessageTimeCell(time: self.message.timestamp)
        return node
    }()
    
    init(preMessage: ATMessageItem?, inverted: Bool) {
        super.init()
        self.preMessage = preMessage
        self.inverted = inverted
    }
    
    open override func numberOfItems() -> Int {
        return self.shouldDisplayTime() ? 2 : 1
    }
    
    public func nodeBlockForItem(at index: Int) -> ASCellNodeBlock {
        //列表元素排序反方向
        var node: ASCellNode
        let count = self.numberOfItems()
        
        // 表格如果翻转则先显示消息再显示时间
        if self.inverted {
            if index == 0 {
                node = self.contentCell
            } else {
                node = self.timeCell
            }
            
        } else {
            // 没有翻转，而且行数为2，先显示时间，再显示消息
            if index == 0 && count == 2 {
                node = self.timeCell
                
            } else {
                node = self.contentCell
            }
        }
        
        return {
            return node
        }
    }
    
    
    override open func sizeForItem(at index: Int) -> CGSize {
        return ASIGListSectionControllerMethods.sizeForItem(at: index)
    }
    
    override open func cellForItem(at index: Int) -> UICollectionViewCell {
        let cell = ASIGListSectionControllerMethods.cellForItem(at: index, sectionController: self)
        return cell
    }
    
    
    /// 是否显示时间
    ///
    /// - Returns:
    public func shouldDisplayTime() -> Bool {
        if self.preMessage == nil {
            return true
        }
        
        let pre = Date(timeIntervalSince1970: TimeInterval(self.preMessage!.timestamp))
        let current = Date(timeIntervalSince1970: TimeInterval(self.message.timestamp))
        let interval: TimeInterval = current.timeIntervalSince(pre)
        if(interval > self.timeShowInterval){  //超过3分钟才显示
            return true;
        }else{
            return false;
        }
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
    
    /*
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
     */
    
    
    
}

extension ATMessageTextSection: ATMessageCellProtocal {
    
    /// 更新消息
    ///
    /// - Parameter message:
    func updateMessageStatus(_ message: ATMessageItem) {
        self.message = message
        self.contentCell.didEnterVisibleState()
        self.timeCell.didEnterVisibleState()
    }
}

