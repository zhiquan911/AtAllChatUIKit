//
//  ConversationSection.swift
//  AtAllChatDemo
//
//  Created by Chance on 2017/11/22.
//  Copyright © 2017年 blocktree. All rights reserved.
//

import UIKit
import IGListKit
import AIChatKit
import AsyncDisplayKit
import AtAllChatUIKit

class ConversationSection: ListSectionController, ASSectionController {
    
    var conversation: AIConversation!
    var cell: ConversationCell?
    
    open override func numberOfItems() -> Int {
        return 1
    }
    
    public func nodeBlockForItem(at index: Int) -> ASCellNodeBlock {

        let node = ConversationCell(c: self.conversation)
        self.cell = node
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
    
    override func didSelectItem(at index: Int) {

        let vc = ChatOnLineViewController()
        vc.conversation = self.conversation
        self.viewController?.navigationController?.pushViewController(vc, animated: true)
        
        //设置会话已读
        self.conversation.setRead()
        self.cell?.unreadNode.num = ""
    }
    
    /// 更新单元格元素
    ///
    /// - Parameter object:
    override open func didUpdate(to object: Any) {
        guard let object = object as? AIConversation else {
            return
        }
        self.conversation = object
    }
}


/// 会话单元格
class ConversationCell: ASCellNode {
    
    /// 内容文字大小
    let font: UIFont = UIFont.systemFont(ofSize: 15)
    
    /// 图像最少高度
    var avatarMinHeight: CGFloat = 40
    var unreadCountWidth: CGFloat = 16
    
    /// 消息实例
    private var conversation: AIConversation!
    
    /// 用户名
    lazy var labelUserName: ASTextNode = {
        let node = ASTextNode()
        node.maximumNumberOfLines = 1
        //设置用户名
        let attrs: [NSAttributedStringKey: Any] = [NSAttributedStringKey.font: UIFont.systemFont(ofSize: 15)]
        node.attributedText = NSAttributedString(
            string: self.conversation.conversationName, attributes: attrs)
        return node
    }()
    
    /// 最后消息内容
    lazy var labelMessageText: ASTextNode = {
        let node = ASTextNode()
        node.maximumNumberOfLines = 1
        //消息内容
        let attrs: [NSAttributedStringKey: Any] = [
            NSAttributedStringKey.font: UIFont.systemFont(ofSize: 14),
            NSAttributedStringKey.foregroundColor: UIColor.lightGray
        ]
        node.attributedText = NSAttributedString(
            string: self.conversation.lastChatMessage?.content ?? "", attributes: attrs)
        return node
    }()
    
    /// 用户头像
    lazy var imageViewUserAvatar: ASNetworkImageNode = {
        //用户头像
        let imageNode = ASNetworkImageNode()
        imageNode.contentMode = .scaleAspectFit
        imageNode.backgroundColor = .clear
        imageNode.cornerRadius = 2
        imageNode.style.width = ASDimensionMake(self.avatarMinHeight)
        imageNode.style.height = ASDimensionMake(self.avatarMinHeight)
        imageNode.defaultImage = ATConstants.defaultAvatar
        
        var avatorUrl = ""
        if self.conversation.conversationType == .normal {
            avatorUrl = self.conversation.userInfo?.avatarUrl ?? ""
        } else {
            avatorUrl = self.conversation.groupInfo?.groupAvatarUrl ?? ""
        }
        imageNode.url = URL(string: avatorUrl)
        imageNode.imageModificationBlock = {
            image in
            var modifiedImage: UIImage?
            let rect = CGRect(x: 0, y: 0, width: image.size.width, height: image.size.height)
            UIGraphicsBeginImageContextWithOptions(image.size, false, UIScreen.main.scale)
            let path = UIBezierPath(roundedRect: rect, cornerRadius: 2)
            path.addClip()
            image.draw(in: rect)
            modifiedImage = UIGraphicsGetImageFromCurrentImageContext()
            UIGraphicsEndImageContext()
            return modifiedImage ?? image
        }
        
        return imageNode
    }()
    
    /// 最后会话时间
    lazy var labelTime: ASTextNode = {
        let node = ASTextNode()
        node.maximumNumberOfLines = 1
        //时间
        let attrs: [NSAttributedStringKey: Any] = [
            NSAttributedStringKey.font: UIFont.systemFont(ofSize: 12),
            NSAttributedStringKey.foregroundColor: UIColor.lightGray
        ]
        node.attributedText = NSAttributedString(
            string: self.conversation.lastSendMsgTime, attributes: attrs)
        return node
    }()
    
    
    /// 会话未阅消息数
    lazy var unreadNode: ATBagdeNumNode = {
        let node = ATBagdeNumNode(num: self.conversation.unreadCount)
        return node
    }()
    
    
    /// 分隔线
    lazy var divider: ASDisplayNode = {
        let pixelHeight = 1.0 / UIScreen.main.scale
        let node = ASDisplayNode()
        node.backgroundColor = UIColor.lightGray
        node.style.height = ASDimensionMake(pixelHeight)
        node.style.spacingBefore = 10
        return node
    }()
    
    /// 初始化单元格
    /// 后台线程在这里执行初始化
    /// - Parameter model: 消息实体
    init(c: AIConversation) {
        super.init()
        // Automatic Subnode Management
        self.automaticallyManagesSubnodes = true
        self.conversation = c
        
        //填满整个宽度
        self.style.width = ASDimensionMake("100%")
    }
    
    
    /// 完成视图加载
    /// 主线程在这里处理UIKit相关的配置
    override func didLoad() {
        
    }
    
    
    /// 布局设置
    ///
    /// - Parameter constrainedSize:
    /// - Returns:
    override func layoutSpecThatFits(_ constrainedSize: ASSizeRange) -> ASLayoutSpec {
        
     
        let nameStack = ASStackLayoutSpec.horizontal()
        nameStack.alignItems = .center
        nameStack.justifyContent = .spaceBetween
        nameStack.spacing = 8
        nameStack.children = [self.labelUserName, self.labelTime]
        nameStack.style.alignSelf = .stretch
        
        let contentStack = ASStackLayoutSpec.vertical()
        contentStack.alignItems = .start
        contentStack.justifyContent = .start
        contentStack.spacing = 4
        contentStack.children = [nameStack, self.labelMessageText]
//        contentStack.style.flexGrow = 1
        
        let cornerRadius = self.unreadCountWidth / 2
        
        //未阅数显示在右上角
        let avatarRel = ASRelativeLayoutSpec(horizontalPosition: .end, verticalPosition: .start, sizingOption: .minimumSize, child: self.unreadNode)
        let avatarInset = ASInsetLayoutSpec(insets: UIEdgeInsets(top: cornerRadius, left: 0, bottom: 0, right: cornerRadius), child: self.imageViewUserAvatar)
        let avatarWrap = ASWrapperLayoutSpec(layoutElement: avatarInset)
        let avatarAbs = ASOverlayLayoutSpec(child: avatarWrap, overlay: avatarRel)
        
        let contentStackInset = ASInsetLayoutSpec(insets: UIEdgeInsets(top: cornerRadius, left: 0, bottom: 0, right: 0), child: contentStack)
        contentStackInset.style.flexGrow = 1
        
        let avatarStack = ASStackLayoutSpec.horizontal()
        avatarStack.justifyContent = .start
        avatarStack.alignItems = .start
        avatarStack.spacing = 4
        avatarStack.children = [
            avatarAbs,
            contentStackInset
        ]
        avatarStack.style.flexGrow = 1
        avatarStack.style.width = ASDimensionMake("100%")
        
        let container = ASStackLayoutSpec.vertical()
        container.justifyContent = .start
        container.alignItems = .start
        container.children = [
            avatarStack,
            self.divider
        ]
        
        return ASInsetLayoutSpec(insets: UIEdgeInsets(top: 4, left: 10, bottom: 0, right: 10),
                                 child: container)
        
    }
    
    
    /// 进入显示访问时执行
    override func didEnterVisibleState() {
        super.didEnterVisibleState()
        
    }
    
}

class ATBagdeNumNode: ASDisplayNode {
    
    var unreadCountWidth: CGFloat = 16
    
    var num: String = "" {
        didSet {
            if num.isEmpty || num == "0" {
                self.isHidden = true
            } else {
                self.isHidden = false
            }
        }
    }
    
    
    /// 会话未阅消息数
    lazy var labelNum: ASTextNode = {
        let node = ASTextNode()
        node.maximumNumberOfLines = 1
        
        let attrs: [NSAttributedStringKey: Any] = [
            NSAttributedStringKey.font: UIFont.systemFont(ofSize: 12),
            NSAttributedStringKey.foregroundColor: UIColor.white
        ]
        
        node.attributedText = NSAttributedString(string: self.num, attributes: attrs)
        return node
    }()
    
    init(num: String) {
        super.init()
        self.automaticallyManagesSubnodes = true
        self.num = num
        if num.isEmpty || num == "0" {
            self.isHidden = true
        } else {
            self.isHidden = false
        }
    }
    
    override func layoutSpecThatFits(_ constrainedSize: ASSizeRange) -> ASLayoutSpec {
        
        let cornerRadius = self.unreadCountWidth / 2
        let unreadNodeBG = ASDisplayNode()
        unreadNodeBG.backgroundColor = UIColor.red
        unreadNodeBG.cornerRadius = cornerRadius
        
        //未阅数居中显示
        let unreadInset = ASInsetLayoutSpec(insets: UIEdgeInsetsMake(0, 4, 0, 4), child: self.labelNum)
        let centerUnread = ASCenterLayoutSpec(centeringOptions: .XY, sizingOptions: .minimumXY, child: unreadInset)
        centerUnread.style.minWidth = ASDimensionMake(self.unreadCountWidth)
        centerUnread.style.height = ASDimensionMake(self.unreadCountWidth)
        let unreadSpec = ASBackgroundLayoutSpec(child: centerUnread, background: unreadNodeBG)
        return unreadSpec
        
    }
}
