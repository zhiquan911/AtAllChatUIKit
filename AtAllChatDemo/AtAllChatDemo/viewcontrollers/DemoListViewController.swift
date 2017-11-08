//
//  DemoListViewController.swift
//  AtAllChatDemo
//
//  Created by Chance on 2017/11/8.
//  Copyright © 2017年 blocktree. All rights reserved.
//

import UIKit
import AtAllChatUIKit

class DemoListViewController: UITableViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "DemoListCell")
        switch indexPath.row {
        case 0:
            cell?.textLabel?.text = "IGListDemo"
        case 1:
            cell?.textLabel?.text = "ChatViewDemo"
        default:
            cell?.textLabel?.text = "--"
        }
        
        return cell!
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        switch indexPath.row {
        case 0:
            let vc = self.storyboard?.instantiateViewController(withIdentifier: "IGListDemoViewController") as! IGListDemoViewController
            
            self.navigationController?.pushViewController(vc, animated: true)
        case 1:
            let vc = self.storyboard?.instantiateViewController(withIdentifier: "ChatViewController") as! ChatViewController
//            vc.messages = self.loadMessageFromFile()
            self.navigationController?.pushViewController(vc, animated: true)
        default: break
        }
        
        
    }
    
//    func loadMessageFromFile() -> [ATMessageItem] {
//
//        let data = try? Data(contentsOf: URL(fileURLWithPath: Bundle.main.path(forResource: "messages", ofType: "json")!))
//        let jsonArray = try! JSONSerialization.jsonObject(with: data!, options: JSONSerialization.ReadingOptions.mutableLeaves) as! [AnyObject]
//
//        var messages = [ATMessageItem]()
//        for (index, dic) in jsonArray.enumerated() {
//            let model = dic as! [String: String]
//            let msg = ATMessageItem()
//            msg.messageId = "\(index)"
//            msg.text = model["text"] ?? ""
//            msg.senderId = model["senderId"] ?? ""
//            msg.senderName = model["senderName"] ?? ""
//            msg.timestamp = Int64(model["timestamp"]!) ?? 0
//            msg.sended = true
//
//            messages.append(msg)
//            if index == 20 {
//                break
//            }
//        }
//
//        return messages
//
//    }
    
}

