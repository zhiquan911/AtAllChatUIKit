//
//  ATChatTableView.swift
//  AtAllChatUIKit
//
//  Created by Chance on 2017/11/3.
//  Copyright © 2017年 atall. All rights reserved.
//

import UIKit

open class ATChatTableView: UICollectionView {
    
    /// 是否在顶部加载更多
    var loadMoreOnTop: Bool = false

    override open var contentSize: CGSize {
        get {
            return super.contentSize
        }
        set {
            
            if !self.contentSize.equalTo(CGSize.zero) && self.loadMoreOnTop {
                if (newValue.height > self.contentSize.height) {

                    var offset: CGPoint = self.contentOffset;
                    offset.y += (newValue.height - self.contentSize.height)
                    self.contentOffset = offset
                    //重置
                    self.loadMoreOnTop = false
                }
                
            }
            super.contentSize = newValue
        }
    }

}
