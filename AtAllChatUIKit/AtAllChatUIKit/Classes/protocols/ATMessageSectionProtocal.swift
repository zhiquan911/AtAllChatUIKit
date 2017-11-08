//
//  ATMessageSectionProtocal.swift
//  AtAllChatUIKit
//
//  Created by Chance on 2017/11/8.
//  Copyright © 2017年 atall. All rights reserved.
//

import Foundation
import IGListKit

/// 消息样式分区协议，定义通用的协议方法
protocol ATMessageSectionProtocal {
    
    /// 设置单元格
    ///
    /// - Parameter cell: 单元格
    func configureCell(_ cell: UICollectionViewCell)
    
}


// MARK: - ListSectionController这个父类实现委托
extension ListSectionController {
    
    
    /// 子类实现configureCell
    ///
    /// - Parameter cell:
    func configureCellBySubclass(_ cell: UICollectionViewCell) {
        
        //刷新UI
        guard let sub = self as? ATMessageSectionProtocal else {
            return
        }
        
        sub.configureCell(cell)
    }
    
}
