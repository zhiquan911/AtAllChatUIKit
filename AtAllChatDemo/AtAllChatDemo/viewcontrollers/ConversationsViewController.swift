//
//  ConversationsViewController.swift
//  AtAllChatDemo
//
//  Created by Chance on 2017/11/20.
//  Copyright © 2017年 blocktree. All rights reserved.
//

import UIKit
import AsyncDisplayKit
import AIChatKit


class ConversationsViewController: ASViewController<ASCollectionNode> {
    
    var userkey = ""
    
    /// 列表视图
    var tableView: ASCollectionNode {
        return self.node
    }
    
    /// 列表适配器
    lazy var adapter: ListAdapter = {
        return ListAdapter(updater: ListAdapterUpdater(), viewController: self, workingRangeSize: 0)
    }()
    
    var conversations = [AIConversation]()
    
    init() {
        let layout = UICollectionViewFlowLayout()
        let collectionNode = ASCollectionNode(frame: .zero, collectionViewLayout: layout)
        super.init(node: collectionNode)
        self.adapter.setASDKCollectionNode(self.tableView)
        self.adapter.dataSource = self
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.view.alwaysBounceVertical = true
        self.getConversations()
    }
}


// MARK: - 业务方法
extension ConversationsViewController {
    
    
    /// 获取会话记录
    func getConversations() {
        AIChat.getConversations(userkey: self.userkey, count: 500) {
            (flag, conversations, count) in
            self.conversations = conversations
            self.adapter.performUpdates(animated: true, completion: nil)
        }
    }
}


// MARK: - 实现IGListAdapter数据适配
extension ConversationsViewController: ListAdapterDataSource {

    public func objects(for listAdapter: ListAdapter) -> [ListDiffable] {
        let objects = self.conversations as [ListDiffable]
        return objects
    }
    
    public func listAdapter(_ listAdapter: ListAdapter, sectionControllerFor object: Any) -> ListSectionController {
    
        return ConversationSection()
    }
    
    public func emptyView(for listAdapter: ListAdapter) -> UIView? {
        return nil
    }

}

extension AIConversation: ListDiffable {
    
    public func diffIdentifier() -> NSObjectProtocol {
        return self.conversationkey as NSObjectProtocol
    }
    
    public func isEqual(toDiffableObject object: ListDiffable?) -> Bool {
        guard self !== object else { return true }
        guard let object = object as? AIConversation else { return false }
        
        if self.conversationkey == object.conversationkey {
            return true
        } else {
            return false
        }
        
    }
    
}
