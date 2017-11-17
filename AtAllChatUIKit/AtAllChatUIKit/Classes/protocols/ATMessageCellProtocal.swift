//
//  ATMessageCellProtocal.swift
//  AtAllChatUIKit
//
//  Created by Chance on 2017/11/8.
//  Copyright © 2017年 atall. All rights reserved.
//

import Foundation
import AsyncDisplayKit

/// 消息样式分区协议，定义通用的协议方法
protocol ATMessageCellProtocal {
    
    /// 设置单元格
    ///
    /// - Parameter cell: 单元格
    func updateMessageStatus(_ message: ATMessageItem)
    
}


