//
//  ContactsViewController.swift
//  AtAllChatDemo
//
//  Created by Chance on 2017/11/20.
//  Copyright © 2017年 blocktree. All rights reserved.
//

import UIKit
import AsyncDisplayKit
import AIChatKit

class ContactsViewController: ASViewController<ASDisplayNode> {
    
    lazy var friends: [AIUserInfo] = {
        return GetUsers()
    }()
    
    var userkey = ""

    var tableNode: ASTableNode {
        return node as! ASTableNode
    }
    
    init() {
        super.init(node: ASTableNode())
        tableNode.delegate = self
        tableNode.dataSource = self
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("storyboards are incompatible with truth and beauty")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Records", style: .plain, target: self, action: #selector(self.gotoConversations))
    }

    @objc func gotoConversations() {
        let vc = ConversationsViewController()
        vc.userkey = self.userkey
        self.navigationController?.pushViewController(vc, animated: true)
    }

}

extension ContactsViewController: ASTableDelegate, ASTableDataSource {
    
    func tableNode(_ tableNode: ASTableNode, nodeForRowAt indexPath: IndexPath) -> ASCellNode {
        let node = ASTextCellNode()
        let user = self.friends[indexPath.row]
        node.text = user.nickname
        return node
    }
    
    func numberOfSections(in tableNode: ASTableNode) -> Int {
        return 1
    }
    
    func tableNode(_ tableNode: ASTableNode, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    func tableNode(_ tableNode: ASTableNode, didSelectRowAt indexPath: IndexPath) {
        
        
//        if indexPath.row == 0 {
//            let storyboard = UIStoryboard.init(name: "Main", bundle: nil)
//            let vc = storyboard.instantiateViewController(withIdentifier: "ChatViewController") as! ChatViewController
//            //            vc.messages = self.loadMessageFromFile()
//            self.navigationController?.pushViewController(vc, animated: true)
//        } else
//        {
            let obj = self.friends[indexPath.row]
            //建立一个会话
            let c = AIConversation()
            c.userkey = self.userkey
            c.objectkey = obj.userkey
            c.conversationName = obj.nickname
            c.conversationType = .normal
            
            let vc = ChatOnLineViewController()
            vc.conversation = c
            self.navigationController?.pushViewController(vc, animated: true)
//        }
        
    }
    
}
