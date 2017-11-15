//
//  SpinnerSectionController.swift
//  AtAllChatUIKit
//
//  Created by Chance on 2017/11/9.
//  Copyright © 2017年 atall. All rights reserved.
//

import UIKit
import IGListKit
import AsyncDisplayKit


/// 加载更多的样式
open class SpinnerSectionController: ListSectionController, ASSectionController {
    
    override init() {
        super.init()
    }
    
    
    public func nodeBlockForItem(at index: Int) -> ASCellNodeBlock {
        let node = SpinnerCell()
        return {
            return node
        }
    }
    
    
    override open func sizeForItem(at index: Int) -> CGSize {
        return ASIGListSectionControllerMethods.sizeForItem(at: index)
    }
    
    override open func cellForItem(at index: Int) -> UICollectionViewCell {
        return ASIGListSectionControllerMethods.cellForItem(at: index, sectionController: self)
    }
    
    /// 更新单元格元素
    ///
    /// - Parameter object:
    override open func didUpdate(to object: Any) {
    
    }
    
}


final class SpinnerCell: ASCellNode {
    
    var activityIndicator: ASDisplayNode!
    
    override init() {
        super.init()
        self.automaticallyManagesSubnodes = true
        let activity = ASDisplayNode(viewBlock: { () -> UIView in
            let view = UIActivityIndicatorView(activityIndicatorStyle: .gray)
            return view
        })
        self.activityIndicator = activity
        self.activityIndicator.style.preferredSize = CGSize(width: 20.0, height: 20.0)
        self.style.height = ASDimensionMake(44)
    }
    
    override func didLoad() {
        // 配置加载状态
        let progressView = self.activityIndicator.view as! UIActivityIndicatorView
        progressView.startAnimating()
    }
    
    override func layoutSpecThatFits(_ constrainedSize: ASSizeRange) -> ASLayoutSpec {
        return ASRelativeLayoutSpec(horizontalPosition: .center, verticalPosition: .center, sizingOption: .minimumHeight, child: self.activityIndicator)
    }
    
}


