//
//  DemoModels.swift
//  AtAllChatDemo
//
//  Created by Chance on 2017/11/22.
//  Copyright © 2017年 blocktree. All rights reserved.
//

import Foundation
import AIChatKit
import AIPushDepOCKit
import AIPushKit


/// 获取用户用例数据
///
/// - Returns:
func GetUsers() -> [AIUserInfo] {
    let li = AIUserInfo()
    li.username = "lilei@atall.io"
    li.nickname = "Li Lei"
    li.avatarUrl = "https://www.exx.com/src/images/userhead/u013.jpg"
    li.userkey = AICommonCrypto.sha256(li.username + AIPush.getAppKey())
//    li.userkey = "7fbcd19ecfeda32173a9e48abd2bb80a8bd34b6455b0c81faae067c239a88d36"
    
    let han = AIUserInfo()
    han.username = "hanmeimei@atall.io"
    han.nickname = "Han Meimei"
    han.avatarUrl = "https://www.exx.com/src/images/userhead/u014.jpg"
    han.userkey = AICommonCrypto.sha256(han.username + AIPush.getAppKey())
    
    return [li, han]
}
