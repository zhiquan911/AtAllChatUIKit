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
    
    var messages = [ATMessageItem]()
    
    var userkey = "123"   //指定一个用户ID为当前发送

    override func viewDidLoad() {
        super.viewDidLoad()
        self.chatView.userkey = self.userkey   //指定一个用户ID为当前发送
        self.loadMessageFromFile()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.chatView.viewDidAppear()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        self.chatView.viewDidDisappear()
    }
    
    
    func loadMessageFromFile() {
        
        let data = try? Data(contentsOf: URL(fileURLWithPath: Bundle.main.path(forResource: "messages", ofType: "json")!))
        let jsonArray = try! JSONSerialization.jsonObject(with: data!, options: JSONSerialization.ReadingOptions.mutableLeaves) as! [AnyObject]
        
        var messages = [ATMessageItem]()
        for (index, dic) in jsonArray.enumerated() {
            let model = dic as! [String: String]
            let msg = ATMessageItem()
            msg.messageId = "\(index)"
            msg.text = model["text"] ?? ""
            msg.senderId = model["senderId"] ?? ""
            msg.senderName = model["senderName"] ?? ""
            msg.timestamp = Int64(model["timestamp"]!) ?? 0
            msg.sended = true
            
            if msg.senderId == self.userkey {
                msg.messageSourceType = .send
            } else {
                msg.messageSourceType = .receive
            }
            
            messages.append(msg)
        }
        
        self.chatView.reloadData(messages: messages)
       
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
}
