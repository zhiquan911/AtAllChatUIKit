//
//  ChatOnLineViewController.swift
//  AtAllChatDemo
//
//  Created by Chance on 2017/11/21.
//  Copyright © 2017年 blocktree. All rights reserved.
//

import UIKit
import AtAllChatUIKit
import AIChatKit
import AIPushKit
import AsyncDisplayKit

class ChatOnLineViewController: UIViewController {
    
    var chatView: ATChatMessageView!

    var allMessages = [ATMessageItem]()
    
    var conversation: AIConversation!

    var msgid: Int = 0
    
    var limit: Int = 20
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupUI()
        self.loadMessagesFromAIChat {
            [weak self](results) in
            guard let weakSelf = self else {
                return
            }
            var inverted = true
            if results.count < weakSelf.limit {
                inverted = false
                weakSelf.chatView.canLoadmore = false
            }
            weakSelf.chatView.reloadData(messages: results, animated: true, inverted: inverted)
            
        }

    }
    
    func setupUI() {
        self.view.backgroundColor = UIColor.white
        self.title = self.conversation.conversationName
        self.chatView = ATChatMessageView(frame: CGRect.zero)
        self.chatView.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(self.chatView)
        self.chatView.userkey = self.conversation.userkey   //指定一个用户ID为当前发送
        self.chatView.username = self.conversation.conversationName
        self.chatView.allowsSendVoice = false
        self.chatView.allowsSendMultiMedia = false
        self.chatView.allowInputMessage = true
        self.chatView.delegate = self
        self.chatView.shareMenuViewDelegate = self
        self.chatView.viewController = self
        
        let views: [String: Any] = [
            "chatView": self.chatView
        ]
        
        self.view.addConstraints(NSLayoutConstraint.constraints(
            withVisualFormat: "H:|[chatView]|",
            options: NSLayoutFormatOptions(),
            metrics: nil,
            views:views));
        
        self.view.addConstraints(NSLayoutConstraint.constraints(
            withVisualFormat: "V:|[chatView]|",
            options: NSLayoutFormatOptions(),
            metrics: nil,
            views:views))
        
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.chatView.viewDidAppear()
        AIChat.addListener(self)
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        self.chatView.viewDidDisappear()
        AIChat.removeListener(self)
    }
    
    deinit {
        AIChat.removeListener(self)
    }
    
    
    /// 读取聊天记录（先本地后网络更新）
    ///
    /// - Parameters:
    ///   - msgid:
    ///   - limit:
    func loadMessagesFromAIChat(msgid: Int = 0, complete: @escaping (_ result: [ATMessageItem]) -> Void) {
        
        self.conversation.getMessages(count: self.limit, lastMsgid: msgid) {
            [weak self](flag, newMessages, result) in
            if newMessages.count < self?.limit ?? 20 {
                self?.chatView.canLoadmore = false
            }
            if let netMessages = self?.convertMessageFillChat(messages: newMessages) {
                complete(netMessages)
            }
        }
        
        /*
        AIChat.getMessages(count: self.limit, lastMsgid: msgid, conversationType: .normal, role: "100") {
            [weak self](flag, newMessages, result) in
            if newMessages.count < self?.limit ?? 20 {
                self?.chatView.canLoadmore = false
            }
            if let netMessages = self?.convertMessageFillChat(messages: newMessages) {
                complete(netMessages)
            }
        }
        */
    }
    
    
    /// 转换消息
    ///
    /// - Parameter messages:
    /// - Returns:
    func convertMessageFillChat(messages: [AIChatMessage]) -> [ATMessageItem] {
        var atmessage = [ATMessageItem]()
        for aichatmsg in messages {
            let msg = ATMessageItem()
            msg.messageId = aichatmsg.msgid
            msg.text = aichatmsg.content
            msg.senderId = aichatmsg.senderkey
            msg.senderName = ""     //不显示昵称
            msg.timestamp = Int64(aichatmsg.sendTime)!
            msg.sended = true
            msg.avatarUrl = aichatmsg.senderInfo?.avatarUrl ?? ""
            if msg.senderId == self.conversation.userkey {
                msg.messageSourceType = .send
            } else {
                msg.messageSourceType = .receive
            }
            
            atmessage.append(msg)
            
        }
        return atmessage
    }
}

extension ChatOnLineViewController: ATChatMessageViewDelegate {
    
    func chatView(view: ATChatMessageView, didSendMessage messages: [ATMessageItem]) {
        for msg in messages {
            self.conversation.sendMessage(text: msg.text, callback: {
                (flag, msgid, sendTime) in
                 DispatchQueue.main.async {
//                    msg.messageId = msgid
                    msg.sended = true
                    self.chatView.reloadMessages([msg])
                }
            })
        }
    }
    
    func loadMoreMessagesScrollTotop(view: ATChatMessageView) {
        
        guard let lastMessage = self.chatView.messages.last else {
            return
        }
        
        DispatchQueue.global(qos: .default).async {
            self.loadMessagesFromAIChat(msgid: Int(lastMessage.messageId)!, complete: {
                [weak self](newMessages) in
                
                DispatchQueue.main.async {
                    self?.chatView.loadingMoreData = false
                    
                    if newMessages.count > 0 {
                        self?.chatView.add(chatMessages: newMessages,
                                          toBottomPosition: false,
                                          isScrollToBottom: false,
                                          animated: false)
                    } else {
                        self?.chatView.canLoadmore = false
                        self?.chatView.performUpdates(animated: true)
                    }
                    
                }
                
            })
            
        }
        
    }
}


extension ChatOnLineViewController: ATShareMenuViewDelegate {
    
    func numberOfShareMenuItem() -> Int {
        return 4
    }
    
    func menuItemViewForIndex(index: Int) -> ATShareMenuItemView {
        let shareMenuItem: ATShareMenuItemView
        switch index {
        case 0:
            shareMenuItem = ATShareMenuItemView(
                image: UIImage(named: "sharemore_pic")!, title: "照片")
        case 1:
            shareMenuItem = ATShareMenuItemView(
                image: UIImage(named: "sharemore_video")!, title: "拍照")
        case 2:
            shareMenuItem = ATShareMenuItemView(
                image: UIImage(named: "sharemore_videovoip")!, title: "视频")
        case 3:
            shareMenuItem = ATShareMenuItemView(
                image: UIImage(named: "sharemore_location")!, title: "位置")
        case 4:
            shareMenuItem = ATShareMenuItemView(
                image: UIImage(named: "sharemore_friendcard")!, title: "名片")
        default:
            shareMenuItem = ATShareMenuItemView(
                image: UIImage(named: "sharemore_pic")!, title: "照片")
        }
        return shareMenuItem
    }
}


// MARK: - AIChatKit相关方法实现
extension ChatOnLineViewController: AIChatListener {
    
    
    func didReceiveAIChatMessage(message: AIChatMessage,conversation: AIConversation) {
        //插入数据到列表
        let newMessages = self.convertMessageFillChat(messages: [message])
        self.chatView.add(chatMessages: newMessages,
                           toBottomPosition: true,
                           isScrollToBottom: true,
                           animated: true)

    }
    
    func didReceiveAIGroupTips(operator: AIGroupMember, group: AIGroup, type: String, members: [AIGroupMember]) {
        NSLog("AIChat didReceiveAIGroupTips")
    }
    
    func didReceiveAIGroupSystemNotify(operator: AIGroupMember, group: AIGroup, type: String, reason: String) {
        NSLog("AIChat didReceiveAIGroupSystemNotify")
    }
    
    /// 处理来自AIChatKit的消息通知
    func didConnectionChangedAIChat(isConnected: Bool) {
        NSLog("AIChat 连接服务器状态 = \(isConnected)")
    }
    
    func didReceiveAIFriendshipChange(friendship: AIFriendship, status: String) {
        NSLog("AIChat didReceiveAIFriendshipChange")
    }
    
    func didReceiveAIGroupChange(group: AIGroup, status: String) {
        NSLog("AIChat didReceiveAIGroupChange")
    }
    
}
