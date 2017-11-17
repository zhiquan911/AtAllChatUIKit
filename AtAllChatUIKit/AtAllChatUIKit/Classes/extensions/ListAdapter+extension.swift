//
//  ListAdapter+extension.swift
//  AtAllChatUIKit
//
//  Created by Chance on 2017/11/17.
//

import Foundation
import IGListKit
import AsyncDisplayKit

extension ListAdapter {
    
    /*
    func nodeForItem<T: ASCellNode>(
        in collectionNode: ASCollectionNode,
        at index: Int,
        for object: Any) -> T? {
        
        guard let section = self.sectionController(for: object) else {
            return nil
        }
        
        guard let cell = section.collectionContext?.cellForItem(at: index, sectionController: section) else {
            return nil
        }
        
        let indexPath = collectionNode.view.indexPath(for: cell)
        
        collectionNode.nodeForItem(at: <#T##IndexPath#>)
        
        //        section.collectionContext.
        guard let cellNode = self.tableView.nodeForItem(at: IndexPath(item: 0, section: 0)) as? ATMessageTextCell else {
            return
        }
        // 配置加载状态
        let progressView = cellNode.progress.view as! UIActivityIndicatorView
        if message.sended {
            progressView.stopAnimating()
            progressView.isHidden = true
        } else {
            progressView.isHidden = false
            progressView.startAnimating()
        }
        
        

        //刷新UI
        section.configureCellBySubclass(cell)
        
    }
     */
}
