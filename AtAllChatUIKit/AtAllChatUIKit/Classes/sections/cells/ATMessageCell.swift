//
//  ATMessageCell.swift
//  AtAllChatUIKit
//
//  Created by Chance on 2017/11/13.
//

import Foundation
import AsyncDisplayKit

class ATMessageTextCell: ASCellNode {
    
    /// 内容文字大小
    static let font: UIFont = UIFont.systemFont(ofSize: 14)
    
    /// 图像最少高度
    var avatarMinHeight: CGFloat = 40
    
    /// 消息实例
    var message: ATMessageItem!
    
    /// 是否显示接收方名字
    var showReceiverName: Bool = false
    
    /// 是否显示我方名字
    var showUserName: Bool = false
    
    /// 用户名
    lazy var labelUserName: ASTextNode = {
        let node = ASTextNode()
        node.maximumNumberOfLines = 1
        return node
    }()
    
    /// 消息内容
    lazy var labelMessageText: ASTextNode = {
        let node = ASTextNode()
        node.maximumNumberOfLines = 0
        return node
    }()
    
    /// 用户头像
    lazy var imageViewUserAvatar: ASNetworkImageNode = {
        let imageNode = ASNetworkImageNode()
        imageNode.contentMode = .scaleAspectFit
        imageNode.backgroundColor = .clear
        return imageNode
    }()
    
    
    /// 消息内容的背景图
    lazy var viewBubble: ASImageNode = {
        let node = ASImageNode()
        return node
    }()
    
    
    /// 重试按钮
    lazy var buttonError: ASButtonNode = {
        let node = ASButtonNode()
        node.setImage(UIImage.loadImage(named: "poi_Fail"), for: .normal)
        node.isHidden = true
        return node
    }()
    
    
    /// 发送进度loading
    lazy var progress: ASDisplayNode = {
        let node = ASDisplayNode(viewBlock: { () -> UIView in
            let v = UIActivityIndicatorView(activityIndicatorStyle: UIActivityIndicatorViewStyle.gray)
            v.startAnimating()
            return v
        })
        return node
    }()
    
    
    /// 初始化单元格
    /// 后台线程在这里执行初始化
    /// - Parameter model: 消息实体
    init(model: ATMessageItem,
         showReceiverName: Bool = false,
         showUserName: Bool = false) {
        super.init()
        // Automatic Subnode Management
        self.automaticallyManagesSubnodes = true
        self.imageViewUserAvatar.style.width = ASDimensionMake(self.avatarMinHeight)
        self.imageViewUserAvatar.style.height = ASDimensionMake(self.avatarMinHeight)
        self.progress.style.preferredSize = CGSize(width: 20, height: 20)
        self.buttonError.style.preferredSize = CGSize(width: 20, height: 20)
        
        self.message = model
        self.showReceiverName = showReceiverName
        self.showUserName = showUserName
        
        switch self.message.messageSourceType {
        //对方作为接收
        case ATMessageItemSourceType.receive:
            self.viewBubble.image = UIImage.loadImage(named: "weChatBubble_Receiving_Solid")
        //自己作为发送
        case ATMessageItemSourceType.send:
            self.viewBubble.image = UIImage.loadImage(named: "weChatBubble_Sending_Solid")
        }
        
        //设置头像
        let attrs = [NSAttributedStringKey.font: ATMessageTextCell.font]
        self.labelUserName.attributedText = NSAttributedString(string: self.message.senderName, attributes: attrs)
        
        /* 支持HTML富文本
         do{
         let attrStr = try NSAttributedString(data: self.message.text.data(using: String.Encoding.unicode, allowLossyConversion: true)!, options: [NSAttributedString.DocumentReadingOptionKey.documentType : NSAttributedString.DocumentType.html], documentAttributes: nil)
         
         self.labelMessageText.attributedText = attrStr
         }catch let error as NSError {
         print(error.localizedDescription)
         self.labelMessageText.attributedText = NSAttributedString(string: self.message.text, attributes: attrs)
         }
         */
        
        //消息内容
        self.labelMessageText.attributedText = NSAttributedString(string: self.message.text, attributes: attrs)
        
        //用户头像
        self.imageViewUserAvatar.defaultImage = ATConstants.defaultAvatar
        self.imageViewUserAvatar.url = URL(string: self.message.avatarUrl)
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
        
        var contentInsets = UIEdgeInsets.zero
        var usernameInsets = UIEdgeInsets.zero
        
        let avatarStack = ASStackLayoutSpec.horizontal()
        avatarStack.justifyContent = .start
        avatarStack.alignItems = .start
        avatarStack.spacing = 8
        
        let nameStack = ASStackLayoutSpec.vertical()
        nameStack.alignItems = .stretch
        nameStack.justifyContent = .center
        nameStack.spacing = 0
        nameStack.style.flexShrink = 1
        nameStack.style.flexGrow = 1
        
        let contentStack = ASStackLayoutSpec.horizontal()
        contentStack.alignItems = .center
        contentStack.justifyContent = .start
        contentStack.spacing = 0
        contentStack.style.flexGrow = 1
        contentStack.style.alignSelf = .stretch
        contentStack.style.minHeight = ASDimensionMake(self.avatarMinHeight)
        
        let statusLayout = ASWrapperLayoutSpec(layoutElements: [
            self.buttonError,
            self.progress
            ])
        
        statusLayout.style.flexGrow = 1
        statusLayout.style.minWidth = ASDimensionMake(36)
        
        
        let contentLayout = ASBackgroundLayoutSpec()
        var avatarRel: ASRelativeLayoutSpec
        
        switch self.message.messageSourceType {
        //对方作为接收
        case ATMessageItemSourceType.receive:
            
            //内容对齐方向
            avatarStack.justifyContent = .start
            nameStack.alignItems = .start
            
            usernameInsets = UIEdgeInsetsMake(0, 8, 0, 0)
            if self.showReceiverName {
                nameStack.children?.append(ASInsetLayoutSpec(insets: usernameInsets, child: self.labelUserName))
            }
            
            contentInsets = UIEdgeInsets(top: 12, left: 18, bottom: 12, right: 12)
            contentStack.children = [contentLayout, statusLayout]
            
            //头像在左边
            avatarStack.children = [
                self.imageViewUserAvatar,
                nameStack
            ]
            
            //左上对齐
            avatarRel = ASRelativeLayoutSpec(horizontalPosition: .start, verticalPosition: .start, sizingOption: .minimumHeight, child: avatarStack)
            
        //自己作为发送
        case ATMessageItemSourceType.send:
            
            avatarStack.justifyContent = .end
            nameStack.alignItems = .end
            
            usernameInsets = UIEdgeInsetsMake(0, 0, 0, 8)
            if self.showUserName {
                nameStack.children?.append(ASInsetLayoutSpec(insets: usernameInsets, child: self.labelUserName))
            }
            
            contentInsets = UIEdgeInsets(top: 12, left: 12, bottom: 12, right: 18)
            contentStack.children = [statusLayout, contentLayout]
            
            //头像在右边
            avatarStack.children = [
                nameStack,
                self.imageViewUserAvatar
            ]
            
            //右上对齐
            avatarRel = ASRelativeLayoutSpec(horizontalPosition: .end, verticalPosition: .start, sizingOption: .minimumHeight, child: avatarStack)
        }
        
        // 消息内容布局约束
        let textInsetSpec = ASInsetLayoutSpec(insets: contentInsets, child: self.labelMessageText)
        contentLayout.child = textInsetSpec
        contentLayout.background = self.viewBubble
        contentLayout.style.flexShrink = 1
        
        nameStack.children?.append(contentStack)
        
        return ASInsetLayoutSpec(insets: UIEdgeInsets(top: 8, left: 8, bottom: 8, right: 8),
                                 child: avatarRel)
        
    }
    
    
    /// 进入显示访问时执行
    override func didEnterVisibleState() {
        super.didEnterVisibleState()
        // UIActivityIndicatorView 带有动画效果，在后台线程会被停止，所以加入到监听显示状态下才执行动画
        // 配置加载状态
        let progressView = self.progress.view as! UIActivityIndicatorView
        if self.message.sended {
            progressView.stopAnimating()
            progressView.isHidden = true
        } else {
            progressView.isHidden = false
            progressView.startAnimating()
        }
    }
    
}


/// 时间单元格
class ATMessageTimeCell: ASCellNode {
    
    /// 内容文字大小
    static let font: UIFont = UIFont.systemFont(ofSize: 12)
    
    /// 时间戳
    private var timestamp: Int64 = 0
    
    /// 时间
    lazy var labelTime: ASTextNode = {
        let node = ASTextNode()
        node.maximumNumberOfLines = 1
        return node
    }()
    
    init(time: Int64) {
        super.init()
        self.automaticallyManagesSubnodes = true
        self.timestamp = time
        //设置时间
        let attrs = [
            NSAttributedStringKey.font: ATMessageTextCell.font,
            NSAttributedStringKey.foregroundColor: UIColor.white,
            ]
        self.labelTime.attributedText = NSAttributedString(string: Date.getShortTimeByStamp(timestamp), attributes: attrs)
        self.style.minHeight = ASDimensionMake(30)
    }
    
    override func didLoad() {
        
    }
    
    override func layoutSpecThatFits(_ constrainedSize: ASSizeRange) -> ASLayoutSpec {
        let insetSpec = ASInsetLayoutSpec(insets: UIEdgeInsetsMake(4, 8, 4, 8), child: self.labelTime)
        let backgroundNode = ASDisplayNode()
        backgroundNode.backgroundColor = UIColor(white: 0.8, alpha: 1)
        backgroundNode.cornerRadius = 4
        let backgroundSpec = ASBackgroundLayoutSpec(child: insetSpec, background: backgroundNode)
        let containerInset = ASInsetLayoutSpec(insets: UIEdgeInsets(top: 16, left: 0, bottom: 8, right: 0), child: backgroundSpec)
        return ASRelativeLayoutSpec(horizontalPosition: .center, verticalPosition: .end, sizingOption: .minimumHeight, child: containerInset)
    }
    
    
}
