//
//  ChatViewController.swift
//  AtAllChatDemo
//
//  Created by Chance on 2017/11/7.
//  Copyright © 2017年 blocktree. All rights reserved.
//

import UIKit
import AtAllChatUIKit

class ChatViewController: UIViewController {
    
    @IBOutlet var chatView: ATChatMessageView!
    
    var allMessages = [ATMessageItem]()
    
    var userkey = "123"   //指定一个用户ID为当前发送
    
    var offset: Int = 0   //当前消息的偏移量

    override func viewDidLoad() {
        super.viewDidLoad()
        self.chatView.userkey = self.userkey   //指定一个用户ID为当前发送
        self.chatView.shareMenuViewDelegate = self
        self.loadAllMessagesFromFile()          //加载用例数据
        let newMessages = self.loadMessage(offset: self.offset)
        self.chatView.reloadData(messages: newMessages)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.chatView.viewDidAppear()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        self.chatView.viewDidDisappear()
    }
    
    
    func loadAllMessagesFromFile() {
        
        let data = try? Data(contentsOf: URL(fileURLWithPath: Bundle.main.path(forResource: "messages", ofType: "json")!))
        let jsonArray = try! JSONSerialization.jsonObject(with: data!, options: JSONSerialization.ReadingOptions.mutableLeaves) as! [AnyObject]
        
        for (index, dic) in jsonArray.enumerated() {
            let model = dic as! [String: String]
            let msg = ATMessageItem()
            msg.messageId = "\(index)"
            msg.text = model["text"] ?? ""
            msg.senderId = model["senderId"] ?? ""
            msg.senderName = model["senderName"] ?? ""
            msg.timestamp = Int64(model["timestamp"]!) ?? 0
            msg.text = msg.text + "【\(index)】"
            msg.sended = true
            
            if msg.senderId == self.userkey {
                msg.messageSourceType = .send
            } else {
                msg.messageSourceType = .receive
            }
            
            self.allMessages.append(msg)
            
            if index == 59 {
                break
            }
        }
       
    }
    
    func loadMessage(offset: Int, limit: Int = 20) -> [ATMessageItem] {
        
        var newMessages = [ATMessageItem]()
        
        if offset == 60 {
            return newMessages
        }
        
        let start = offset
        var end = start + limit - 1
        if end >= self.allMessages.count {
            end = self.allMessages.count - 1
        }
        
        for index in offset...end {
            let msg = self.allMessages[index]
            
            newMessages.append(msg)
        }
        
        self.offset = end + 1
        
        return newMessages
    }
}

extension ChatViewController: ATChatMessageViewDelegate {
    
    func chatView(view: ATChatMessageView, didSendMessage messages: [ATMessageItem]) {
        
        for msg in messages {
            msg.sended = true
            msg.senderName = "LI LEI"
        }
        
        DispatchQueue.main.asyncAfter(
        deadline: DispatchTime.now() + Double(Int64(0.5 * Double(NSEC_PER_SEC))) / Double(NSEC_PER_SEC)) {
            
            self.chatView.reloadMessages(messages)
        }
        
        
    }
    
    func loadMoreMessagesScrollTotop(view: ATChatMessageView) {
        
        DispatchQueue.global(qos: .default).async {
            // fake background loading task
            sleep(2)
            DispatchQueue.main.async {
                self.chatView.loadingMoreData = false
                let newMessages = self.loadMessage(offset: self.offset)
                if newMessages.count > 0 {
                    self.chatView.add(chatMessages: newMessages,
                                      toTopPosition: true,
                                      isScrollToBottom: false,
                                      animated: false)
                } else {
                    self.chatView.canLoadmore = false
                    self.chatView.performUpdates(animated: true)
                }
                
            }
        }
        
    }
}

extension ChatViewController: ATShareMenuViewDelegate {
    
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
