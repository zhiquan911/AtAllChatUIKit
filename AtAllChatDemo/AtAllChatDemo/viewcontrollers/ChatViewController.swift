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

    override func viewDidLoad() {
        super.viewDidLoad()
        self.loadMessageFromFile()
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
            
            messages.append(msg)
        }
        
        self.chatView.add(chatMessages: messages, delayLoad: 1)
       
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
